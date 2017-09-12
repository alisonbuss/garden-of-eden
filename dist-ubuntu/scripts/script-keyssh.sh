#!/bin/bash

###################  DOC  ###################
# @descr: Gerar chave SSH do usuário logado da máquina.  
# @fonts: https://www.youtube.com/watch?v=iVUnXw64Ez8&list=PLV7VqBqvsd_1h7zmEpE-xwgOPqp2IBGCV&index=8
# @param: 
#    action | text: (create, recreate)
#    paramJson | josn: ('{"comment":"...","passwordKey":"...","pathKey":"...","nameKey":"..."}')   
# @example: 
#    $ sudo chmod a+x script-keyssh.sh
#    $ sudo ./script-keyssh.sh create {"comment":"key You","passwordKey":"666","pathKey":"/home/??/.ssh","nameKey":"id_rsa"}
#############################################

function ScriptKeySSH {
    local action=$1;
    local paramJson=$2;
    local comment=$(echo ${paramJson} | jq -r '.comment');
    local passwordKey=$(echo ${paramJson} | jq -r '.passwordKey');
    local pathKey=$(echo ${paramJson} | jq -r '.pathKey');
    local nameKey=$(echo ${paramJson} | jq -r '.nameKey');

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
        print.error "Erro: 'action' passado:($action) não coincide com [create, recreate]!";
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
        case ${action} in
            create) __create; ;;
            recreate) __recreate; ;;
            *) __actionError;
        esac
    }

    __initialize;
}

ScriptKeySSH "$@";

exit 0;