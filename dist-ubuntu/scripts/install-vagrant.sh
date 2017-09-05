#!/bin/bash

###################  DOC  ###################
# @descr: ...  
# @fonts: ...
# @param: param | json
# @example: 
#    $ sudo chmod a+x install-vagrant.sh
#    $ sudo ./install-vagrant.sh
#############################################

function InstallVagrant {
    local param=$1;

    __install() {
        echo "Instalando o Vagrant...";
        echo "$param";
        sleep 1s;
    }

    __initialize() {
        if [ `isInstalled "vagrant"` == 1 ]; then
            echo "Vagrant já está instalanda na maquina...";
        else
            echo "Iniciando a instalação do Vagrant na maquina..."; 
            __install;
        fi 
    }

    __initialize;
}

InstallVagrant $1;

exit 0;