#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação e desinstalação do Git na maquina     
# @fonts: https://www.youtube.com/watch?v=BettUg-L8M4&list=PLV7VqBqvsd_1h7zmEpE-xwgOPqp2IBGCV
# @example:
#       bash script-git.sh --action='install' --param='{"nameUser":"...","emailUser":"..."}'
#   OR
#       bash script-git.sh --action='uninstall' --param='{"nameUser":"...","emailUser":"..."}'    
#-------------------------------------------------------------#

source <(wget --no-cache -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/import.sh"); 

import.ShellScriptTools "/linux/utility.sh";

# @descr: Função principal do script-git.sh
# @param: 
#    action | text: (install, uninstall)
#    param | json: {"nameUser":"...","emailUser":"..."}
function ScriptGit {

    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");

    # @descr: Variavel de parametros JSON.
    local PARAM_JSON=$(util.getParameterValue "(--param=|-p=)" "$@");

    local nameUser=$(echo ${PARAM_JSON} | jq -r '.nameUser');
    local emailUser=$(echo ${PARAM_JSON} | jq -r '.emailUser');

    # @descr: Função de instalação.
    __install() {
        util.print.info "Iniciando a instalação do Git na maquina..."; 

        apt-get install git;
        git config --global user.name "$nameUser";
        git config --global user.email $emailUser;

        git --version;
        git config --list;

        util.print.out '%b' "\033[1;33m";
        util.print.out '%b' "Sua chave SSH já foi publicada no GitHub? [yes/no]: "; read input_isPublishedKey;
        util.print.out '%b' "\033[0m";
        # Caso a chave SSH foi publicada no GitHub teste a conexão.
        if [ "$input_isPublishedKey" == "yes" ]; then
            util.print.warning "Testando a conexão com o GitHub...";
            ssh -T git@github.com;
        fi
    }

    # @descr: Função de desinstalação.
    __uninstall() {
        util.print.info "Iniciando a desinstalação do Git na maquina..."; 
        
        apt-get remove --auto-remove git;
        apt-get purge --auto-remove git;
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
util.try; ( ScriptGit "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;