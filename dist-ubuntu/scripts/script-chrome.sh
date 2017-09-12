#!/bin/bash

###################  DOC  ###################
# @descr: Instalação do Vagrant na maquina. 
# @fonts: https://howtoprogram.xyz/2016/07/23/install-vagrant-ubuntu-16-04/
#         http://danielfilho.github.io/2013/10/20/front-end-ops-vagrant/
#         https://www.olindata.com/en/blog/2014/07/installing-vagrant-and-virtual-box-ubuntu-1404-lts
# @param: param | json
# @example: 
#    $ sudo chmod a+x install-chrome.sh
#    $ sudo ./install-chrome.sh
#############################################

function InstallChrome {
    local param=$1;

    __install() {
        echo "Iniciando a instalação do Chrome na maquina..."; 

        wget "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" -O ./binaries/chrome.deb;
        chmod -R 777 ./binaries/chrome.deb;
        dpkg -i ./binaries/chrome.deb;
        # Remover o download do Chrome
        rm ./binaries/chrome.deb;
    }

    __initialize() {
        if [ `isInstalled "vagrant"` == 1 ]; then
            echo "Vagrant já está instalanda na maquina...";
        else
            __install;
        fi 
    }

    __initialize;
}

InstallChrome $1;

exit 0;