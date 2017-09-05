#!/bin/bash

###################  DOC  ###################
# @descr: ...  
# @fonts: ...
# @param: param | json
# @example: 
#    $ sudo chmod a+x install-netbeans.sh
#    $ sudo ./install-netbeans.sh
#############################################

function InstallNetbeans {
    local param=$1;

    __install() {
        echo "Instalando o Netbeans...";
        echo "$param";
        sleep 1s;
    }

    __initialize() {
        if [ `isInstalled "netbeans"` == 1 ]; then
            echo "Netbeans já está instalanda na maquina...";
        else
            echo "Iniciando a instalação do Netbeans na maquina..."; 
            __install;
        fi 
    }

    __initialize;
}

InstallNetbeans $1;

exit 0;