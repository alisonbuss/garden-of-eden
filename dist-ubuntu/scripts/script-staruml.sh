#!/bin/bash
 
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação e desinstalação do StarUML na maquina.   
# @fonts: http://www.edivaldobrito.com.br/problemas-ao-instalar-ou-executar-programas-no-ubuntu-15-04/
#         https://www.youtube.com/watch?v=zGdwylAeZCY
#         https://packages.ubuntu.com/uk/trusty-updates/amd64/libgcrypt11/download
#         http://staruml.io/download
# @example:
#       bash script-staruml.sh --action='install' --param='{}'
#   OR
#       bash script-staruml.sh --action='uninstall' --param='{}'    
#-------------------------------------------------------------#

source <(wget --no-cache -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/import.sh"); 

import.ShellScriptTools "/linux/utility.sh";

# @descr: Função principal do script-staruml.sh
# @param: 
#    action | text: (install, uninstall)
function ScriptStarUML {

    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");

    # @descr: Função de instalação.
    __install() {
        util.print.info "Iniciando a instalação do StarUML na maquina..."; 

        wget "http://ubuntu.cs.utah.edu/ubuntu/pool/main/libg/libgcrypt11/libgcrypt11_1.5.3-2ubuntu4.5_amd64.deb" -O ./binaries/libgcrypt11.deb;
        chmod -R 644 ./binaries/libgcrypt11.deb;

        wget "http://staruml.io/download/release/v2.8.0/StarUML-v2.8.0-64-bit.deb" -O ./binaries/staruml.deb;
        chmod -R 644 ./binaries/staruml.deb;

        dpkg -i ./binaries/libgcrypt11.deb;
	    apt-get -f install;

        dpkg -i ./binaries/staruml.deb;
	    apt-get -f install;

        # Remover os download do libgcrypt11 e StarUML
        #rm ./binaries/libgcrypt11.deb;
        #rm ./binaries/staruml.deb;
    }

    # @descr: Função de desinstalação.
    __uninstall() {
        util.print.info "Iniciando a desinstalação do StarUML na maquina..."; 

        apt-get remove --auto-remove staruml;
        apt-get purge --auto-remove staruml;
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
util.try; ( ScriptStarUML "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;
