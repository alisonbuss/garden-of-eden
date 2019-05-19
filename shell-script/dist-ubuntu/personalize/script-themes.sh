#!/bin/bash
 
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do Themes na maquina 
# @fonts: https://github.com/pop-os/gtk-theme
#         http://manpages.ubuntu.com/manpages/bionic/man1/runuser.1.html
#         https://www.cyberciti.biz/open-source/command-line-hacks/linux-run-command-as-different-user/
# @example:
#       bash script-themes.sh --action='install' --param='{}'
#-------------------------------------------------------------#

# @descr: Função principal do script-themes.sh
# @param: 
#    action | text: (install)
function ScriptThemes {

    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");
    # @descr: Variavel de parametros JSON.
    local PARAM_JSON=$(util.getParameterValue "(--param=|-p=)" "$@");

    local username=$(echo "${PARAM_JSON}" | $RUN_JQ -r '.username');

    # @descr: Função de instalação.
    __install() {
        util.print.out '%s\n' "Iniciando a instalação do Themes na maquina..."; 

        # GNOME THEME 
        add-apt-repository ppa:system76/pop;
        apt-get update;
        apt-get install pop-theme;

        # GNOME TWEAKS 
        apt-get install gnome-tweak-tool;

        # GNOME SHELL 
        apt-get install chrome-gnome-shell;

        # CHANGE WALLPAPER 
        mkdir -p $HOME/Imagens/Wallpapers;
        chmod -R 777 $HOME/Imagens/Wallpapers;
        cp -R ./support-files/wallpapers/* $HOME/Imagens/Wallpapers;
        local wallpaper="$HOME/Imagens/Wallpapers/wallpaper33.png";

        runuser ${username} --command=$(gsettings set org.gnome.desktop.background picture-uri "file://${wallpaper}");

        # PLUGINS
        local ext01="https://extensions.gnome.org/extension/19/user-themes/";
        local ext02="https://extensions.gnome.org/extension/1160/dash-to-panel/";
        local ext03="https://extensions.gnome.org/extension/307/dash-to-dock/";

        runuser ${username} --command=$(firefox "${ext01}" "${ext02}" "${ext03}");
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
util.try; ( ScriptThemes "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;
