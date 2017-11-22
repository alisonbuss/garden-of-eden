#!/bin/bash
 
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Instalação do Config Transpiler, ct, é o utilitário responsável por transformar 
#         uma Configuração de Container Linux configurada pelo usuário em uma 
#         configuração Ignition.
# @fonts: https://coreos.com/os/docs/latest/provisioning.html
#         https://coreos.com/os/docs/1478.0.0/overview-of-ct.html
# @example:
#       bash script-config-transpiler.sh --action='install' --param='{}'   
#-------------------------------------------------------------#

source <(wget --no-cache -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/import.sh"); 

import.ShellScriptTools "/linux/utility.sh";

# @descr: Função principal do script-config-transpiler.sh
# @param: 
#    action | text: (install)
function ScriptConfigTranspiler {
    
    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");

    # @descr: Função de instalação.
    __install() {
        util.print.info "Iniciando a instalação do ConfigTranspiler na maquina..."; 

       
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
util.try; ( ScriptConfigTranspiler "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;