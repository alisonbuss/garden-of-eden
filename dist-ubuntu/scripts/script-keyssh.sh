#!/bin/bash
 
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script para Gerar e Regerar chave SSH do usuário logado da máquina. 
# @fonts: https://www.youtube.com/watch?v=iVUnXw64Ez8&list=PLV7VqBqvsd_1h7zmEpE-xwgOPqp2IBGCV&index=8
# @example:
#       bash script-keyssh.sh --action='create' --param='{"comment":"...","passwordKey":"...","pathKey":"...","nameKey":"..."}'
#   OR
#       bash script-keyssh.sh --action='recreate' --param='{"comment":"...","passwordKey":"...","pathKey":"...","nameKey":"..."}'    
#-------------------------------------------------------------#

source <(wget --no-cache -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/import.sh"); 

import.ShellScriptTools "/linux/utility.sh";

# @descr: Função principal do script-keyssh.sh
# @param: 
#    action | text: (create, recreate)
#    param | json: '{"comment":"...","passwordKey":"...","pathKey":"...","nameKey":"..."}'
function ScriptKeySSH {

    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");

    # @descr: Variavel de parametros JSON.
    local PARAM_JSON=$(util.getParameterValue "(--param=|-p=)" "$@");

    local comment=$(echo ${PARAM_JSON} | jq -r '.comment');
    local passwordKey=$(echo ${PARAM_JSON} | jq -r '.passwordKey');
    local pathKey=$(echo ${PARAM_JSON} | jq -r '.pathKey');
    local nameKey=$(echo ${PARAM_JSON} | jq -r '.nameKey');

    # @descr: Função para Gerar chave SSH.
    __create() {
        util.print.info "Iniciando criação da chave SSH na maquina..."; 

        # verifica se tem a pasta, caso não tenha é criada uma pasta.
        if [ ! -d "$pathKey" ] ; then
            mkdir -p "${pathKey}";
            chmod -R 777 "${pathKey}";

            # gera a chave SSH do usuario da maquina.
            ssh-keygen -t rsa -b 4096 -C "$comment" -P "$passwordKey" -f "${pathKey}/${nameKey}"
        else
            util.print.warning "Aviso: Ha uma chave SSH já criada nesse diretorio! (${pathKey})";
        fi 
    } 

    # @descr: Função para Regerar chave SSH.
    __recreate() {
        util.print.info "Iniciando a recriação da chave SSH na maquina..."; 
        
        # verifica se tem a pasta, caso não tenha é criada uma pasta.
        if [ -d "$pathKey" ] ; then
            rm -rf "$pathKey/*";

            # gera a chave SSH do usuario da maquina.
            ssh-keygen -t rsa -b 4096 -C "$comment" -P "$passwordKey" -f "${pathKey}/${nameKey}"
        else
            mkdir -p "${pathKey}";
            chmod -R 777 "${pathKey}";

            # gera a chave SSH do usuario da maquina.
            ssh-keygen -t rsa -b 4096 -C "$comment" -P "$passwordKey" -f "${pathKey}/${nameKey}"
        fi  
    } 

    # @descr: Função é chamada qndo a um erro de tipo de ação.
    # @param: 
    #    action | text: "..." | Action não encontrado.
    __actionError() {
        local actionErr=$(util.getParameterValue "(--action=|-a=)" "$@");
        util.print.error "Erro: 'action' passado:(${actionErr}) não coincide com [create, recreate]!";
        return 1;
    } 

    # @descr: Função principal "um construtor por exemplo".
    __initialize() {
        case ${ACTION} in
            create) { 
                __create; 
            };;
            recreate) { 
                __recreate;
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
util.try; ( ScriptKeySSH "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;