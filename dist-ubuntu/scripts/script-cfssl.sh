#!/bin/bash

###################  DOC  ###################
# @descr: Instalação do CFSSL na maquina 
# @fonts: https://github.com/cloudflare/cfssl
# @param: 
#    action | text: (install)
#############################################

function ScriptCFSSL {
    
    local ACTION=$1;

    __install() {
        print.info "Iniciando a instalação do CFSSL na maquina..."; 

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
