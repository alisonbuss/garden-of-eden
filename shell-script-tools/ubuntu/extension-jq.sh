#!/bin/bash

#INSTALAÇÂO DO JQ
#FONT: https://serverfault.com/questions/768026/how-to-install-jq-on-rhel6-5
#
#As it says on the development page for jq "jq is written in C and has no runtime dependencies". 
#So just download the file and put it in place with the following: 
#
#wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64
#chmod +x ./jq
#cp jq /usr/bin

###################  DOC  ###################
# @descr: ...  
# @fonts: ...
# @example: 
#    $ sudo chmod a+x extension-jq.sh
#    $ sudo ./extension-jq.sh
#    $ installExtensionJQ
#  OR
#    $ uninstallExtensionJQ
#############################################

function installExtensionJQ {
    __install() {
        apt-get install jq
    }
    __initialize() {
        if [ `isInstalled "jq"` == 1 ]; then
            echo "A extenção 'jq' já está instalanda na maquina...";
        else
            __install;
        fi
    }
    __initialize;
}
export -f installExtensionJQ;

function uninstallExtensionJQ {
    __uninstall() {
        # @fonts: http://installion.co.uk/ubuntu/trusty/universe/j/jq/uninstall/index.html
        sudo apt-get remove --auto-remove jq
        sudo apt-get purge --auto-remove jq
    }
    __initialize() {
        if [ `isInstalled "jq"` == 1 ]; then
            __uninstall;
        else
            echo "Não a extenção 'jq' instalanda na maquina...";
        fi
    }
    __initialize;
}
export -f uninstallExtensionJQ