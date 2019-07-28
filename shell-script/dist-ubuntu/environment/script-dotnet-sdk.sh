#!/bin/bash
 
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação e desinstalação do .Net Core SDK na maquina.
# @fonts: https://dotnet.microsoft.com/download/linux-package-manager/ubuntu18-04/sdk-current
#         https://dotnet.microsoft.com/download/linux-package-manager/ubuntu19-04/sdk-current
# @example:
#       bash script-dotnet-sdk.sh --action='install' --param='{"version":"2.2"}'   
#-------------------------------------------------------------#

# @descr: Função principal do script-dotnet-sdk.sh
# @param: 
#    action | text: (install, uninstall)
#    param | json: '{"version":"..."}'
function ScriptDotnetSdk {

     # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");
    # @descr: Variavel de parametros JSON.
    local PARAM_JSON=$(util.getParameterValue "(--param=|-p=)" "$@");

    # @descr: Variavel da versão de instalação.
    local version=$(echo ${PARAM_JSON} | $RUN_JQ -r '.version');
    local version_system=$(lsb_release -r -s);

    # @descr: Função de instalação.
    __install() {
        util.print.out '%s\n' "Iniciando a instalação do .Net Core SDK na maquina..."; 

        wget "https://packages.microsoft.com/config/ubuntu/${version_system}/packages-microsoft-prod.deb" -O "./binaries/packages-microsoft-prod.deb";
        sudo dpkg -i ./binaries/packages-microsoft-prod.deb;
	    sudo apt-get install -f;

        sudo apt-get install -y apt-transport-https;
        sudo apt-get update;

        sudo apt-get install -y "dotnet-sdk-${version}";
        
        dotnet --version;
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
util.try; ( ScriptDotnetSdk "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;
