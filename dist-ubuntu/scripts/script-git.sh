#!/bin/bash

###################  DOC  ###################
# @descr: Instalação do Git na maquina.      
# @fonts: https://www.youtube.com/watch?v=BettUg-L8M4&list=PLV7VqBqvsd_1h7zmEpE-xwgOPqp2IBGCV
# @param: 
#    action | text: (install, uninstall)
#    paramJson | json: {"nameUser":"...","emailUser":"..."}
#############################################

source <(wget -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/linux/utility.sh");

function ScriptGit {

    local ACTION=$1;
    local PARAM_JSON=$2;

    local nameUser=$(echo ${PARAM_JSON} | jq -r '.nameUser');
    local emailUser=$(echo ${PARAM_JSON} | jq -r '.emailUser');

    __install() {
        print.info "Iniciando a instalação do Git na maquina..."; 

        apt-get install git;
        git config --global user.name "$nameUser";
        git config --global user.email $emailUser;

        git --version;
        git config --list;

        print.out '%b' "\033[1;33m";
        print.out '%b' "Sua chave SSH já foi publicada no GitHub? [yes/no]: "; read input_isPublishedKey;
        print.out '%b' "\033[0m";
        # Caso a chave SSH foi publicada no GitHub teste a conexão.
        if [ "$input_isPublishedKey" == "yes" ]; then
            print.warning "Testando a conexão com o GitHub...";
            ssh -T git@github.com;
        fi
    }

    __uninstall() {
        print.info "Iniciando a desinstalação do Git na maquina..."; 
        
        apt-get remove --auto-remove git;
        apt-get purge --auto-remove git;
    }

    __actionError() {
        print.error "Erro: 'action' passado:($ACTION) não coincide com [install, uninstall]!";
    } 

    __initialize() {
        case ${ACTION} in
            install) __install; ;;
            uninstall) __uninstall; ;;
            *) __actionError;
        esac
    }

    __initialize;
}

ScriptGit "$@";

exit 0;