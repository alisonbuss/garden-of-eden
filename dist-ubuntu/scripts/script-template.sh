#!/bin/bash

###################  DOC  ###################
# @descr: Sua Descrição. 
# @fonts: Fontes de referências
# @param: 
#    action | text: (açãoA, açãoB)                 "PARAMETRO "action" É PADRÃO"
#    paramJson | json: {"versionExemplo":"..."}    "PARAMETRO DE EXEMPLO"
#############################################

source <(wget -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/linux/utility.sh");

function ScriptNomeDoQueVaiFazer {
    
    local ACTION=$1;
    local PARAM_JSON=$2;
    
    local version=$(echo ${PARAM_JSON} | jq -r '.versionExemplo');

    __install() {
        print.info "Iniciando..."; 

       
    }

    __uninstall() {
        print.info "Iniciando..."; 
        
        
    }

    __actionError() {
        print.error "Erro: 'action' passado:($ACTION) não coincide com [açãoA, açãoB]!";
    } 

    __initialize() {
        case ${ACTION} in
            açãoA) __install; ;;
            açãoB) __uninstall; ;;
            *) __actionError;
        esac
    }

    __initialize;
}

ScriptNomeDoQueVaiFazer "$@";

exit 0;