#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Instalação do Terraform na maquina.
# @param: 
#    action | text: (install, uninstall)
#    paramJson | json: {"version":"..."}
# @example:
#       bash script-terraform.sh --action='install' --param='{"version":"0.10.7"}'
#   OR
#       bash script-terraform.sh --action='uninstall' --param='{"version":"0.10.7"}'    
#-------------------------------------------------------------#

source <(wget --no-cache -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/import.sh"); 

import.ShellScriptTools "/linux/utility.sh";

function ScriptTerraform {

    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");
    local PARAM_JSON=$(util.getParameterValue "(--param=|-p=)" "$@");
    
    local version=$(echo "${PARAM_JSON}" | jq -r '.version');

    __install() {
        util.print.info "Iniciando a instalação do Terraform na maquina..."; 

    }

    __uninstall() {
        util.print.info "Iniciando a desinstalação Terraform na maquina..."; 

    }

    __actionError() {
        util.print.error "Erro: 'action' passado:(${ACTION}) não coincide com [install, uninstall]!";
    } 

    __initialize() {
        case ${ACTION} in
            install) __install; ;;
            uninstall) __uninstall; ;;
            *) __actionError;
        esac
    }

    __initialize "$@";
}

# SCRIPT INITIALIZE...
util.try; ( ScriptTerraform "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;