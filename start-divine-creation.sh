#!/bin/bash

###################  DOC  ###################
# @descr: Script de inicialização do (Garden of Eden) para 
#         provisionamento do ambiente básico de desenvolvimento. 
# @example: 
#    $ sudo chmod a+x start-divine-creation.sh
#    $ sudo bash start-divine-creation.sh --view-doc
#  OR
#    $ sudo bash start-divine-creation.sh --run
#  OR
#    $ sudo bash start-divine-creation.sh --edit-settings gedit
#  OR
#    $ sudo bash start-divine-creation.sh --edit-script script-git.sh gedit
#  OR
#    $ sudo bash start-divine-creation.sh --view-log script-git.sh gedit
#############################################

SST_URL="https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master";
source <(wget -qO- "$SST_URL/linux/utility.sh");
source <(wget -qO- "$SST_URL/ubuntu/extension-jq.sh");

function StartDivineCreation {
          
    local DISTRIBUTION=$(cat settings.json | jq -r '.distribution');

    __stopAfterExecution() {
        print.out '%b' "\033[1;33m";
        print.out '%b\n' "Script '$1' executado!";
        print.out '%b' "\033[0m";
        print.out '%b' "Presione [ENTER] para continuar..."; read;
    }

    __execute() {
        local script=$1;
        local action=$2;
        local param=$3;
        local pathScript="$DISTRIBUTION/scripts/$script";

        print.out '%b\n' "\033[0;101m--> INICIANDO A EXECUÇÃO DO SCRIPT!  \033[0m";
        print.out '%b\n' "--> script: '$pathScript'";
        print.out '%b\n' "--> action: '$action'";
        print.out '%b\n' "--> param:  '$param'";
        
        # chamar o (shell script) e gerar log dele.
        bash "$pathScript" "$action" "$param" | tee -a ./$DISTRIBUTION/logs/$script.log;
        chmod -R 777 ./$DISTRIBUTION/logs/$script.log;

        __stopAfterExecution $pathScript;
    }

    __runAllScripts() {
        local counter=$(cat settings.json | jq '.settings | length'); 
        for (( i=1; i<=$counter; i++ )); do
            local index=$(($i-1));
            local execute=$(cat settings.json | jq ".settings[$index].execute");
            if [ "${execute}" == "true" ]; then
                local script=$(cat settings.json | jq -r ".settings[$index].script"); 
                local action=$(cat settings.json | jq -r ".settings[$index].action"); 
                local param=$(cat settings.json | jq -c ".settings[$index].param"); 
                __execute "$script" "$action" "$param";
            fi
        done
    }

    __editSettings() {
        local editor="$1";
        if [ "${editor}" == "" ]; then
            ( exec gedit ./settings.json );
        else
           ( exec $editor ./settings.json );
        fi
    }

    __editScript() {
        local script="$DISTRIBUTION/scripts/$1";
        local editor="$2";
        if [ -f "$script" ]; then
            if [ "${editor}" == "" ]; then
                ( exec gedit $script );
            else
                ( exec $editor $script );
            fi   
        else
            print.warning "Aviso: Shell Script '$script', não encontrado."
        fi  
    }

    __viewLog() {
        local scriptLog="$DISTRIBUTION/logs/$1.log";
        local editor="$2";
        if [ -f "$scriptLog" ]; then
            if [ "${editor}" == "" ]; then
                ( exec gedit $scriptLog );
            else
                ( exec $editor $scriptLog );
            fi
        else
            print.warning "Aviso: Arquivo de Log '$scriptLog', não encontrado."
        fi
    }

    __viewDoc() {
        clear;
        cat ./files/header.txt;
        cat ./files/doc-commands.txt;
    }

    __initialize() {
        local action="$1";
        case $action in
            --run) __runAllScripts; ;;
            --edit-settings) __editSettings "$2"; ;;
            --edit-script) __editScript "$2" "$3"; ;;
            --view-log) __viewLog "$2" "$3"; ;;
            --view-doc | help) __viewDoc; ;;
            *) 
            print.error "Erro: Tipo do comando '$action' não encontrado!";
            cat ./files/doc-commands.txt;
        esac
    }

    __initialize "$@";
} 

# Notificar usuario caso não exista o "jq" instalado na maquina, para instalar o "jq".
if [ `isInstalled "jq"` == 1 ]; then
    # chamar a função e gerar log dela
    StartDivineCreation "$@" | tee -a ./${0##*/}.log;
    chmod -R 777 ./${0##*/}.log;
else
    print.warning "Aviso: É necessario ter instalado a extensão 'jq' na maquina!";
    print.out '%s' "Deseja que o Garden of Eden instale? [yes/no] $ "; read input_install_jq;
    if [ "$input_install_jq" == "yes" ]; then
        installExtensionJQ;
        # Após a instalação da extensão 'jq' execute o Garden of Eden.
        StartDivineCreation "$@" | tee -a ./${0##*/}.log;
        chmod -R 777 ./${0##*/}.log;
    fi
fi

exit 0