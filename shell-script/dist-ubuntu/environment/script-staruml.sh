#!/bin/bash
 
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação e desinstalação do StarUML na maquina.   
# @fonts: http://www.edivaldobrito.com.br/problemas-ao-instalar-ou-executar-programas-no-ubuntu-15-04/
#         https://www.youtube.com/watch?v=zGdwylAeZCY
#         https://packages.ubuntu.com/uk/trusty-updates/amd64/libgcrypt11/download
#         http://staruml.io/download
#         https://sempreupdate.com.br/como-executar-arquivo-appimage-no-linux/
# @example:
#       bash script-staruml.sh --action='install' --param='{}'
#-------------------------------------------------------------#

# @descr: Função principal do script-staruml.sh
# @param: 
#    action | text: (install)
function ScriptStarUML {

    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");
    # @descr: Variavel de parametros JSON.
    local PARAM_JSON=$(util.getParameterValue "(--param=|-p=)" "$@");

    # @descr: Variavel da versão de instalação.
    local version=$(echo "${PARAM_JSON}" | $RUN_JQ -r '.version');

    # @descr: Função de instalação.
    __install() {
        util.print.out '%s\n' "Iniciando a instalação do StarUML na maquina..."; 

        wget "http://staruml.io/download/releases/StarUML-${version}-x86_64.AppImage" -O ./binaries/staruml.AppImage;
        chmod 777 ./binaries/staruml.AppImage;

        cp ./binaries/staruml.AppImage /usr/local/bin/;

        # Remover os download StarUML
        #rm /binaries/staruml.AppImage;
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
util.try; ( ScriptStarUML "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;
