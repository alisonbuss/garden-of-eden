#!/bin/bash
 
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação e desinstalação do Ansible na maquina 
# @fonts: http://blog.deiser.com/primeros-pasos-con-ansible/
#         https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-ansible-on-ubuntu-16-04
#         http://docs.ansible.com/ansible/latest/intro_installation.html#latest-releases-via-apt-ubuntu
# @example:
#       bash script-ansible.sh --action='install' --param='{}'
#   OR
#       bash script-ansible.sh --action='uninstall' --param='{}'    
#-------------------------------------------------------------#

source <(wget --no-cache -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/import.sh"); 

import.ShellScriptTools "/linux/utility.sh";

# @descr: Função principal do script-ansible.sh
# @param: 
#    action | text: (install, uninstall)
function ScriptAnsible {

    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");

    # @descr: Função de instalação.
    __install() {
        util.print.info "Iniciando a instalação do Ansible na maquina..."; 

        apt-get install software-properties-common;
        apt-add-repository ppa:ansible/ansible;
        apt-get update;

        apt-get install ansible;

        chmod -R 777 $HOME/.ansible;

        util.print.out '%s' "Version Ansible: ";
        ansible --version;
    }

    # @descr: Função de desinstalação.
    __uninstall() {
        util.print.info "Iniciando a desinstalação do Ansible na maquina..."; 
        
        apt-get remove --auto-remove ansible;
        apt-get purge --auto-remove ansible;
    }

    # @descr: Função é chamada qndo a um erro de tipo de ação.
    # @param: 
    #    action | text: "..." | Action não encontrado.
    __actionError() {
        local actionErr=$(util.getParameterValue "(--action=|-a=)" "$@");
        util.print.error "Erro: 'action' passado:(${actionErr}) não coincide com [install, uninstall]!";
        return 1;
    } 

    # @descr: Função principal "um construtor por exemplo".
    __initialize() {
        case ${ACTION} in
            install) { 
                __install; 
            };;
            uninstall) { 
                __uninstall;
            };;
            *) {
               __actionError "--action=${ACTION}"; 
            };;
        esac
    }

    # @descr: Chamada da função principal de inicialização do script.
    __initialize;
}

# SCRIPT INITIALIZE...
util.try; ( ScriptAnsible "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;