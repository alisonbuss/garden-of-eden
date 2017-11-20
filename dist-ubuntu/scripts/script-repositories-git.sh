#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de clonagem dos repositórios GIT na maquina.
# @fonts: http://codexico.com.br/blog/linux/tutorial-simples-como-usar-o-git-e-o-github/
#         https://tableless.com.br/iniciando-no-git-parte-1/
# @example:
#       bash script-repositories-git.sh --action='clone' --param='{...}'   
#-------------------------------------------------------------#

source <(wget --no-cache -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/import.sh"); 

import.ShellScriptTools "/linux/utility.sh";

# @descr: Função principal do script-repositories-git.sh
# @param: 
#    action | text: (clone)
#    param | json: {"defaultRepositoryPath":"...","repositories":[{"repositoryPath":"...","clonesAddress":[...]}]}
function ScriptRepositoriesGit {

    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");

    # @descr: Variavel de parametros JSON.
    local PARAM_JSON=$(util.getParameterValue "(--param=|-p=)" "$@");

    # @descr: Função de clonagem do repositórios GIT.
    __clone() {
        util.print.info "Iniciando clone na maquina..."; 


    }

    # @descr: Função é chamada qndo a um erro de tipo de ação.
    # @param: 
    #    action | text: "..." | Action não encontrado.
    __actionError() {
        local actionErr=$(util.getParameterValue "(--action=|-a=)" "$@");
        util.print.error "Erro: 'action' passado:(${actionErr}) não coincide com [clone]!";
        return 1;
    } 

    # @descr: Função principal "um construtor por exemplo".
    __initialize() {
        case ${ACTION} in
            clone) { 
                __clone; 
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
util.try; ( ScriptRepositoriesGit "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;