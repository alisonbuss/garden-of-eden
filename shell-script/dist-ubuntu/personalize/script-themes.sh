#!/bin/bash
 
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do Themes na maquina 
# @fonts: https://github.com/pop-os/gtk-theme
#         http://manpages.ubuntu.com/manpages/bionic/man1/runuser.1.html
#         https://www.cyberciti.biz/open-source/command-line-hacks/linux-run-command-as-different-user/
#         https://github.com/daniruiz/Flat-Remix-GTK
#         https://drasite.com/flat-remix-gtk
#         http://tipsonubuntu.com/2017/10/10/ubuntu-17-10-tip-move-window-buttons-min-max-close-left/
#         https://medium.com/@shubhomoybiswas/customizing-ubuntu-18-04-5fda4ea9ded7
#         https://www.ubuntupit.com/materia-theme-a-material-design-theme-for-gnome-gtk/
#         https://github.com/nana-4/materia-theme
#         
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
        apt-get install pop-icon-theme;

        # CHANGE THEME 
        mkdir -p $HOME/Imagens/Wallpapers;
        chmod -R 777 $HOME/Imagens/Wallpapers;
        cp -R ./support-files/wallpapers/* $HOME/Imagens/Wallpapers;
        local wallpaper="$HOME/Imagens/Wallpapers/wallpaper33.png";

        runuser ${username} --command=$(gsettings set org.gnome.desktop.interface gtk-theme "Pop-dark");
        runuser ${username} --command=$(gsettings set org.gnome.desktop.interface icon-theme "Pop");
        runuser ${username} --command=$(gsettings set org.gnome.desktop.interface cursor-theme "Pop");
        runuser ${username} --command=$(gsettings set org.gnome.desktop.background picture-uri "file://${wallpaper}");

        # GNOME TWEAKS 
        apt-get install gnome-tweak-tool;

        # GNOME SHELL 
        apt-get install chrome-gnome-shell;

        # PLUGINS
        local plu01="https://extensions.gnome.org/extension/19/user-themes/";
        local plu02="https://extensions.gnome.org/extension/1160/dash-to-panel/";
        local plu03="https://extensions.gnome.org/extension/307/dash-to-dock/";

        runuser ${username} --command=$(firefox "${plu01}" "${plu02}" "${plu03}");
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
