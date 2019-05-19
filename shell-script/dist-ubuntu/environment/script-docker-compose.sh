#!/bin/bash
 
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do Docker Compose na maquina 
# @fonts: https://docs.docker.com/compose/install/
#         https://github.com/alisonbuss/coreos-packer/blob/master/provision/shell-scripts/config-docker-compose.sh
#         https://github.com/docker/compose/releases
# @example:
#       bash script-docker-compose.sh --action='install' --param='{}'
#-------------------------------------------------------------#

# @descr: Função principal do script-docker-compose.sh
# @param: 
#    action | text: (install)
function ScriptDockerCompose {

    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");
    # @descr: Variavel de parametros JSON.
    local PARAM_JSON=$(util.getParameterValue "(--param=|-p=)" "$@");

    # @descr: Descrição da Variavel.
    local version=$(echo "${PARAM_JSON}" | $RUN_JQ -r '.version');

    # @descr: Função de instalação.
    __install() {
        util.print.out '%s\n' "Iniciando a instalação do Docker Compose na maquina..."; 
        
        # Download the current stable release of Docker Compose:
        curl -L "https://github.com/docker/compose/releases/download/${version}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose;

        # Apply executable permissions to the binary:
        chmod +x /usr/local/bin/docker-compose;

        # BUG: 
        # Run shell -> $ docker-compose version
        # WARNING: Dependency conflict: an older version of the 'docker-py' package may be polluting
        # the namespace. If you're experiencing crashes, run the following command to remedy the issue:
        # pip uninstall docker-py; pip uninstall docker; pip install docker
        # docker-compose version 1.19.0, build 9e633ef
        # SOLUTION:
        # printf '%b\n' "--run pip upgrade...";
        # pip install --upgrade pip;
        # printf '%b\n' "--run pip uninstall docker-py...";
        # pip uninstall -y docker-py;
        # printf '%b\n' "--run pip install docker...";
        # pip install docker;

        printf '%b\n' "--Execution path:";
        which docker-compose;

        printf '%b\n' "--Version:";
        docker-compose version;
    }

    # @descr: Função é chamada qndo a um erro de tipo de ação.
    # @param: 
    #    action | text: "..." | Action não encontrado.
    __actionError() {
        local actionErr=$(util.getParameterValue "(--action=|-a=)" "$@");
        util.print.error "Erro: 'action' passado:(${actionErr}) não coincide com [install]!";
        return 1;
    } 

    # @descr: Função principal "um construtor por exemplo".
    __initialize() {
        case ${ACTION} in
            install) { 
                __install; 
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
util.try; ( ScriptDockerCompose "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;
