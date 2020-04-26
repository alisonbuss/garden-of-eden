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

    # @descr: Função de instalação.
    __install() {
        util.print.out '%s\n' "Iniciando a instalação do Themes na maquina..."; 

        # GNOME THEME
        #sudo add-apt-repository -y ppa:system76/pop;
        #sudo apt-get update;
        
        #sudo apt-get install -y pop-theme;
        #sudo apt-get install -y pop-icon-theme;

         # GNOME TWEAKS 
        sudo apt-get install -y gnome-tweak-tool;

        # GNOME SHELL 
        sudo apt-get install -y chrome-gnome-shell;

        # CHANGE THEME 
        #gsettings set org.gnome.desktop.interface gtk-theme 'Pop-dark';
        #gsettings set org.gnome.desktop.interface icon-theme 'Pop';
        #gsettings set org.gnome.desktop.interface cursor-theme 'Pop';

        util.print.out '%s\n' "Instale esses plugins no firefox..."; 
        util.print.out '%s\n' "  --> https://extensions.gnome.org/extension/19/user-themes/"; 
        util.print.out '%s\n' "  --> https://extensions.gnome.org/extension/1160/dash-to-panel/"; 
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
