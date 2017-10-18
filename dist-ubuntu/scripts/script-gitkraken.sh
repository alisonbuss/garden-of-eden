#!/bin/bash

###################  DOC  ###################
# @descr: Instalação do GitKraken na maquina.  
# @fonts: https://support.gitkraken.com/how-to-install
# @param: 
#    action | text: (install, uninstall)
#############################################

source <(wget -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/linux/utility.sh");

function ScriptGitKraken {
    
    local ACTION=$1;

    __install() {
        print.info "Iniciando a instalação do GitKraken na maquina..."; 

        wget "https://release.gitkraken.com/linux/gitkraken-amd64.deb" -O ./binaries/gitkraken.deb;
        chmod -R 777 ./binaries/gitkraken.deb;

        dpkg -i ./binaries/gitkraken.deb;

        # Remover o download do GitKraken
        rm ./binaries/gitkraken.deb;
    }

    __uninstall() {
        print.info "Iniciando a desinstalação do GitKraken na maquina..."; 
        
        apt-get remove --auto-remove gitkraken;
        apt-get purge --auto-remove gitkraken;
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

ScriptGitKraken "$@";

exit 0;