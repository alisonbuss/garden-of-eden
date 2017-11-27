#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação e desinstalação do Ruby na maquina.
# @fonts: https://rvm.io/rvm/install
#         https://github.com/rvm/ubuntu_rvm
#         https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rvm-on-ubuntu-16-04
# @example:
#       bash script-ruby.sh --action='install' --param='{"version":"2.3.1"}'
#   OR
#       bash script-ruby.sh --action='uninstall' --param='{"version":"2.3.1"}'    
#-------------------------------------------------------------#

source <(wget --no-cache -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/import.sh"); 

import.ShellScriptTools "/linux/utility.sh";

# @descr: Função principal do script-ruby.sh
# @param: 
#    action | text: (install, uninstall)
#    param | json: '{"version":"..."}'
function ScriptRuby {
    
    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");

    # @descr: Variavel de parametros JSON.
    local PARAM_JSON=$(util.getParameterValue "(--param=|-p=)" "$@");

    # @descr: Variavel da versão de instalação.
    local version=$(echo ${PARAM_JSON} | jq -r '.version');

    # @descr: Função de instalação.
    __install() {
        util.print.info "Iniciando a instalação do Ruby na maquina..."; 
        source ~/.nvm/nvm.sh;
        source ~/.profile;
        source ~/.bashrc;

        nvm install $version;
        nvm use $version;

        echo -n "Version Node.js: ";
        node -v;

        # @fonts: https://www.computerhope.com/unix/uchown.htm
        #         http://manpages.ubuntu.com/manpages/trusty/man1/chown.1.html
        # CUIDADO COM ESSE COMMANDO FILHO DA PUTA, DEU UM BUG DU INFERNU.
        # chown -R $USER:$(id -gn $USER) /home/user/.config;

	    echo -n "Version NPM: ";
        npm -v;
    }

    # @descr: Função de desinstalação.
    __uninstall() {
        util.print.info "Iniciando a desinstalação do Ruby na maquina..."; 
        
        nvm uninstall $version;
    }

    # @descr: Função é chamada qndo a um erro de tipo de ação.
    # @param: 
    #    action | text: "..." | Action não encontrado.
    __actionError() {
        local actionErr=$(util.getParameterValue "(--action=|-a=)" "$@");
        util.print.error "Erro: 'action' passado:(${actionErr}) não coincide com [install, uninstall]!";
        return 1;
    } 

    # @descr: Função principal "um construtor por exemplo".
    __initialize() {
        case ${ACTION} in
            install) { 
                __install; 
            };;
            uninstall) { 
                __uninstall;
            };;
            *) {
               __actionError "--action=${ACTION}"; 
            };;
        esac
    }

    # @descr: Chamada da função principal de inicialização do script.
    __initialize;
}

# SCRIPT INITIALIZE...
util.try; ( ScriptRuby "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}
 
exit 0;