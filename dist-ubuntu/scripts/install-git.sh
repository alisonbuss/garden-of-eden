#!/bin/bash

###################  DOC  ###################
# @descr: Instalação do Git na maquina.      
# @fonts: https://www.youtube.com/watch?v=BettUg-L8M4&list=PLV7VqBqvsd_1h7zmEpE-xwgOPqp2IBGCV
# @param: param | json
# @example: 
#    $ sudo chmod a+x install-git.sh
#    $ sudo ./install-git.sh
#############################################

function InstallGit {
    local param=$1;
    local nameUser="Alison Buss de Arruda";
    local emailUser="alisonbuss.dev@gmail.com";

    __install() {
        msgInfo "Iniciando a instalação do Git na maquina..."; 

        apt-get install git;
        git --version;
        git config --global user.name "$nameUser";
        git config --global user.email $emailUser;
        git config --list;
        read -p "Sua chave SSH já foi publicada no GitHub? (yes/no): " input_isPublishedKey;
        # Caso a chave SSH foi publicada no GitHub teste a conexão.
        if [ "$input_isPublishedKey" == "yes" ]; then
            msgInfo "Testando a conexão com o GitHub...";
            ssh -T git@github.com;
        fi
    }

    __initialize() {
        if [ `isInstalled "git"` == 1 ]; then
            msgInfo "Git já está instalanda na maquina...";
            git --version;
            git config --list;
        else
            __install;
        fi 
    }

    __initialize;
}

InstallGit $1;

exit 0;