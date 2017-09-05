#!/bin/bash

###################  DOC  ###################
# @descr: Instalação do NodeJS na maquina 
# @fonts: https://tableless.com.br/como-instalar-node-js-no-linux-corretamente-ubuntu-debian-elementary-os/
#         https://www.digitalocean.com/community/tutorials/como-instalar-o-node-js-no-ubuntu-16-04-pt#como-instalar-utilizando-o-nvm
#         https://www.youtube.com/watch?v=BleYojqCaeQ
# @param: param | json
# @example: 
#    $ sudo chmod a+x install-nodejs.sh
#    $ sudo ./install-nodejs.sh
#############################################

function InstallNodeJS {
    local param=$1;

    __install() {
        msgInfo "Iniciando a instalação do NodeJS na maquina..."; 
        source ~/.nvm/nvm.sh;
        source ~/.profile;
        source ~/.bashrc;

	#chown -R $USER:$(id -gn $USER) /home/user/.config;

        nvm install 8.4.0;
        nvm use 8.4.0;

        echo -n "Version Node.js: ";
        node -v;

	echo -n "Version NPM: ";
        npm -v;
    }

    __initialize() {
        if [ `isInstalled "node"` == 1 ]; then
            msgInfo "NodeJS já está instalanda na maquina...";
        else
            __install;
        fi 
    }

    __initialize;
}

InstallNodeJS $1;

exit 0;
