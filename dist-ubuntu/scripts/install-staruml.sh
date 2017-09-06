#!/bin/bash

###################  DOC  ###################
# @descr: Instalação do StarUML na maquina.    
# @fonts: http://www.edivaldobrito.com.br/problemas-ao-instalar-ou-executar-programas-no-ubuntu-15-04/
#         https://www.youtube.com/watch?v=zGdwylAeZCY
#         https://packages.ubuntu.com/uk/trusty-updates/amd64/libgcrypt11/download
#         http://staruml.io/download
# @param: param | json
# @example: 
#    $ sudo chmod a+x install-staruml.sh
#    $ sudo ./install-staruml.sh
#############################################

function InstallStarUML {
    local param=$1;

    __install() {
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

    __initialize() {
        if [ `isInstalled "staruml"` == 1 ]; then
            echo "StarUML já está instalanda na maquina...";
        else
            echo "Iniciando a instalação do StarUML na maquina..."; 
            __install;
        fi 
    }

    __initialize;
}

InstallStarUML $1;

exit 0;