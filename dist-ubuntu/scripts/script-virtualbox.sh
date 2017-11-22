#!/bin/bash
 
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação e desinstalação do VirtualBox na maquina.    
# @fonts: https://www.olindata.com/en/blog/2014/07/installing-vagrant-and-virtual-box-ubuntu-1404-lts
#         https://www.howtoinstall.co/pt/ubuntu/xenial/virtualbox?action=remove
# @example:
#       bash script-virtualbox.sh --action='install' --param='{}'
#   OR
#       bash script-virtualbox.sh --action='uninstall' --param='{}'    
#-------------------------------------------------------------#

source <(wget --no-cache -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/import.sh"); 

import.ShellScriptTools "/linux/utility.sh";

# @descr: Função principal do script-virtualbox.sh
# @param: 
#    action | text: (install, uninstall)
function ScriptVirtualBox {
    
    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");

    # @descr: Função de instalação.
    __install() {
        util.print.info "Iniciando a instalação do VirtualBox na maquina..."; 

        apt-get install virtualbox;
        #apt-get install virtualbox-dkms;

        # OU...
        #wget "http://download.virtualbox.org/virtualbox/5.1.26/virtualbox-5.1_5.1.26-117224~Ubuntu~xenial_amd64.deb" -O ./binaries/virtualbox.deb;
        #chmod -R 777 ./binaries/virtualbox.deb;

        #dpkg -i ./binaries/virtualbox.deb;

        # Remove o download do VirtualBox
        #rm ./binaries/virtualbox.deb;
    }

    # @descr: Função de desinstalação.
    __uninstall() {
        util.print.info "Iniciando a desinstalação do VirtualBox na maquina..."; 
        
        apt-get remove --auto-remove virtualbox;
        apt-get purge --auto-remove virtualbox;
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
util.try; ( ScriptVirtualBox "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;