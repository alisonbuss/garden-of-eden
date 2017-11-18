#!/bin/bash

###################  DOC  ###################
# @descr: Instalação e Configurações de customizações do Ubuntu.    
# @param: 
#    action | text: (myeggs)
#############################################

source <(wget -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/linux/utility.sh");

function ScriptViadagens {
    
    local ACTION=$1;

    # @fonts: http://www.edivaldobrito.com.br/como-instalar-a-ultima-versao-do-vlc/
    __install_vlc() {
        print.info "Iniciando a instalação do VLC na maquina..."; 
        
        add-apt-repository ppa:nicola-onorata/desktop;
        apt-get update;
        apt-get install vlc;

        # desinstalar o VLC
        #add-apt-repository ppa:nicola-onorata/desktop --remove;
        #apt-get remove vlc;
        #apt-get autoremove;
    }

    # @fonts: https://sysads.co.uk/2016/05/16/how-to-install-playonlinux-4-2-10-on-ubuntu-16-04/
    #         http://www.edivaldobrito.com.br/playonlinux-chega-a-versao-4-2-4-veja-como-instalar-no-ubuntu/
    #         https://sempreupdate.com.br/2017/04/instalar-o-wine-2-6-no-ubuntu.html
    __install_playonlinux() {
        print.info "Iniciando a instalação do playonlinux na maquina..."; 
        
        add-apt-repository ppa:noobslab/apps;

        apt-get update;

        apt-get install wine;
        apt-get install playonlinux;
        
        # desinstalar o  Wine 2.6
        #apt-get install ppa-purge;
        #ppa-purge ppa:wine/wine-builds;
    }

    # @fonts: http://www.edivaldobrito.com.br/dicas-de-coisas-para-fazer-depois-da-instalacao-do-ubuntu-13-10-faca-pequenos-ajustes-na-interface/#tweaks
    __install_tools_desktop() {
        print.info "Iniciando a instalação das Ferramentas (Unity Tweak Tool, Ferramenta de ajustes do GNOME)"; 
        
        apt-get install unity-tweak-tool;
        apt-get install gnome-tweak-tool;
    }

    # @fonts: http://www.edivaldobrito.com.br/combinando-o-tema-e-os-icones-arc/
    __install_theme_arc() {
        print.info "Iniciando a instalação de um tema viadinho Arc na maquina..."; 
        
        add-apt-repository ppa:noobslab/themes;
        add-apt-repository ppa:noobslab/icons;

        apt-get update;
        apt-get install arc-theme arc-icons;

        # desinstalar tema
        #sudo apt-get remove arc-theme arc-icons
    }

    # @fonts: http://www.edivaldobrito.com.br/tema-adapta-dark-no-ubuntu/
    __install_theme_adapta_dark() {
        print.info "Iniciando a instalação de um tema viadinho Adapta Dark na maquina..."; 
        apt-add-repository ppa:tista/adapta -y;
        apt-get update;
        apt-get install adapta-gtk-theme;

        # desinstalar tema
        #sudo apt-add-repository ppa:tista/adapta --remove
        #sudo apt-get remove adapta-gtk-theme
        #sudo apt-get autoremove
    }

    __config_change_wallpaper() {
        print.info "Iniciando alteração do papel de parede bem gay."; 

        local wallpaper="$PWD/files/wallpaper1.jpg"; 
        gsettings set org.gnome.desktop.background picture-uri "file://$wallpaper";
    }

    __install() {
        print.info "Iniciando as instalações e configurações de customizações do Ubuntu..."; 

        __install_vlc;
        __install_playonlinux;
        __install_tools_desktop;
        __install_theme_arc;
        __config_change_wallpaper;
    }

    __actionError() {
        print.error "Erro: 'action' passado:($ACTION) não coincide com [apply]!";
    } 

    __initialize() {
        case ${ACTION} in
            apply) __install; ;;
            *) __actionError;
        esac
    }

    __initialize;
}

ScriptViadagens "$@";

exit 0;