#!/bin/bash

###################  DOC  ###################
# @descr: Instalação e Configurações de customizações do Ubuntu.    
# @fonts: ...
# @param: param | json
# @example: 
#    $ sudo chmod a+x install-viadagens.sh
#    $ sudo ./install-viadagens.sh
#############################################

function InstallViadagens {
    local param=$1;

    __install_chrome() {
        echo "Iniciando a instalação do Chrome na maquina..."; 
        wget "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" -O ./binaries/chrome.deb;
        chmod -R 777 ./binaries/chrome.deb;
        dpkg -i ./binaries/chrome.deb;
        # Remover o download do Chrome
        rm ./binaries/chrome.deb;
    }

    __install_wine() {
        # FONT: http://www.edivaldobrito.com.br/playonlinux-chega-a-versao-4-2-4-veja-como-instalar-no-ubuntu/
        #       https://sempreupdate.com.br/2017/04/instalar-o-wine-2-6-no-ubuntu.html
        echo "Iniciando a instalação do Wine na maquina..."; 
        sudo add-apt-repository ppa:noobslab/apps
        apt-get update;
        apt-get install playonlinux;
        
        #add-apt-repository ppa:wine/wine-builds;
        #apt-get update;
        #sudo apt-get -f install;
        #apt-get install --install-recommends wine-staging;
        #apt-get install winehq-staging;
        # desinstalar o  Wine 2.6
        #apt-get install ppa-purge;
        #ppa-purge ppa:wine/wine-builds;
    }

    __install_tools_desktop() {
        # FONT: http://www.edivaldobrito.com.br/dicas-de-coisas-para-fazer-depois-da-instalacao-do-ubuntu-13-10-faca-pequenos-ajustes-na-interface/#tweaks
        apt-get install unity-tweak-tool;
        apt-get install gnome-tweak-tool;
    }

    __install_theme_arc() {
        # FONT: http://www.edivaldobrito.com.br/combinando-o-tema-e-os-icones-arc/
        echo "Iniciando a instalação de um tema viadinho Arc na maquina..."; 
        add-apt-repository ppa:noobslab/themes;
        add-apt-repository ppa:noobslab/icons;
        apt-get update;
        apt-get install arc-theme arc-icons;

        # desinstalar tema
        #sudo apt-get remove arc-theme arc-icons
    }

    __install_theme_adapta_dark() {
        # FONT: http://www.edivaldobrito.com.br/tema-adapta-dark-no-ubuntu/
        echo "Iniciando a instalação de um tema viadinho Adapta Dark na maquina..."; 
        apt-add-repository ppa:tista/adapta -y;
        apt-get update;
        apt-get install adapta-gtk-theme;

        # desinstalar tema
        #sudo apt-add-repository ppa:tista/adapta --remove
        #sudo apt-get remove adapta-gtk-theme
        #sudo apt-get autoremove
    }

    __config_change_wallpaper() {
        local wallpaper="$PWD/files/wallpaper1.jpg"; 
        gsettings set org.gnome.desktop.background picture-uri "file://$wallpaper";
    }

    __install() {
        __install_chrome;
        __install_wine;
        __install_tools_desktop;
        __install_theme_arc;
        __config_change_wallpaper;
    }

    __initialize() {
        echo "Iniciando as instalações e configurações de customizações do Ubuntu..."; 
        __install;
    }

    __initialize;
}

InstallViadagens $1;

exit 0;