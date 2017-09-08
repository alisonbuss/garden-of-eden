#!/bin/bash

###################  DOC  ###################
# @descr:   O Config Transpiler, ct, é o utilitário responsável por transformar 
#           uma Configuração de Container Linux configurada pelo usuário em uma 
#           configuração Ignition.
#
# @fonts:   https://coreos.com/os/docs/latest/provisioning.html
#           https://coreos.com/os/docs/1478.0.0/overview-of-ct.html
#
# @param: param | json
#
# @example: 
#
#    $ sudo chmod a+x install-config-transpiler.sh
#    $ sudo ./install-config-transpiler.sh
#
#############################################

function InstallConfigTranspiler {
    local param=$1;

    __install() {
        echo "Instalando o Config Transpiler...";
        echo "$param";
        sleep 1s;
    }

    __initialize() {
        if [ `isInstalled "ct"` == 1 ]; then
            echo "Config Transpiler já está instalanda na maquina...";
        else
            echo "Iniciando a instalação do Config Transpiler na maquina..."; 
            __install;
        fi 
    }

    __initialize;
}

InstallConfigTranspiler $1;

exit 0