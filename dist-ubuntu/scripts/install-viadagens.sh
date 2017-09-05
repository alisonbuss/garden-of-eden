#!/bin/bash

###################  DOC  ###################
# @descr: ...  
# @fonts: ...
# @param: param | json
# @example: 
#    $ sudo chmod a+x install-viadagens.sh
#    $ sudo ./install-viadagens.sh
#############################################

function InstallViadagens {
    local param=$1;

    __install() {
        echo "Instalando as Viadagens...";
        echo "$param";
        sleep 1s;
    }

    __initialize() {
        echo "Iniciando as instalações e configurações de customizações do Ubuntu..."; 
        __install;
    }

    __initialize;
}

InstallViadagens $1;

exit 0;