#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação e desinstalação do VS Code na maquina.   
# @fonts: http://www.edivaldobrito.com.br/instalar-visual-studio-code-no-linux-usando-pacotes/
#         http://the-coderok.azurewebsites.net/2016/09/30/How-to-install-Visual-Studio-Code-on-Ubuntu-using-Debian-package-manager/
# @example:
#       bash script-vscode.sh --action='install' --param='{}'
#   OR
#       bash script-vscode.sh --action='uninstall' --param='{}'    
#-------------------------------------------------------------#

# @descr: Função principal do script-vscode.sh
# @param: 
#    action | text: (install, uninstall)
function ScriptVSCode {
    
    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");

    # @descr: Função de instalação.
    __install() {
        util.print.out '%s\n' "Iniciando a instalação do VS Code na maquina..."; 

        wget "https://go.microsoft.com/fwlink/?LinkID=760868" -O ./binaries/vscode.deb;

        sudo dpkg -i ./binaries/vscode.deb;
	    sudo apt-get install -f;

        code --version;

        # Util
        code --install-extension christian-kohler.path-intellisense;

        # Docker
        code --install-extension ms-azuretools.vscode-docker;

        # Themes
        code --install-extension GitHub.github-vscode-theme;
        code --install-extension vscode-icons-team.vscode-icons;
    }

    # @descr: Função de desinstalação.
    __uninstall() {
        util.print.out '%s\n' "Iniciando a desinstalação do VS Code na maquina..."; 
        
        sudo apt-get remove --auto-remove code;
        sudo apt-get purge --auto-remove code;
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
util.try; ( ScriptVSCode "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}
 
exit 0;
