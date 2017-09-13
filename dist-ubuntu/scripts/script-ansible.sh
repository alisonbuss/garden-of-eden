#!/bin/bash

###################  DOC  ###################
# @descr: Instalação do Ansible na maquina 
# @fonts: http://blog.deiser.com/primeros-pasos-con-ansible/
#         https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-ansible-on-ubuntu-16-04
#         http://docs.ansible.com/ansible/latest/intro_installation.html#latest-releases-via-apt-ubuntu
# @param: 
#    action | text: (install, uninstall)
#############################################

function ScriptAnsible {

    local ACTION=$1;

    __install() {
        print.info "Iniciando a instalação do Ansible na maquina..."; 

        apt-get install software-properties-common;
        apt-add-repository ppa:ansible/ansible;
        apt-get update;

        apt-get install ansible;

        print.out '%s' "Version Ansible: ";
        ansible --version;
    }

    __uninstall() {
        print.info "Iniciando a desinstalação do Ansible na maquina..."; 
        
        apt-get remove --auto-remove ansible;
        apt-get purge --auto-remove ansible;
    }

    __actionError() {
        print.error "Erro: 'action' passado:($ACTION) não coincide com [install, uninstall]!";
    } 

    __initialize() {
        case ${ACTION} in
            install) __install; ;;
            uninstall) __uninstall; ;;
            *) __actionError;
        esac
    }

    __initialize;
}

ScriptAnsible "$@";

exit 0;