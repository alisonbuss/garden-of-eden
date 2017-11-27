#!/bin/bash
 
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação e desinstalação do RVM na maquina.
# @fonts: https://rvm.io/rvm/install
#         https://github.com/rvm/ubuntu_rvm
#         https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rvm-on-ubuntu-16-04
#         https://stackoverflow.com/questions/3558656/how-can-i-remove-rvm-ruby-version-manager-from-my-system
# @example:
#       bash script-rvm.sh --action='install' --param='{}'
#   OR
#       bash script-rvm.sh --action='uninstall' --param='{}'    
#-------------------------------------------------------------#

source <(wget --no-cache -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/import.sh"); 

import.ShellScriptTools "/linux/utility.sh";

# @descr: Função principal do script-rvm.sh
# @param: 
#    action | text: (install, uninstall)
function ScriptRVM {

    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");

    # @descr: Função de instalação.
    __install() {
        util.print.info "Iniciando a instalação do RVM na maquina..."; 

        apt-add-repository -y ppa:rael-gc/rvm;
        apt-get update;
        apt-get install rvm;

        source /etc/profile.d/rvm.sh;

        echo -n "Version rvm: ";
        rvm version;
    }

    # @descr: Função de desinstalação.
    __uninstall() {
        util.print.info "Iniciando a desinstalação do RVM na maquina..."; 

        #https://stackoverflow.com/questions/3558656/how-can-i-remove-rvm-ruby-version-manager-from-my-system
        rm -rf "$HOME/.rvm/";
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
util.try; ( ScriptRVM "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;