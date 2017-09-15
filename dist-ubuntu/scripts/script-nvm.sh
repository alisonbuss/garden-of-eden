#!/bin/bash

###################  DOC  ###################
# @descr: Instalação do Node Version Manager (NVM) - Script bash simples para gerenciar várias versões do node.js ativo
# @fonts: https://github.com/creationix/nvm
#         https://tableless.com.br/como-instalar-node-js-no-linux-corretamente-ubuntu-debian-elementary-os/
#         https://www.digitalocean.com/community/tutorials/como-instalar-o-node-js-no-ubuntu-16-04-pt#como-instalar-utilizando-o-nvm
#         https://www.youtube.com/watch?v=BleYojqCaeQ
# @param: 
#    action | text: (install, uninstall)
#    paramJson | json: {"version":"..."}
#############################################

function ScriptNVM {

    local ACTION=$1;
    local PARAM_JSON=$2;
    
    local version=$(echo ${PARAM_JSON} | jq -r '.version');

    __install() {
        print.info "Iniciando a instalação do NVM na maquina..."; 

        # pacotes de dependências que já estão no repositório de sua distribuição Debian Based
        apt-get update;
        apt-get install build-essential libssl-dev;

        wget -qO- "https://raw.githubusercontent.com/creationix/nvm/v$version/install.sh" | bash;
        source ~/.nvm/nvm.sh;
        source ~/.profile;
        source ~/.bashrc;
        
        chmod -R 777 $HOME/.nvm;

        echo -n "Version NVM: ";
        nvm --version;
    }

    __uninstall() {
        print.info "Iniciando a desinstalação do NVM na maquina..."; 

        rm -rf "$HOME/.nvm/";
        rm -rf "$HOME/nvm/";
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

ScriptNVM "$@";

exit 0;
