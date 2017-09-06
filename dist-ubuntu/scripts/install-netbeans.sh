#!/bin/bash

###################  DOC  ###################
# @descr: ...  
# @fonts: http://www.edivaldobrito.com.br/ultima-versao-do-netbeans-no-linux/
#         http://ubuntuhandbook.org/index.php/2016/10/netbeans-8-2-released-how-to-install-it-in-ubuntu-16-04/
# @param: param | json
# @example: 
#    $ sudo chmod a+x install-netbeans.sh
#    $ sudo ./install-netbeans.sh
#############################################

function InstallNetbeans {
    local param=$1;

    __install() {
        wget "http://download.netbeans.org/netbeans/8.2/final/bundles/netbeans-8.2-linux.sh" -O ./binaries/netbeans.sh;
        chmod -R 777 ./binaries/netbeans.sh;

        chmod +x ./binaries/netbeans.sh;
        ./binaries/netbeans.sh;

        # Remove o download do Netbeans
        rm ./binaries/netbeans.sh;
    }

    __initialize() {
        if [ `isInstalled "netbeans"` == 1 ]; then
            echo "Netbeans já está instalanda na maquina...";
        else
            echo "Iniciando a instalação do Netbeans na maquina..."; 
            __install;
        fi 
    }

    __initialize;
}

InstallNetbeans $1;

exit 0;