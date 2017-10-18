#!/bin/bash

###################  DOC  ###################
# @descr: Instalação do NodeJS na maquina 
# @fonts: https://tableless.com.br/como-instalar-node-js-no-linux-corretamente-ubuntu-debian-elementary-os/
#         https://www.digitalocean.com/community/tutorials/como-instalar-o-node-js-no-ubuntu-16-04-pt#como-instalar-utilizando-o-nvm
#         https://www.youtube.com/watch?v=BleYojqCaeQ
# @param: 
#    action | text: (install, uninstall)
#    paramJson | json: {"version":"..."}
#############################################

source <(wget -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/linux/utility.sh");

function ScriptNodeJS {
    
    local ACTION=$1;
    local PARAM_JSON=$2;

    local version=$(echo ${PARAM_JSON} | jq -r '.version');

    __install() {
        print.info "Iniciando a instalação do NodeJS na maquina..."; 
        source ~/.nvm/nvm.sh;
        source ~/.profile;
        source ~/.bashrc;

        nvm install $version;
        nvm use $version;

        echo -n "Version Node.js: ";
        node -v;

        # @fonts: https://www.computerhope.com/unix/uchown.htm
        #         http://manpages.ubuntu.com/manpages/trusty/man1/chown.1.html
        # CUIDADO COM ESSE COMMANDO FILHO DA PUTA, DEU UM BUG DU INFERNU.
        # chown -R $USER:$(id -gn $USER) /home/user/.config;

	    echo -n "Version NPM: ";
        npm -v;
    }

    __uninstall() {
        print.info "Iniciando a desinstalação do NodeJS na maquina..."; 
        
        nvm uninstall $version;
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

ScriptNodeJS "$@";

exit 0;
