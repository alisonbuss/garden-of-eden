#!/bin/bash
 
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Sua Descrição da Instalação na Maquina.
# @fonts: Fontes de referências
# @example:
#       bash script-example.sh --action='install' --param='{"version":"3.6.66"}'
#   OR
#       bash script-example.sh --action='uninstall' --param='{"version":"6.6.63"}'    
#-------------------------------------------------------------#

source <(wget --no-cache -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/import.sh"); 

import.ShellScriptTools "/linux/utility.sh";

# @descr: Descrição da Função.
# @fonts: Fontes de referências
# @param: 
#    action | text: (install, uninstall)
#    param | json: '{"version":"..."}'
function ScriptExample {
    
    # @descr: Descrição da Variavel.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");
    # @descr: Descrição da Variavel.
    local PARAM_JSON=$(util.getParameterValue "(--param=|-p=)" "$@");
    # @descr: Descrição da Variavel.
    local version=$(echo "${PARAM_JSON}" | jq -r '.version');

    # @descr: Descrição da Função.
    # @fonts: Fontes de referências
    # @param: Parametros (--aa='aaa', --bb='bbb')
    __install() {
        util.print.info "Iniciando a instalação do Example na maquina..."; 
        util.print.out '%s\n\n' "  --> Version: ${version}"; 
    }

    # @descr: Descrição da Função.
    # @fonts: Fontes de referências
    # @param: Parametros (--aa='aaa', --bb='bbb')
    __uninstall() { 
        util.print.info "Iniciando a desinstalação do Example na maquina..."; 
        util.print.out '%s\n\n' "  --> Version: ${version}"; 
    }

    # @descr: Descrição da Função.
    # @fonts: Fontes de referências
    # @param: 
    #    action | text: "..." | Action não encontrado.
    __actionError() {
        local actionErr=$(util.getParameterValue "(--action=|-a=)" "$@");
        util.print.error "Erro: 'action' passado:(${actionErr}) não coincide com [install, uninstall]!";
        return 1;
    } 

    # @descr: Descrição da Função.
    # @fonts: Fontes de referências
    # @param: Parametros (--aa='aaa', --bb='bbb')
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

    # @descr: Descrição da Chamada da Função.
    __initialize "$@";
}

# SCRIPT INITIALIZE...
util.try; ( ScriptExample "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;