#!/bin/bash

###################  DOC  ###################
# @descr: Script de instalação
# @example: 
#    $ sudo chmod a+x install-environment.sh
#    $ sudo bash install-environment.sh
#  OR
#    $ sudo bash install-environment.sh "install-golang.sh" '{ "version": "1.7.1", "op":"--remove" }'
#  OR
#    $ sudo bash install-environment.sh "list"
#############################################

source "./shell-script-tools/linux/utility.sh";
source "./shell-script-tools/ubuntu/extension-jq.sh";

function InstallEnvironment {
    local paramScript="$1";
    local paramOfScript="$2";
    local pathDefault=$(cat settings.json | jq -r '.pathDefault');

    __execScript() {
        local script=$1;
        local param=$2;
        # chamar o shell-script e gerar log dela
        ( exec "$pathDefault/scripts/$script" "$param" | tee -a ./$pathDefault/logs/$script.log );
        echo "";
    }

    __readFileSettingsJSON() {
        for row in $(cat settings.json | jq -c '.settings[]'); do    
            local script=$(echo ${row} | jq -r '.script');
            local execute=$(echo ${row} | jq '.execute');
            local param=$(echo ${row} | jq -c '.param');

            if [ "${execute}" == "true" ]; then
                __execScript $script $param;
            fi
        done 
    }

    __printFileSettingsJSON() {
        echo "..."; sleep 0.3s;
        echo "......"; sleep 0.3s;
        echo "........."; sleep 0.3s;
        echo -e  "\e[30;48;5;30m --> Imprimindo lista de programas e scripts do 'AMBIENTE' \e[0m";
        echo "File: settings.json"; sleep 0.2s;
        echo "Directory: '$PWD'"; sleep 0.2s;
        echo "{"; sleep 0.2s;
        for row in $(cat settings.json | jq -c '.settings[]'); do               
            echo "   ${row}"; sleep 0.4s;
        done 
        echo "}"; sleep 0.2s;
        echo "";
    }

    __execAllScripts() {
        echo -e  "\e[30;48;5;30m --> Iniciando a instalações do ambiente... \e[0m";
        echo "";

        __readFileSettingsJSON;

        echo -e  "\e[30;48;5;30m --> Instalação completada com sucesso!!!.. \e[0m";
        echo "";
    }

    __initialize() {
        clear;

        # Caso não exista o "jq" instalado na maquina, instale o "jq".
        if [ `isInstalled "jq"` == 1 ]; then
            msgInfo "A extenção 'jq' já está instalanda na maquina...";
        else
            msgInfo "Instalando a extenção 'jq' na maquina...";
            installExtensionJQ;
        fi

        # Caso o parametro "paramScript" for vazio executa todos scripts.
        if [ "$paramScript" = "" ]; then 
            __execAllScripts;
        elif [ "$paramScript" = "list" ]; then 
            __printFileSettingsJSON;
        else 
            __execScript $paramScript $paramOfScript;
        fi
    }

    __initialize;
} 

# chamar a função e gerar log dela
InstallEnvironment $1 $2 | tee -a ./${0##*/}.log;

exit 0