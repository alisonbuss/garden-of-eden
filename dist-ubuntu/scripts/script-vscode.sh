#!/bin/bash

###################  DOC  ###################
# @descr: Instalação do VS Code na maquina.  
# @fonts: http://www.edivaldobrito.com.br/instalar-visual-studio-code-no-linux-usando-pacotes/
#         http://the-coderok.azurewebsites.net/2016/09/30/How-to-install-Visual-Studio-Code-on-Ubuntu-using-Debian-package-manager/
# @param: 
#    action | text: (install, uninstall)
#############################################

function ScriptVSCode {
    
    local ACTION=$1;

    __install() {
        print.info "Iniciando a instalação do VS Code na maquina..."; 

        wget "https://go.microsoft.com/fwlink/?LinkID=760868" -O ./binaries/vscode.deb;
        chmod -R 777 ./binaries/vscode.deb;

        dpkg -i ./binaries/vscode.deb;

        # Remove o download do VS Code
        rm ./binaries/vscode.deb;
    }

    __uninstall() {
        print.info "Iniciando a desinstalação do VS Code na maquina..."; 
        
        apt-get remove --auto-remove code;
        apt-get purge --auto-remove code;
    }

    __actionError() {
        print.error "Erro: 'action' passado:($ACTION) não coincide com [install, uninstall]!";
    } 

    __initialize() {
        case ${ACTION} in
            install) __install; ;;
            uninstall) __uninstall; ;;
            *) __actionError;
        esac
    }

    __initialize;
}

ScriptVSCode "$@";

exit 0;
