#!/bin/bash

###################  DOC  ###################
# @descr: O Config Transpiler, ct, é o utilitário responsável por transformar 
#         uma Configuração de Container Linux configurada pelo usuário em uma 
#         configuração Ignition.
# @fonts: https://coreos.com/os/docs/latest/provisioning.html
#         https://coreos.com/os/docs/1478.0.0/overview-of-ct.html
# @param: 
#    action | text: (install)
#############################################

function ScriptConfigTranspiler {
    
    local ACTION=$1;

    __install() {
        echo "Instalando o Config Transpiler...";
        sleep 1s;
    }

    __actionError() {
        print.error "Erro: 'action' passado:($ACTION) não coincide com [install, uninstall]!";
    } 

    __initialize() {
        case ${ACTION} in
            install) __install; ;;
            *) __actionError;
        esac
    }

    __initialize;
}

ScriptConfigTranspiler "$@";

exit 0