#!/bin/bash

###################  DOC  ###################
# @descr: Gerar chave SSH do usuário logado da máquina.  
# @fonts: https://www.youtube.com/watch?v=iVUnXw64Ez8&list=PLV7VqBqvsd_1h7zmEpE-xwgOPqp2IBGCV&index=8
# @param: param | json
# @example: 
#    $ sudo chmod a+x generate-keyssh.sh
#    $ sudo ./generate-keyssh.sh
#############################################

function GenerateKeySSH {
    local param=$1;
    local comment="comment";
    local passwordKey="123456";
    local pathKey="$HOME/.ssh";
    local nameKey="id_rsa";

    __generate() {
        msgInfo "Iniciando geração da chave SSH na maquina..."; 

        # verifica se tem a pasta, caso não tenha é criada uma pasta.
        if [ ! -d "$pathKey" ] ; then
            mkdir ${pathKey/nameKey};
            chmod -R 777 ${pathKey/nameKey};
        fi
        # gera a chave SSH do usuario da maquina.
        ssh-keygen -t rsa -b 4096 -C "$comment" -P "$passwordKey" -f "$pathKey/$nameKey"
    } 

    __initialize() {
        __generate;
    }

    __initialize;
}

GenerateKeySSH $1;

exit 0;