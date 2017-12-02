#!/bin/bash
 
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Instalação do Config Transpiler, ct, é o utilitário responsável por transformar 
#         uma Configuração de Container Linux configurada pelo usuário em uma 
#         configuração Ignition.
# @fonts: https://coreos.com/os/docs/latest/provisioning.html
#         https://coreos.com/os/docs/1478.0.0/overview-of-ct.html
#         https://www.youtube.com/watch?v=TJ6eweO2Rio
# @example:
#       bash script-config-transpiler.sh --action='install' --param='{"version":"0.5.0"}'   
#   OR
#       bash script-config-transpiler.sh --action='uninstall' --param='{}'  
#-------------------------------------------------------------#

source <(wget --no-cache -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/import.sh"); 

import.ShellScriptTools "/linux/utility.sh";

# @descr: Função principal do script-config-transpiler.sh
# @param: 
#    action | text: (install)
#    param | json: '{"version":"..."}'
function ScriptConfigTranspiler {
    
    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");

    # @descr: Variavel de parametros JSON.
    local PARAM_JSON=$(util.getParameterValue "(--param=|-p=)" "$@");

    # @descr: Variavel da versão de instalação.
    local version=$(echo ${PARAM_JSON} | jq -r '.version');

    # @descr: Função de instalação.
    __install() {
        util.print.info "Iniciando a instalação do ConfigTranspiler na maquina..."; 

        local urlDownload="https://github.com/coreos/container-linux-config-transpiler/releases/download";    

        wget "${urlDownload}/v${version}/ct-v${version}-x86_64-unknown-linux-gnu" -O "./binaries/ct";
        chmod -R 777 "./binaries/ct";

        cp "./binaries/ct" "/usr/local/bin";

        util.print.out '%s' "Version ConfigTranspiler: ";
        ct --version;
        util.print.out '%s\n' "";

        # Remover o download do ConfigTranspiler
        #rm ./binaries/ct;
    }

    # @descr: Função de desinstalação.
    __uninstall() {
        util.print.info "Iniciando a desinstalação do ConfigTranspiler na maquina..."; 
        
        rm "/usr/local/bin/ct";
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
            uninstall) { 
                __uninstall;
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