#!/bin/bash

###################  DOC  ###################
# @descr: Instalação do Ansible na maquina 
# @fonts: http://blog.deiser.com/primeros-pasos-con-ansible/
#         https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-ansible-on-ubuntu-16-04
#         http://docs.ansible.com/ansible/latest/intro_installation.html#latest-releases-via-apt-ubuntu
# @param: param | json
# @example: 
#    $ sudo chmod a+x install-ansible.sh
#    $ sudo ./install-ansible.sh
#############################################

function InstallAnsible {
    local jsonParam=$1;

    __install() {
        msgInfo "Iniciando a instalação do Ansible na maquina..."; 

        apt-get install software-properties-common;
        apt-add-repository ppa:ansible/ansible;
        apt-get update;

        apt-get install ansible;

        echo -n "Version Ansible: ";
        ansible --version;
    }

    __uninstall() {
         echo "Desinstalando o Ansible...";
    }

    __initialize() {
        if [ `isInstalled "ansible"` == 1 ]; then
            echo "Ansible já está instalanda na maquina...";
        else
            __install;
        fi 
    }

    __initialize;
}

InstallAnsible $1;

exit 0;