#!/bin/bash

###################  DOC  ###################
# @descr: Instalação do GitKraken na maquina.  
# @fonts: https://support.gitkraken.com/how-to-install
# @param: param | json
# @example: 
#    $ sudo chmod a+x install-gitkraken.sh
#    $ sudo ./install-gitkraken.sh
#############################################

function InstallGitKraken {
    local param=$1;

    __install() {
        echo "Iniciando a instalação do GitKraken na maquina..."; 

        wget "https://release.gitkraken.com/linux/gitkraken-amd64.deb" -O ./binaries/gitkraken.deb;
        chmod -R 777 ./binaries/gitkraken.deb;

        dpkg -i ./binaries/gitkraken.deb;

        # Remover o download do GitKraken
        rm ./binaries/gitkraken.deb;
    }

    __initialize() {
        if [ `isInstalled "gitkraken"` == 1 ]; then
            echo "GitKraken já está instalanda na maquina...";
        else
            __install;
        fi 
    }

    __initialize;
}

InstallGitKraken $1;

exit 0;