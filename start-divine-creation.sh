#!/bin/bash

###################  DOC  ###################
# @descr: Script de inicialização do (Garden of Eden) para 
#         provisionamento do ambiente básico de desenvolvimento. 
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

function StartDivineCreation {
    # Converter os parametros em um array.
    declare -a parameters=("$@");
    local pathDefault=$(cat settings.json | jq -r '.pathDefault');

    __execute() {
        local script="$1";
        local action="$2";
        local param="$3";
        local pathScript="$pathDefault/scripts/$script";
        # chamar o shell-script e gerar log dela
        ( exec $pathScript $action $param | tee -a ./$pathDefault/logs/$script.log );
    }

    __runScript() {
        local script="${parameters[1]}";
        local action="${parameters[2]}";
        local param="${parameters[3]}";

       __execute $script $action $param;
    }

    __runAllScripts() {
        for row in $(cat settings.json | jq -c '.settings[]'); do    
            local script=$(echo ${row} | jq -r '.script');  
            local action=$(echo ${row} | jq '.action');
            local param=$(echo ${row} | jq -c '.param');

            local execute=$(echo ${row} | jq '.execute');
            if [ "${execute}" == "true" ]; then
                __execute $script $action $param;
            fi
        done 
    }

    __listSettings() {
        cat ./settings.json;
    }

    __editSettings() {
        local editor="${parameters[1]}";
        if [ "${editor}" == "" ]; then
            ( exec gedit ./settings.json );
        fi
        ( exec $editor ./settings.json );
    }

    __editScript() {
        local script="$pathDefault/scripts/${parameters[1]}";
        local editor="${parameters[2]}gedit";
        if [ "${editor}" == "" ]; then
            ( exec gedit $script );
        fi
        ( exec $editor $script );
    }

    __viewLog() {
        local script="$pathDefault/logs/${parameters[1]}.log";
        local editor="${parameters[2]}";
        if [ "${editor}" == "" ]; then
            ( exec gedit $script );
        fi
        ( exec $editor $script );
    }

    __initialize() {
        local action="${parameters[0]}";
        case $action in
            --run) __runScript; ;;
            --run-all) __runAllScripts; ;;
            --list-set) __listSettings; ;;
            --edit-set) __editSettings; ;;
            --edit-script) __editScript; ;;
            --view-log) __viewLog; ;;
            *) print.error "Error: Tipo da (AÇÃO) não encontrada! [--run|--run-all|--list-set|--edit-set|--edit-script|--view-log]!";
        esac
    }

    __initialize;
} 

# Notificar usuario caso não exista o "jq" instalado na maquina, para instalar o "jq".
if [ `isInstalled "jq"` == 1 ]; then
    # chamar a função e gerar log dela
    StartDivineCreation $@ | tee -a ./${0##*/}.log;
else
    print.warning "Aviso: É necessario ter instalado a extenção 'jq' na maquina!";
    print.out '%s' "Deseja que o Garden of Eden instale? [yes/no] $ "; read input_install_jq;
    if [ "$input_install_jq" == "yes" ]; then
        installExtensionJQ;
    fi
fi

exit 0