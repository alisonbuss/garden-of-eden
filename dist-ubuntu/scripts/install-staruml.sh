#!/bin/bash

###################  DOC  ###################
# @descr: ...  
# @fonts: ...
# @param: param | json
# @example: 
#    $ sudo chmod a+x install-staruml.sh
#    $ sudo ./install-staruml.sh
#############################################

function InstallStarUML {
    local param=$1;

    __install() {
        echo "Instalando o StarUML...";
        echo "$param";
        sleep 1s;
    }

    __initialize() {
        if [ `isInstalled "staruml"` == 1 ]; then
            echo "StarUML já está instalanda na maquina...";
        else
            echo "Iniciando a instalação do StarUML na maquina..."; 
            __install;
        fi 
    }

    __initialize;
}

InstallStarUML $1;

exit 0;