#!/bin/bash

###################  DOC  ###################
# @descr: Instalação do Node Version Manager (NVM) - Script bash simples para gerenciar várias versões do node.js ativo
# @fonts: https://github.com/creationix/nvm
#         https://tableless.com.br/como-instalar-node-js-no-linux-corretamente-ubuntu-debian-elementary-os/
#         https://www.digitalocean.com/community/tutorials/como-instalar-o-node-js-no-ubuntu-16-04-pt#como-instalar-utilizando-o-nvm
#         https://www.youtube.com/watch?v=BleYojqCaeQ
# @param: param | json
# @example: 
#    $ sudo chmod a+x install-nvm.sh
#    $ sudo ./install-nvm.sh
#############################################

function InstallNVM {
    local param=$1;

    __install() {
        msgInfo "Iniciando a instalação do NVM na maquina..."; 

        # pacotes de dependências que já estão no repositório de sua distribuição Debian Based
        apt-get update;
        apt-get install build-essential libssl-dev;

        wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.3/install.sh | bash;
        source ~/.nvm/nvm.sh;
        source ~/.profile;
        source ~/.bashrc;
        echo -n "Version NVM: ";
        nvm --version;
    }

    __initialize() {
        if [ -d "$HOME/.nvm" ]; then
            msgInfo "Node Version Manager (NVM) já está instalanda na maquina...";
        else
            __install;
        fi       
    }

    __initialize;
}

InstallNVM $1;

exit 0;
