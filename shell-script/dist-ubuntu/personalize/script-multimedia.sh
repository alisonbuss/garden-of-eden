#!/bin/bash
 
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do Multimedia na maquina 
# @fonts: https://www.linuxtechi.com/top10-things-after-installing-ubuntu-18-04/
# @example:
#       bash script-multimedia.sh --action='install' --param='{}'
#-------------------------------------------------------------#

# @descr: Função principal do script-multimedia.sh
# @param: 
#    action | text: (install)
function ScriptMultimedia {

    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");

    # @descr: Função de instalação.
    __install() {
        util.print.out '%s\n' "Iniciando a instalação de Multimedia na maquina..."; 

        sudo apt-get install -y vlc;
        sudo apt-get install -f;
        
        sudo apt-get install -y ubuntu-restricted-extras;
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
util.try; ( ScriptMultimedia "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;
