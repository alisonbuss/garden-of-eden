#!/bin/bash

###################  DOC  ###################
# @descr: Instalação do VS Code na maquina.  
# @fonts: http://www.edivaldobrito.com.br/instalar-visual-studio-code-no-linux-usando-pacotes/
#         http://the-coderok.azurewebsites.net/2016/09/30/How-to-install-Visual-Studio-Code-on-Ubuntu-using-Debian-package-manager/
# @param: param | json
# @example: 
#    $ sudo chmod a+x install-vscode.sh
#    $ sudo ./install-vscode.sh
#############################################

function InstallVSCode {
    local param=$1;

    __install() {
        echo "Iniciando a instalação do VS Code na maquina..."; 

        wget "https://go.microsoft.com/fwlink/?LinkID=760868" -O ./binaries/vscode.deb;
        chmod -R 777 ./binaries/vscode.deb;

        dpkg -i ./binaries/vscode.deb;

        # Remove o download do VS Code
        rm ./binaries/vscode.deb;
    }

    __initialize() {
        if [ `isInstalled "vscode"` == 1 ]; then
            echo "VS Code já está instalanda na maquina...";
        else
            __install;
        fi 
    }

    __initialize;
}

InstallVSCode $1;

exit 0;
