#!/bin/bash
 
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação e desinstalação do Terraform na maquina.
# @fonts: ...
# @example:
#       bash script-terraform.sh --action='install' --param='{"version":"0.10.7"}'
#   OR
#       bash script-terraform.sh --action='uninstall' --param='{"version":"0.10.7"}'    
#-------------------------------------------------------------#

source <(wget --no-cache -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/import.sh"); 

import.ShellScriptTools "/linux/utility.sh";

# @descr: Função principal do script-terraform.sh
# @param: 
#    action | text: (install, uninstall)
#    param | json: '{"version":"..."}'
function ScriptTerraform {

     # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");

    # @descr: Variavel de parametros JSON.
    local PARAM_JSON=$(util.getParameterValue "(--param=|-p=)" "$@");

    # @descr: Variavel da versão de instalação.
    local version=$(echo ${PARAM_JSON} | jq -r '.version');

    # @descr: Função de instalação.
    __install() {
        util.print.info "Iniciando a instalação do Terraform na maquina..."; 

    }

    # @descr: Função de desinstalação.
    __uninstall() {
        util.print.info "Iniciando a desinstalação Terraform na maquina..."; 

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
util.try; ( ScriptTerraform "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;