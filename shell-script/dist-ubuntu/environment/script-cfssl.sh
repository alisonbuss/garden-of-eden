#!/bin/bash
 
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Instalação do CFSSL na maquina 
# @fonts: https://github.com/cloudflare/cfssl
#         https://blog.cloudflare.com/introducing-cfssl/
#         https://medium.com/@rob.blackbourn/how-to-use-cfssl-to-create-self-signed-certificates-d55f76ba5781
#         http://www.pimwiddershoven.nl/entry/install-cfssl-and-cfssljson-cloudflare-kpi-toolkit  
#         https://coreos.com/os/docs/latest/generate-self-signed-certificates.html
# @example:
#       bash script-cfssl.sh --action='install' --param='{}'   
#-------------------------------------------------------------#

# @descr: Função principal do script-cfssl.sh 
# @param: 
#    action | text: (install)
function ScriptCFSSL {
    
    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");

    # @descr: Variavel da versão de instalação.
    local version=$(echo ${PARAM_JSON} | $RUN_JQ -r '.version');

    # @descr: Função de instalação.
    __install() {
        util.print.out '%s\n' "Iniciando a instalação do CFSSL na maquina..."; 

        #sudo apt-get install -y curl;
        #sudo curl "https://pkg.cfssl.org/R1.2/cfssl_linux-amd64" -o "/usr/local/bin/cfssl";
        #sudo curl "https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64" -o "/usr/local/bin/cfssljson";

        sudo wget "https://github.com/cloudflare/cfssl/releases/download/v${version}/cfssl_${version}_linux_amd64" -O "/usr/local/bin/cfssl";
        sudo wget "https://github.com/cloudflare/cfssl/releases/download/v${version}/cfssljson_${version}_linux_amd64" -O "/usr/local/bin/cfssljson";
        
        sudo chmod +x "/usr/local/bin/cfssl" "/usr/local/bin/cfssljson";

        util.print.out '%s' "Version CFSSL: ";
        cfssl version;
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
util.try; ( ScriptCFSSL "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;
