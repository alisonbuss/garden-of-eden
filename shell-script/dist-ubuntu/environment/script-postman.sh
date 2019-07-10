#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do Postman na maquina.
# @fonts: http://ubuntuhandbook.org/index.php/2018/09/install-postman-app-easily-via-snap-in-ubuntu-18-04/
#         https://www.bluematador.com/blog/postman-how-to-install-on-ubuntu-1604
#         https://matheuslima.com.br/como-instalar-o-postman-no-ubuntu
# @example:
#       bash script-postman.sh --action='install' --param=null   
#-------------------------------------------------------------#

# @descr: Função principal do script-postman.sh
# @param: 
#    action | text: (install)
function ScriptPostman {

    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");

    # @descr: Função de instalação.
    __install() {
        util.print.out '%s\n' "Iniciando a instalação do Postman na maquina...";

        # https://snapcraft.io/postman
        # sudo snap install postman;

        # OR...

        wget "https://dl.pstmn.io/download/latest/linux64" -O ./binaries/postman.tar.gz;

        sudo tar -xzf ./binaries/postman.tar.gz -C /opt;
        sudo ln -s /opt/Postman/Postman /usr/local/bin/postman;

        mkdir -p $HOME/.local/share/applications;
        touch $HOME/.local/share/applications/postman.desktop
        {
            echo '[Desktop Entry]';
            echo 'Type=Application';
            echo 'Name=Postman';
            echo 'Comment=Postman: API Development Environment';
            echo 'Icon=/opt/Postman/app/resources/app/assets/icon.png';
            echo 'Exec=postman';
            echo 'Terminal=false';
            echo 'Categories=Development;';

        } > $HOME/.local/share/applications/postman.desktop;
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
            *) {
               __actionError "--action=${ACTION}"; 
            };;
        esac
    }

    # @descr: Chamada da função principal de inicialização do script.
    __initialize;
}

# SCRIPT INITIALIZE...
util.try; ( ScriptPostman "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;
