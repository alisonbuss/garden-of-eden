#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Faz a clonagem dos repositórios GIT
# @fonts: http://codexico.com.br/blog/linux/tutorial-simples-como-usar-o-git-e-o-github/
#         https://tableless.com.br/iniciando-no-git-parte-1/
# @param: 
#    action | text: (clone)
#    paramJson | json: {"defaultRepositoryPath":"...","repositories":[{"repositoryPath":"...","clonesAddress":[...]}]}
# @example:
#       bash script-repositories-git.sh --action='clone' --param='{...}'
#   OR
#       bash script-repositories-git.sh --action='status' --param='{...}'    
#-------------------------------------------------------------#

source <(wget --no-cache -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/import.sh"); 

import.ShellScriptTools "/linux/utility.sh";

function ScriptRepositoriesGit {

    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");
    local PARAM_JSON=$(util.getParameterValue "(--param=|-p=)" "$@");
    
    local version=$(echo "${PARAM_JSON}" | jq -r '.version');

    __clone() {
        util.print.info "Iniciando clone na maquina..."; 


    }

    __status() {
        util.print.info "Iniciando status na maquina..."; 

    
    }

    __actionError() {
        util.print.error "Erro: 'action' passado:(${ACTION}) não coincide com [install, uninstall]!";
    } 

    __initialize() {
        case ${ACTION} in
            clone) __clone; ;;
            status) __status; ;;
            *) __actionError;
        esac
    }

    __initialize;
}

# SCRIPT INITIALIZE...
util.try; ( ScriptRepositoriesGit "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;