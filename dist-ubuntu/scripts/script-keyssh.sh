#!/bin/bash

###################  DOC  ###################
# @descr: Gerar chave SSH do usuário logado da máquina.  
# @fonts: https://www.youtube.com/watch?v=iVUnXw64Ez8&list=PLV7VqBqvsd_1h7zmEpE-xwgOPqp2IBGCV&index=8
# @param: 
#    action | text: (create, recreate)
#    paramJson | json: {"comment":"...","passwordKey":"...","pathKey":"...","nameKey":"..."}
#############################################

source <(wget -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/linux/utility.sh");

function ScriptKeySSH {

    local ACTION=$1;
    local PARAM_JSON=$2;

    local comment=$(echo ${PARAM_JSON} | jq -r '.comment');
    local passwordKey=$(echo ${PARAM_JSON} | jq -r '.passwordKey');
    local pathKey=$(echo ${PARAM_JSON} | jq -r '.pathKey');
    local nameKey=$(echo ${PARAM_JSON} | jq -r '.nameKey');

    __create() {
        print.info "Iniciando criação da chave SSH na maquina..."; 

        # verifica se tem a pasta, caso não tenha é criada uma pasta.
        if [ ! -d "$pathKey" ] ; then
            mkdir ${pathKey/nameKey};
            chmod -R 777 ${pathKey/nameKey};

            # gera a chave SSH do usuario da maquina.
            ssh-keygen -t rsa -b 4096 -C "$comment" -P "$passwordKey" -f "$pathKey/$nameKey"
        else
            print.warning "Aviso: Sua chave SSH já foi criada!";
        fi 
    } 

    __recreate() {
        print.info "Iniciando a recriação da chave SSH na maquina..."; 
        
        # verifica se tem a pasta, caso não tenha é criada uma pasta.
        if [ -d "$pathKey" ] ; then
            rm -rf "$pathKey/*";

            # gera a chave SSH do usuario da maquina.
            ssh-keygen -t rsa -b 4096 -C "$comment" -P "$passwordKey" -f "$pathKey/$nameKey"
        else
            mkdir ${pathKey/nameKey};
            chmod -R 777 ${pathKey/nameKey};

            # gera a chave SSH do usuario da maquina.
            ssh-keygen -t rsa -b 4096 -C "$comment" -P "$passwordKey" -f "$pathKey/$nameKey"
        fi  
    } 

    __actionError() {
        print.error "Erro: 'action' passado:($ACTION) não coincide com [create, recreate]!";
    } 

    __initialize() {
        case ${ACTION} in
            create) __create; ;;
            recreate) __recreate; ;;
            *) __actionError;
        esac
    }

    __initialize;
}

ScriptKeySSH "$@";

exit 0;