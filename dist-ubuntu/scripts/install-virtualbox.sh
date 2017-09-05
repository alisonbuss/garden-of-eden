#!/bin/bash

###################  DOC  ###################
# @descr: ...  
# @fonts: ...
# @param: param | json
# @example: 
#    $ sudo chmod a+x install-virtualbox.sh
#    $ sudo ./install-virtualbox.sh
#############################################

function InstallVirtualBox {
    local param=$1;

    __install() {
        echo "Instalando o VirtualBox...";
        echo "$param";
        sleep 1s;
    }

    __initialize() {
        if [ `isInstalled "virtualbox"` == 1 ]; then
            echo "VirtualBox já está instalanda na maquina...";
        else
            echo "Iniciando a instalação do VirtualBox na maquina..."; 
            __install;
        fi 
    }

    __initialize;
}

InstallVirtualBox $1;

exit 0;