#!/bin/bash

###################  DOC  ###################
# @descr: Instalação da extensão 'jq' na maquina 
# @fonts: https://stedolan.github.io/jq/
#         https://serverfault.com/questions/768026/how-to-install-jq-on-rhel6-5
# @param: 
#    action | text: (install)
#############################################

function installExtensionJQ {
    __install() {
        apt-get install jq
        # OU...
        # As it says on the development page for jq "jq is written in C and has no runtime dependencies". 
        # So just download the file and put it in place with the following: 
        #wget "https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64" -O ./binaries/jq-linux64;
        #chmod -R 777 ./binaries/jq-linux64;
        #chmod +x ./binaries/jq-linux64;
        #cp ./binaries/jq-linux64 /usr/bin;
        # Remover o download do Chrome
        #rm ./binaries/jq-linux64;
    }
    __initialize() {
        if [ `isInstalled "jq"` == 1 ]; then
            echo "A extensão 'jq' já está instalanda na maquina...";
        else
            __install;
        fi
    }
    __initialize;
}
export -f installExtensionJQ;

function uninstallExtensionJQ {
    # @fonts: http://installion.co.uk/ubuntu/trusty/universe/j/jq/uninstall/index.html
    __uninstall() {
        sudo apt-get remove --auto-remove jq
        sudo apt-get purge --auto-remove jq
    }
    __initialize() {
        if [ `isInstalled "jq"` == 1 ]; then
            __uninstall;
        else
            echo "Não a extensão 'jq' instalanda na maquina...";
        fi
    }
    __initialize;
}
export -f uninstallExtensionJQ