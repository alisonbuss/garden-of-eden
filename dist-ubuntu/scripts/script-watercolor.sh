#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Instalação e Configurações de customizações do Ubuntu.   
# @fonts: http://www.edivaldobrito.com.br/instalar-visual-studio-code-no-linux-usando-pacotes/
#         http://the-coderok.azurewebsites.net/2016/09/30/How-to-install-Visual-Studio-Code-on-Ubuntu-using-Debian-package-manager/
# @example:
#       bash script-watercolor.sh --action='apply' --param='{"forLinux":"ubuntu-17-10"}'
#-------------------------------------------------------------#

source <(wget --no-cache -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/import.sh"); 

import.ShellScriptTools "/linux/utility.sh";

# @descr: Função principal do script-watercolor.sh
# @param: 
#    action | text: (apply)
#    param | json: '{"forLinux":"..."}'
function ScriptWatercolor {
    
    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");

    # @descr: Variavel de parametros JSON.
    local PARAM_JSON=$(util.getParameterValue "(--param=|-p=)" "$@");

    # @descr: Variavel do tipo da distribuição que vai ser usada.
    local forLinux=$(echo "${PARAM_JSON}" | jq -r '.forLinux');

    # @descr: Função de instalação do VLC.
    # @fonts: http://www.edivaldobrito.com.br/como-instalar-a-ultima-versao-do-vlc/
    __install_vlc() {
        util.print.info "Iniciando a instalação do VLC na maquina..."; 
        add-apt-repository ppa:nicola-onorata/desktop;
        apt-get update;
        apt-get install vlc;
        # desinstalar o VLC
        #add-apt-repository ppa:nicola-onorata/desktop --remove;
        #apt-get remove vlc;
        #apt-get autoremove;
    }

    # @descr: Função de instalação do playonlinux.
    # @fonts: https://sysads.co.uk/2016/05/16/how-to-install-playonlinux-4-2-10-on-ubuntu-16-04/
    #         http://www.edivaldobrito.com.br/playonlinux-chega-a-versao-4-2-4-veja-como-instalar-no-ubuntu/
    #         https://sempreupdate.com.br/2017/04/instalar-o-wine-2-6-no-ubuntu.html
    __install_playonlinux() {
        util.print.info "Iniciando a instalação do playonlinux na maquina..."; 
        add-apt-repository ppa:noobslab/apps;
        apt-get update;
        apt-get install wine;
        apt-get install playonlinux;
        # desinstalar o  Wine 2.6
        #apt-get install ppa-purge;
        #ppa-purge ppa:wine/wine-builds;
    }

    # @descr: Função de instalação do tweak-tool.
    # @fonts: http://www.edivaldobrito.com.br/dicas-de-coisas-para-fazer-depois-da-instalacao-do-ubuntu-13-10-faca-pequenos-ajustes-na-interface/#tweaks
    __install_tools_desktop() {
        util.print.info "Iniciando a instalação das Ferramentas (Tweak Tool, Ferramenta de ajustes do GNOME/UNITY)"; 
        # For interface Unity the Ubuntu 16.04
        apt-get install unity-tweak-tool;
    }

    # @descr: Função de instalação do Tema Arc no Ubuntu Desktop.
    # @fonts: http://www.edivaldobrito.com.br/combinando-o-tema-e-os-icones-arc/
    __install_theme_arc() {
        util.print.info "Iniciando a instalação de um tema viadinho Arc na maquina..."; 
        add-apt-repository ppa:noobslab/themes;
        add-apt-repository ppa:noobslab/icons;
        apt-get update;
        apt-get install arc-theme arc-icons;
        # desinstalar tema
        #sudo apt-get remove arc-theme arc-icons
    }

    # @descr: Função de instalação do Tema Dark no Ubuntu Desktop.
    # @fonts: http://www.edivaldobrito.com.br/tema-adapta-dark-no-ubuntu/
    __install_theme_adapta_dark() {
        util.print.info "Iniciando a instalação de um tema viadinho Adapta Dark na maquina..."; 
        apt-add-repository ppa:tista/adapta -y;
        apt-get update;
        apt-get install adapta-gtk-theme;
        # desinstalar tema
        #sudo apt-add-repository ppa:tista/adapta --remove
        #sudo apt-get remove adapta-gtk-theme
        #sudo apt-get autoremove
    }

    # @descr: Função de alteração do papel de parade no Ubuntu Desktop.
    __config_change_wallpaper() {
        util.print.info "Iniciando alteração do papel de parede bem gay."; 
        local wallpaper="$PWD/files/wallpaper1.jpg"; 
        gsettings set org.gnome.desktop.background picture-uri "file://$wallpaper";
    }


    # @descr: Função de instalação para Ubuntu 16.04.
    __installUbuntu1604() {
        __install_tools_desktop;
        __install_theme_arc;
        __config_change_wallpaper;
        #__install_playonlinux;
        #__install_vlc;
    }

    # @descr: Função de instalação para Ubuntu 17.10.
    __installUbuntu1710() {
        #GNOME THEME 
        sudo add-apt-repository ppa:system76/pop;
        sudo apt update;
        sudo apt install pop-theme;

        #GNOME TWEAKS 
        apt-get install gnome-tweak-tool;

        #GNOME SHELL 
        apt-get install chrome-gnome-shell;

        #APP VIDEO
        add-apt-repository ppa:nicola-onorata/desktop;
        apt-get update;
        apt-get install vlc;
    }

    # @descr: Função de instalação geral.
    __install() {
        util.print.info "Iniciando as instalações e configurações de customizações do Ubuntu..."; 

        case ${forLinux} in
            ubuntu-16.04) { 
                __installUbuntu1604; 
            };;
            ubuntu-17.10) { 
                __installUbuntu1710; 
            };;
            *) {
               __actionError "--action=${ACTION}"; 
            };;
        esac
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
            apply) { 
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
util.try; ( ScriptWatercolor "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;