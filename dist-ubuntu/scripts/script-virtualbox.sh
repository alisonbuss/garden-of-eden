#!/bin/bash

###################  DOC  ###################
# @descr: Instalação do VirtualBox na maquina.  
# @fonts: https://www.olindata.com/en/blog/2014/07/installing-vagrant-and-virtual-box-ubuntu-1404-lts
#         https://www.howtoinstall.co/pt/ubuntu/xenial/virtualbox?action=remove
# @param: 
#    action | text: (install, uninstall)
#############################################

source <(wget -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/linux/utility.sh");

function ScriptVirtualBox {
    
    local ACTION=$1;

    __install() {
        print.info "Iniciando a instalação do VirtualBox na maquina..."; 

        apt-get install virtualbox;
        #apt-get install virtualbox-dkms;

        # OU...
        #wget "http://download.virtualbox.org/virtualbox/5.1.26/virtualbox-5.1_5.1.26-117224~Ubuntu~xenial_amd64.deb" -O ./binaries/virtualbox.deb;
        #chmod -R 777 ./binaries/virtualbox.deb;

        #dpkg -i ./binaries/virtualbox.deb;

        # Remove o download do VirtualBox
        #rm ./binaries/virtualbox.deb;
    }

    __uninstall() {
        print.info "Iniciando a desinstalação do VirtualBox na maquina..."; 
        
        apt-get remove --auto-remove virtualbox;
        apt-get purge --auto-remove virtualbox;
    }

    __actionError() {
        print.error "Erro: 'action' passado:($ACTION) não coincide com [install, uninstall]!";
    } 

    __initialize() {
        case ${ACTION} in
            install) __install; ;;
            uninstall) __uninstall; ;;
            *) __actionError;
        esac
    }

    __initialize;
}

ScriptVirtualBox "$@";

exit 0;