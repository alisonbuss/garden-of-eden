#!/bin/bash
 
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação e desinstalação do Packer na maquina.  
# @fonts: https://www.packer.io/
#         https://www.packer.io/docs/install/index.html
# @example:
#       bash script-packer.sh --action='install' --param='{"version":".1.1.3"}'
#   OR
#       bash script-packer.sh --action='uninstall' --param='{}'    
#-------------------------------------------------------------#

# @descr: Função principal do script-packer.sh
# @param: 
#    action | text: (install, uninstall)
#    param | json: '{"version":"..."}'
function ScriptPacker {
    
    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");
    # @descr: Variavel de parametros JSON.
    local PARAM_JSON=$(util.getParameterValue "(--param=|-p=)" "$@");

    # @descr: Variavel da versão de instalação.
    local version=$(echo ${PARAM_JSON} | $RUN_JQ -r '.version');

    # @descr: Função de instalação.
    __install() {
        util.print.out '%s\n' "Iniciando a instalação do Packer na maquina..."; 

        wget "https://releases.hashicorp.com/packer/${version}/packer_${version}_linux_amd64.zip" -O "./binaries/packer.zip";
        chmod -R 777 "./binaries/packer.zip";

        unzip "./binaries/packer.zip" -d "/usr/local/bin/";

        util.print.out '\n%s' "Version Packer: "; 
        packer -v;

        mkdir -p "${HOME}/.packer";

        chmod -R 777 "${HOME}/.packer";
        chmod -R 777 "${HOME}/.packer.d";

        # Remove o download do packer
        #rm "./binaries/packer.zip";
    }

    # @descr: Função de desinstalação.
    __uninstall() {
        util.print.out '%s\n' "Iniciando a desinstalação do Packer na maquina..."; 
        
        # Remove files on $HOME
        rm -rf "${HOME}/.packer";
        rm -rf "${HOME}/.packer.d"; 

        # Remove files on BIN
        rm -rf "/usr/local/bin/packer"; 
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
util.try; ( ScriptPacker "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;
