#!/bin/bash

###################  DOC  ###################
# @descr: Instalação do Netbeans na maquina.
# @fonts: http://www.edivaldobrito.com.br/ultima-versao-do-netbeans-no-linux/
#         http://ubuntuhandbook.org/index.php/2016/10/netbeans-8-2-released-how-to-install-it-in-ubuntu-16-04/
# @param: 
#    action | text: (install, uninstall)
#############################################

function ScriptNetbeans {
    
    local ACTION=$1;

    __install() {
        print.info "Iniciando a instalação do Netbeans na maquina...";

        wget "http://download.netbeans.org/netbeans/8.2/final/bundles/netbeans-8.2-linux.sh" -O ./binaries/netbeans.sh;
        chmod -R 777 ./binaries/netbeans.sh;

        chmod +x ./binaries/netbeans.sh;
        ./binaries/netbeans.sh;

        # Remove o download do Netbeans
        rm ./binaries/netbeans.sh;
    }

    __uninstall() {
        print.info "Iniciando a desinstalação do Netbeans na maquina..."; 
        
        $HOME/netbeans-8.2/uninstall.sh;
    }

    __actionError() {
        print.error "Erro: 'action' passado:($ACTION) não coincide com [install, uninstall]!";
    } 

    __initialize() {
        case ${ACTION} in
            install) __install; ;;
            uninstall) __uninstall; ;;
            *) __actionError;
        esac
    }

    __initialize;
}

ScriptNetbeans "$@";

exit 0;