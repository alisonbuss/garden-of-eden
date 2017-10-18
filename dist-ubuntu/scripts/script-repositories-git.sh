#!/bin/bash

###################  DOC  ###################
# @descr: Faz a clonagem dos repositórios GIT
# @fonts: http://codexico.com.br/blog/linux/tutorial-simples-como-usar-o-git-e-o-github/
#         https://tableless.com.br/iniciando-no-git-parte-1/
# @param: 
#    action | text: (clone)
#    paramJson | json: {"defaultRepositoryPath":"...","repositories":[{"repositoryPath":"...","clonesAddress":[...]}]}
#############################################

source <(wget -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/linux/utility.sh");

function ScriptRepositoriesGit {

    local ACTION=$1;
    local PARAM_JSON=$2;

    __clone() {
        print.info "..."; 

    }

    __actionError() {
        print.error "Erro: 'action' passado:($ACTION) não coincide com [install, uninstall]!";
    } 

    __initialize() {
        case ${ACTION} in
            clone) __clone; ;;
            *) __actionError;
        esac
    }

    __initialize;
}

ScriptRepositoriesGit "$@";

exit 0;