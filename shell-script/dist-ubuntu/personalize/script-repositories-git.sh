#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de clonagem dos repositórios GIT na maquina.
# @fonts: http://codexico.com.br/blog/linux/tutorial-simples-como-usar-o-git-e-o-github/
#         https://tableless.com.br/iniciando-no-git-parte-1/
# @example:
#       bash script-repositories-git.sh --action='clone' --param='{...}'   
#-------------------------------------------------------------#

# @descr: Função principal do script-repositories-git.sh
# @param: 
#    action | text: (clone)
#    param | json: {"rootPath":"...","repositories":[{"repositoryPath":"...","clonesAddress":[...]}]}
function ScriptRepositoriesGit {

    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");
    # @descr: Variavel de parametros JSON.
    local PARAM_JSON=$(util.getParameterValue "(--param=|-p=)" "$@");

    # @descr: Variavel do local padrão dos clones GITs.
    local rootRepositoryPath=$(echo "${PARAM_JSON}" | $RUN_JQ -r '.rootPath');

    # @descr: Função de clonagem do repositórios GIT.
    __clone() {
        util.print.out '%s\n' "Iniciando a clonagem dos repositórios GIT na maquina..."; 

        mkdir -p "${rootRepositoryPath}";

        local repositoriesSize=$(echo "${PARAM_JSON}" | $RUN_JQ ".repositories | length"); 
        for (( x=1; x<=$repositoriesSize; x++ )); do
            local repositoryIndex=$(($x-1));
            local repositoryPath=$(echo "${PARAM_JSON}" | $RUN_JQ -r ".repositories[${repositoryIndex}].repositoryPath");
            local clonesSize=$(echo "${PARAM_JSON}" | $RUN_JQ ".repositories[${repositoryIndex}].clonesAddress | length"); 

            mkdir -p "${rootRepositoryPath}${repositoryPath}";

            for (( y=1; y<=$clonesSize; y++ )); do
                local cloneIndex=$(($y-1));
                local repositoryGit=$(echo "${PARAM_JSON}" | $RUN_JQ -r ".repositories[${repositoryIndex}].clonesAddress[${cloneIndex}]"); 

                cd "${rootRepositoryPath}${repositoryPath}";

                util.print.out '%b\n' "${B_BLUE}--> Cloning Directory GIT: ${YELLOW}'${PWD}' ${COLOR_OFF}";

                git clone "${repositoryGit}";

                util.print.out '%b\n' "${COLOR_OFF}";
            done
        done

        chmod -R 777 "${rootRepositoryPath}";
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