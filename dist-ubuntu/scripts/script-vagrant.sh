#!/bin/bash
 
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação e desinstalação do Vagrant na maquina.  
# @fonts: https://howtoprogram.xyz/2016/07/23/install-vagrant-ubuntu-16-04/
#         http://danielfilho.github.io/2013/10/20/front-end-ops-vagrant/
#         https://www.olindata.com/en/blog/2014/07/installing-vagrant-and-virtual-box-ubuntu-1404-lts
# @example:
#       bash script-vagrant.sh --action='install' --param='{"version":"..."}'
#   OR
#       bash script-vagrant.sh --action='uninstall' --param='{}'    
#-------------------------------------------------------------#

source <(wget --no-cache -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/import.sh"); 

import.ShellScriptTools "/linux/utility.sh";

# @descr: Função principal do script-vagrant.sh
# @param: 
#    action | text: (install, uninstall)
#    param | json: '{"version":"..."}'
function ScriptVagrant {
    
    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");

    # @descr: Variavel de parametros JSON.
    local PARAM_JSON=$(util.getParameterValue "(--param=|-p=)" "$@");

    # @descr: Variavel da versão de instalação.
    local version=$(echo ${PARAM_JSON} | jq -r '.version');

    # @descr: Função de instalação.
    __install() {
        util.print.info "Iniciando a instalação do Vagrant na maquina..."; 

        wget "https://releases.hashicorp.com/vagrant/${version}/vagrant_${version}_x86_64.deb" -O "./binaries/vagrant.deb";
        chmod -R 777 "./binaries/vagrant.deb";

        dpkg -i "./binaries/vagrant.deb";

        # Remove o download do Vagrant
        rm "./binaries/vagrant.deb";
    }

    # @descr: Função de desinstalação.
    __uninstall() {
        util.print.info "Iniciando a desinstalação do Vagrant na maquina..."; 
        
        dpkg -r vagrant;
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
util.try; ( ScriptVagrant "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;