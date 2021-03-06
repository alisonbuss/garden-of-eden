#!/bin/bash
 
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do psensor na maquina 
# @fonts: https://wpitchoune.net/psensor/
#         https://www.edivaldobrito.com.br/monitorar-a-temperatura-do-pc/
#         https://itsfoss.com/check-laptop-cpu-temperature-ubuntu/
# @example:
#       bash script-psensor.sh --action='install' --param='{}'
#-------------------------------------------------------------#

# @descr: Função principal do script-psensor.sh
# @param: 
#    action | text: (install)
function ScriptPsensor {

    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");

    # @descr: Função de instalação.
    __install() {
        util.print.out '%s\n' "Iniciando a instalação do Psensor na maquina..."; 

        sudo apt-get install -y lm-sensors hddtemp;
        sudo apt-get install -y psensor;
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
util.try; ( ScriptPsensor "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;
