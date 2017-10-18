#!/bin/bash

###################  DOC  ###################
# @descr: Instalação do Terraform na Maquina.
# @fonts: 
# @param: 
#    action | text: (install, uninstall)
#    paramJson | json: {"version":"..."}
#############################################

source <(wget -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/linux/utility.sh");

function ScriptTerraform {

    local ACTION=$1;
    local PARAM_JSON=$2;
    
    local version=$(echo ${PARAM_JSON} | jq -r '.version');

    __install() {
        print.info "Iniciando a instalação do ScriptTerraform na maquina..."; 

        
    }

    __uninstall() {
        print.info "Iniciando a desinstalação ScriptTerraform na maquina..."; 

    
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

ScriptTerraform "$@";

exit 0;
