#!/bin/bash
 
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação e desinstalação do Terraform na maquina.
# @fonts: https://mangolassi.it/topic/14459/installing-terraform-0-9-11-on-ubuntu-17-04
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

        wget "https://releases.hashicorp.com/terraform/${version}/terraform_${version}_linux_amd64.zip" -O "./binaries/terraform.zip";
        chmod -R 777 "./binaries/terraform.zip";

        unzip "./binaries/terraform.zip" -d "/usr/local/bin/";

        terraform -v;

        mkdir -p "${HOME}/.terraform";

        chmod -R 777 "${HOME}/.terraform";
        chmod -R 777 "${HOME}/.terraform.d";

        # Remove o download do terraform
        rm "./binaries/terraform.zip";
    }

    # @descr: Função de desinstalação.
    __uninstall() {
        util.print.info "Iniciando a desinstalação Terraform na maquina..."; 

        # Remove files on $HOME
        rm -rf "${HOME}/.terraform";
        rm -rf "${HOME}/.terraform.d"; 

        # Remove files on BIN
        rm -rf "/usr/local/bin/terraform"; 
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