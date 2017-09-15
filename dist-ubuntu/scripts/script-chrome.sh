#!/bin/bash

###################  DOC  ###################
# @descr: Instalação do Chrome na maquina. 
# @param: 
#    action | text: (install, uninstall)
#############################################

function ScriptChrome {
    
    local ACTION=$1;

    __install() {
        print.info "Iniciando a instalação do Chrome na maquina..."; 

        wget "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" -O ./binaries/chrome.deb;
        chmod -R 777 ./binaries/chrome.deb;
        dpkg -i ./binaries/chrome.deb;
        # Remover o download do Chrome
        rm ./binaries/chrome.deb;
    }

    __uninstall() {
        print.info "Iniciando a desinstalação do Chrome na maquina..."; 
        
        apt-get remove --auto-remove google-chrome-stable;
        apt-get purge --auto-remove google-chrome-stable;
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

ScriptChrome "$@";

exit 0;