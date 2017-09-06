#!/bin/bash

###################  DOC  ###################
# @descr: ...  
# @fonts: ...
# @param: param | json
# @example: 
#    $ sudo chmod a+x install-cfssl.sh
#    $ sudo ./install-cfssl.sh
#############################################

function InstallCFSSL {
    local param=$1;

    __install() {
        msgInfo "Iniciando a instalação do CFSSL na maquina..."; 

        go get -u github.com/cloudflare/cfssl/cmd/cfssl;
        cfssl version;
    }

    __initialize() {
        if [ `isInstalled "cfssl"` == 1 ]; then
            echo "CFSSL já está instalanda na maquina...";
        else
            __install;
        fi 
    }

    __initialize;
}

InstallCFSSL $1;

exit 0;
