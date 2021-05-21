#!/bin/bash
 
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do Insomnia Core na maquina.   
# @fonts: 
# @example:
#       bash script-insomnia-core.sh --action='install' --param='{}'
#-------------------------------------------------------------#

# @descr: Função principal do script-insomnia-core.sh
# @param: 
#    action | text: (install)
function ScriptInsomniaCore {

    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");
    # @descr: Variavel de parametros JSON.
    local PARAM_JSON=$(util.getParameterValue "(--param=|-p=)" "$@");

    # @descr: Variavel da versão de instalação.
    local version=$(echo "${PARAM_JSON}" | $RUN_JQ -r '.version');

    # @descr: Função de instalação.
    __install() {
        util.print.out '%s\n' "Iniciando a instalação do Insomnia Core na maquina..."; 
        
        sudo wget "https://github.com/Kong/insomnia/releases/download/core%40${version}/Insomnia.Core-${version}.deb" -O ./binaries/insomnia-core.deb;

        sudo dpkg -i ./binaries/insomnia-core.deb;
	    sudo apt-get install -f;

        # sudo wget "https://github.com/Kong/insomnia/releases/download/v7.1.1/Insomnia-7.1.1.AppImage" -O /usr/local/bin/insomnia-core.AppImage;
        # sudo chmod +x /usr/local/bin/insomnia-core.AppImage;

        # mkdir -p $HOME/.local/share/icons;
        # cp -f -v ./binaries/logo-insomnia.png $HOME/.local/share/icons/logo-insomnia.png;
   
        # mkdir -p $HOME/.local/share/applications;
        # touch $HOME/.local/share/applications/insomnia-core.desktop
        # {
        #     echo '[Desktop Entry]';
        #     echo 'Type=Application';
        #     echo 'Name=Insomnia Core';
        #     echo 'Comment=The Desktop API client for REST and GraphQL';
        #     echo 'Icon='$HOME'/.local/share/icons/logo-insomnia.png';
        #     echo 'Exec="/usr/local/bin/insomnia-core.AppImage" %U';
        #     echo 'Terminal=false';
        #     echo 'Categories=Development;';
        # } > $HOME/.local/share/applications/insomnia-core.desktop;

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
util.try; ( ScriptInsomniaCore "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;
