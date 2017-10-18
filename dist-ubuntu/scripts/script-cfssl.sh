#!/bin/bash

###################  DOC  ###################
# @descr: Instalação do CFSSL na maquina 
# @fonts: https://github.com/cloudflare/cfssl
# @param: 
#    action | text: (install)
#############################################

source <(wget -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/linux/utility.sh");

function ScriptCFSSL {
    
    local ACTION=$1;

    __install() {
        print.info "Iniciando a instalação do CFSSL na maquina..."; 

        source ~/.profile;
        source ~/.bashrc;

        go get -u github.com/cloudflare/cfssl/cmd/cfssl;

        print.out '%s' "Version CFSSL: ";
        cfssl version;
    }

    __actionError() {
        print.error "Erro: 'action' passado:($ACTION) não coincide com [install]!";
    } 

    __initialize() {
        case ${ACTION} in
            install) __install; ;;
            *) __actionError;
        esac
    }

    __initialize;
}

ScriptCFSSL "$@";

exit 0;
