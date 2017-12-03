#!/bin/bash
 
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação e desinstalação do Node Version Manager (NVM) na maquina.
#         Script bash simples para gerenciar várias versões do node.js ativo.
# @fonts: https://github.com/creationix/nvm
#         https://tableless.com.br/como-instalar-node-js-no-linux-corretamente-ubuntu-debian-elementary-os/
#         https://www.digitalocean.com/community/tutorials/como-instalar-o-node-js-no-ubuntu-16-04-pt#como-instalar-utilizando-o-nvm
#         https://www.youtube.com/watch?v=BleYojqCaeQ
# @example:
#       bash script-nvm.sh --action='install' --param='{"version":"0.33.3"}'
#   OR
#       bash script-nvm.sh --action='uninstall' --param='{"version":"0.33.3"}'    
#-------------------------------------------------------------#

source <(wget --no-cache -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/import.sh"); 

import.ShellScriptTools "/linux/utility.sh";

# @descr: Função principal do script-nvm.sh
# @param: 
#    action | text: (install, uninstall)
#    param | json: '{"version":"..."}'
function ScriptNVM {

    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");

    # @descr: Variavel de parametros JSON.
    local PARAM_JSON=$(util.getParameterValue "(--param=|-p=)" "$@");

    # @descr: Variavel da versão de instalação.
    local version=$(echo ${PARAM_JSON} | jq -r '.version');

    # @descr: Função de instalação.
    __install() {
        util.print.info "Iniciando a instalação do NVM na maquina..."; 

        # pacotes de dependências que já estão no repositório de sua distribuição Debian Based
	    # https://github.com/creationix/nvm#important-notes
        #apt-get install build-essential libssl-dev;

        wget -qO- "https://raw.githubusercontent.com/creationix/nvm/v$version/install.sh" | bash;
        source ~/.nvm/nvm.sh;
        source ~/.profile;
        source ~/.bashrc;
        
        chmod -R 755 $HOME/.nvm;

        echo -n "Version NVM: ";
        nvm --version;
    }

    # @descr: Função de desinstalação.
    __uninstall() {
        util.print.info "Iniciando a desinstalação do NVM na maquina..."; 

        rm -rf "$HOME/.nvm/";
        rm -rf "$HOME/nvm/";
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
util.try; ( ScriptNVM "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;
