#!/bin/bash

###################  DOC  ###################
# @descr: ...  
# @fonts: https://www.olindata.com/en/blog/2014/07/installing-vagrant-and-virtual-box-ubuntu-1404-lts
# @param: param | json
# @example: 
#    $ sudo chmod a+x install-virtualbox.sh
#    $ sudo ./install-virtualbox.sh
#############################################

function InstallVirtualBox {
    local param=$1;

    __install() {
        echo "Iniciando a instalação do VirtualBox na maquina..."; 

        wget "http://download.virtualbox.org/virtualbox/5.1.26/virtualbox-5.1_5.1.26-117224~Ubuntu~xenial_amd64.deb" -O ./binaries/virtualbox.deb;
        chmod -R 777 ./binaries/virtualbox.deb;

        dpkg -i ./binaries/virtualbox.deb;

        # Remove o download do VirtualBox
        rm ./binaries/virtualbox.deb;
    }

    __initialize() {
        if [ `isInstalled "virtualbox"` == 1 ]; then
            echo "VirtualBox já está instalanda na maquina...";
        else
            __install;
        fi 
    }

    __initialize;
}

InstallVirtualBox $1;

exit 0;