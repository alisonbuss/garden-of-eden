#!/bin/bash

###################  DOC  ###################
# @descr: Instalação do Vagrant na maquina. 
# @fonts: https://howtoprogram.xyz/2016/07/23/install-vagrant-ubuntu-16-04/
#         http://danielfilho.github.io/2013/10/20/front-end-ops-vagrant/
#         https://www.olindata.com/en/blog/2014/07/installing-vagrant-and-virtual-box-ubuntu-1404-lts
# @param: 
#    action | text: (install, uninstall)
#############################################

source <(wget -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/linux/utility.sh");

function ScriptVagrant {
    
    local ACTION=$1;

    __install() {
        print.info "Iniciando a instalação do Vagrant na maquina..."; 

        apt-get install vagrant;

        # OU...
        #wget "https://releases.hashicorp.com/vagrant/1.9.8/vagrant_1.9.8_x86_64.deb" -O ./binaries/vagrant.deb;
        #chmod -R 777 ./binaries/vagrant.deb;

        #dpkg -i ./binaries/vagrant.deb;

        # Remove o download do Vagrant
        #rm ./binaries/vagrant.deb;
    }

    __uninstall() {
        print.info "Iniciando a desinstalação do Vagrant na maquina..."; 
        
        apt-get remove --auto-remove vagrant;
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

ScriptVagrant "$@";

exit 0;