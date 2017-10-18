#!/bin/bash

###################  DOC  ###################
# @descr: Instalação do StarUML na maquina.    
# @fonts: http://www.edivaldobrito.com.br/problemas-ao-instalar-ou-executar-programas-no-ubuntu-15-04/
#         https://www.youtube.com/watch?v=zGdwylAeZCY
#         https://packages.ubuntu.com/uk/trusty-updates/amd64/libgcrypt11/download
#         http://staruml.io/download
# @param: 
#    action | text: (install, uninstall)
#############################################

source <(wget -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/linux/utility.sh");

function ScriptStarUML {

    local ACTION=$1;

    __install() {
        print.info "Iniciando a instalação do StarUML na maquina..."; 

        wget "http://ubuntu.cs.utah.edu/ubuntu/pool/main/libg/libgcrypt11/libgcrypt11_1.5.3-2ubuntu4.5_amd64.deb" -O ./binaries/libgcrypt11.deb;
        chmod -R 777 ./binaries/libgcrypt11.deb;

        wget "http://staruml.io/download/release/v2.8.0/StarUML-v2.8.0-64-bit.deb" -O ./binaries/staruml.deb;
        chmod -R 777 ./binaries/staruml.deb;

        dpkg -i ./binaries/libgcrypt11.deb;
        dpkg -i ./binaries/staruml.deb;

        # Remover os download do libgcrypt11 e StarUML
        rm ./binaries/libgcrypt11.deb;
        rm ./binaries/staruml.deb;
    }

    __uninstall() {
        print.info "Iniciando a desinstalação do StarUML na maquina..."; 

        apt-get remove --auto-remove staruml;
        apt-get purge --auto-remove staruml;
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

ScriptStarUML "$@";

exit 0;