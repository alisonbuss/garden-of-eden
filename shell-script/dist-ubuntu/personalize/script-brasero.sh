#!/bin/bash
 
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do Brasero na maquina 
# @fonts: https://medium.com/@mangeshdhulap26/how-to-install-brasero-cd-burner-disc-burner-in-ubuntu-18-04-6d1c9fc9a435
#         https://www.itsmarttricks.com/how-to-install-brasero-disc-burner-software-in-ubuntu-18-04/
#         https://e-tinet.com/linux/9-programas-gravar-cd-dvd-no-ubuntu/
#         https://www.linuxtechi.com/top10-things-after-installing-ubuntu-18-04/
# @example:
#       bash script-brasero.sh --action='install' --param='{}'
#-------------------------------------------------------------#

# @descr: Função principal do script-brasero.sh
# @param: 
#    action | text: (install)
function ScriptBrasero {

    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");

    # @descr: Função de instalação.
    __install() {
        util.print.out '%s\n' "Iniciando a instalação do Brasero na maquina..."; 

        apt-get install -y brasero;
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
util.try; ( ScriptBrasero "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;
