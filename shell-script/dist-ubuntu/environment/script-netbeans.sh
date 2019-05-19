#!/bin/bash
 
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação e desinstalação do Netbeans na maquina.
# @fonts: http://www.edivaldobrito.com.br/ultima-versao-do-netbeans-no-linux/
#         http://ubuntuhandbook.org/index.php/2016/10/netbeans-8-2-released-how-to-install-it-in-ubuntu-16-04/
#         https://computingforgeeks.com/install-netbeans-ide-on-debian-ubuntu-and-linux-mint/
#         https://snapcraft.io/netbeans
# @example:
#       bash script-netbeans.sh --action='install' --param='{}'
#-------------------------------------------------------------#

# @descr: Função principal do script-netbeans.sh
# @param: 
#    action | text: (install)
function ScriptNetbeans {
    
    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");

    # @descr: Função de instalação com Snap.
    __install_snap() {
        util.print.out '%s\n' "Iniciando a instalação do Netbeans na maquina...";

        snap install netbeans --classic;
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
                __install_snap; 
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
util.try; ( ScriptNetbeans "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;