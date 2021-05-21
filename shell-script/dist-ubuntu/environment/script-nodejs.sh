#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação e desinstalação do NodeJS na maquina.
# @fonts: https://tableless.com.br/como-instalar-node-js-no-linux-corretamente-ubuntu-debian-elementary-os/
#         https://www.digitalocean.com/community/tutorials/como-instalar-o-node-js-no-ubuntu-16-04-pt#como-instalar-utilizando-o-nvm
#         https://www.youtube.com/watch?v=BleYojqCaeQ
# @example:
#       bash script-nodejs.sh --action='install' --param='{"version":"8.4.0"}'
#   OR
#       bash script-nodejs.sh --action='uninstall' --param='{"version":"8.4.0"}'    
#-------------------------------------------------------------#

# @descr: Função principal do script-nodejs.sh
# @param: 
#    action | text: (install, uninstall)
#    param | json: '{"version":"..."}'
function ScriptNodeJS {
    
    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");
    # @descr: Variavel de parametros JSON.
    local PARAM_JSON=$(util.getParameterValue "(--param=|-p=)" "$@");

    # @descr: Variavel da versão de instalação.
    local version=$(echo ${PARAM_JSON} | $RUN_JQ -r '.version');

    # @descr: Função de instalação.
    __install() {
        util.print.out '%s\n' "Iniciando a instalação do NodeJS na maquina..."; 

        source $HOME/.profile;
        source $HOME/.bashrc;

        nvm ls;

        nvm install "$version";
        nvm use "$version";

        util.print.out '%s' "Version Node.js: ";
        node -v;

        util.print.out '%s' "Version NPM: ";
        npm -v;

        # Listar pacotes globais npm instalados localmente
        npm list -g --depth=0
        # Listar pacotes npm instalados localmente
        #npm list --depth=0 

        # @fonts: https://www.computerhope.com/unix/uchown.htm
        #         http://manpages.ubuntu.com/manpages/trusty/man1/chown.1.html
        # CUIDADO COM ESSE COMMANDO FILHO DA PUTA, DEU UM BUG DU INFERNU.
        sudo chown -R $USER:$(id -gn $USER) $HOME/.config;
    
        # App Web para visualizar e verificar os pacotes npm locais.
        # cd c:\your-prject-folder
        #npm install -g npm-gui
        #npm-gui localhost:9000 
    }

    # @descr: Função de desinstalação.
    __uninstall() {
        util.print.out '%s\n' "Iniciando a desinstalação do NodeJS na maquina..."; 
        
        nvm uninstall $version;
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
            install-by-nvm) { 
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
util.try; ( ScriptNodeJS "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}
 
exit 0;