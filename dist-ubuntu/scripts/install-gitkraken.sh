#!/bin/bash

###################  DOC  ###################
# @descr: ...  
# @fonts: ...
# @param: param | json
# @example: 
#    $ sudo chmod a+x install-gitkraken.sh
#    $ sudo ./install-gitkraken.sh
#############################################

function InstallGitKraken {
    local param=$1;

    __install() {
        echo "Instalando o GitKraken...";
        echo "$param";
        sleep 1s;
    }

    __initialize() {
        if [ `isInstalled "gitkraken"` == 1 ]; then
            echo "GitKraken já está instalanda na maquina...";
        else
            echo "Iniciando a instalação do GitKraken na maquina..."; 
            __install;
        fi 
    }

    __initialize;
}

InstallGitKraken $1;

exit 0;