#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação e desinstalação do GitKraken na maquina 
# @fonts: https://support.gitkraken.com/how-to-install
# @example:
#       bash script-gitkraken.sh --action='install' --param='{}'
#   OR
#       bash script-gitkraken.sh --action='uninstall' --param='{}'    
#-------------------------------------------------------------#

source <(wget --no-cache -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/import.sh"); 

import.ShellScriptTools "/linux/utility.sh";

# @descr: Função principal do script-gitkraken.sh
# @param: 
#    action | text: (install, uninstall)
function ScriptGitKraken {
    
    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");

    # @descr: Função de instalação.
    __install() {
        util.print.info "Iniciando a instalação do GitKraken na maquina..."; 

        wget "https://release.gitkraken.com/linux/gitkraken-amd64.deb" -O ./binaries/gitkraken.deb;
        chmod -R 777 ./binaries/gitkraken.deb;

        dpkg -i ./binaries/gitkraken.deb;

        # Remover o download do GitKraken
        rm ./binaries/gitkraken.deb;
    }

    # @descr: Função de desinstalação.
    __uninstall() {
        util.print.info "Iniciando a desinstalação do GitKraken na maquina..."; 
        
        apt-get remove --auto-remove gitkraken;
        apt-get purge --auto-remove gitkraken;
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
util.try; ( ScriptGitKraken "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;