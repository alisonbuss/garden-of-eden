#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação e desinstalação do Netbeans na maquina.
# @fonts: http://www.edivaldobrito.com.br/ultima-versao-do-netbeans-no-linux/
#         http://ubuntuhandbook.org/index.php/2016/10/netbeans-8-2-released-how-to-install-it-in-ubuntu-16-04/
# @example:
#       bash script-netbeans.sh --action='install' --param='{}'
#   OR
#       bash script-netbeans.sh --action='uninstall' --param='{}'    
#-------------------------------------------------------------#

source <(wget --no-cache -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/import.sh"); 

import.ShellScriptTools "/linux/utility.sh";

# @descr: Função principal do script-netbeans.sh
# @param: 
#    action | text: (install, uninstall)
function ScriptNetbeans {
    
    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");

    # @descr: Função de instalação.
    __install() {
        util.print.info "Iniciando a instalação do Netbeans na maquina...";

        wget "http://download.netbeans.org/netbeans/8.2/final/bundles/netbeans-8.2-linux.sh" -O ./binaries/netbeans.sh;
        chmod -R 777 ./binaries/netbeans.sh;

        chmod +x ./binaries/netbeans.sh;
        ./binaries/netbeans.sh;

        # Remove o download do Netbeans
        rm ./binaries/netbeans.sh;
    }

    # @descr: Função de desinstalação.
    __uninstall() {
        util.print.info "Iniciando a desinstalação do Netbeans na maquina..."; 
        
        $HOME/netbeans-8.2/uninstall.sh;
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
util.try; ( ScriptNetbeans "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;