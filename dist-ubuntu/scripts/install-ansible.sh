#!/bin/bash

###################  DOC  ###################
# @descr: ...  
# @fonts: ...
# @param: param | json
# @example: 
#    $ sudo chmod a+x install-ansible.sh
#    $ sudo ./install-ansible.sh
#############################################

function InstallAnsible {
    local jsonParam=$1;
    local action="$(echo ${jsonParam} | jq -r '.action')";
    local version="$(echo ${jsonParam} | jq -r '.version')";

    __install() {
        echo "Instalando o Ansible...";
        echo "$jsonParam";
        sleep 1s;
    }

    __uninstall() {
         echo "Desinstalando o Ansible...";
    }

    __initialize() {
        if [ `isInstalled "ansible"` == 1 ]; then
            echo "Ansible já está instalanda na maquina...";
        else
            echo "Iniciando a instalação do Ansible na maquina..."; 
            __install;
        fi 
    }

    __initialize;
}

InstallAnsible $1;

exit 0;