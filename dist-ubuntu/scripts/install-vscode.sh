#!/bin/bash

###################  DOC  ###################
# @descr: ...  
# @fonts: ...
# @param: param | json
# @example: 
#    $ sudo chmod a+x install-vscode.sh
#    $ sudo ./install-vscode.sh
#############################################

function InstallVSCode {
    local param=$1;

    __install() {
        echo "Instalando o VS Code...";
        echo "$param";
        sleep 1s;
    }

    __initialize() {
        if [ `isInstalled "vscode"` == 1 ]; then
            echo "VS Code já está instalanda na maquina...";
        else
            echo "Iniciando a instalação do VS Code na maquina..."; 
            __install;
        fi 
    }

    __initialize;
}

InstallVSCode $1;

exit 0;