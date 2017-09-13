#!/bin/bash

###################  DOC  ###################
# @descr: Gerar chave SSH do usuário logado da máquina.  
# @fonts: https://www.youtube.com/watch?v=iVUnXw64Ez8&list=PLV7VqBqvsd_1h7zmEpE-xwgOPqp2IBGCV&index=8
# @param: 
#    action | text: (create, recreate)
#    paramJson | josn: {"comment":"...","passwordKey":"...","pathKey":"...","nameKey":"..."}
#############################################

source "./shell-script-tools/ubuntu/extension-jq.sh";

function ScriptKeySSH {

    local ACTION=$1;
    local PARAM_JSON=$2;

    local comment=$(echo ${PARAM_JSON} | jq -r '.comment');
    local passwordKey=$(echo ${PARAM_JSON} | jq -r '.passwordKey');
    local pathKey=$(echo ${PARAM_JSON} | jq -r '.pathKey');
    local nameKey=$(echo ${PARAM_JSON} | jq -r '.nameKey');

    __create() {
        print.info "Iniciando criação da chave SSH na maquina..."; 

        print.out '%s\n' "comment: $comment";
        print.out '%s\n' "passwordKey: $passwordKey";
        print.out '%s\n' "pathKey: $pathKey";
        print.out '%s\n' "nameKey: $nameKey";
    } 

    __recreate() {
        print.info "Iniciando a recriação da chave SSH na maquina..."; 
        
        print.out '%s\n' "comment: $comment";
        print.out '%s\n' "passwordKey: $passwordKey";
        print.out '%s\n' "pathKey: $pathKey";
        print.out '%s\n' "nameKey: $nameKey";
    } 

    __actionError() {
        print.error "Erro: 'action' passado:($ACTION) não coincide com [create, recreate]!";
    } 

    __generate() {
         echo "temp....";
        #msgInfo "Iniciando geração da chave SSH na maquina..."; 
       
        # verifica se tem a pasta, caso não tenha é criada uma pasta.
        #if [ ! -d "$pathKey" ] ; then
        #    mkdir ${pathKey/nameKey};
        #    chmod -R 777 ${pathKey/nameKey};
        #fi
        # gera a chave SSH do usuario da maquina.
        #ssh-keygen -t rsa -b 4096 -C "$comment" -P "$passwordKey" -f "$pathKey/$nameKey"
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