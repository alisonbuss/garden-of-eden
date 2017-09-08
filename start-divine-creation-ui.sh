#!/bin/bash

###################  DOC  ###################
# @descr: Script de inicialização grafico do (Garden of Eden) para 
#         provisionamento do ambiente básico de desenvolvimento. 
# @example: 
#    $ sudo chmod a+x start-divine-creation-ui.sh
#    $ sudo bash start-divine-creation-ui.sh
#############################################

source "./shell-script-tools/linux/utility.sh";
source "./shell-script-tools/ubuntu/extension-jq.sh";

function StartDivineCreationUI {
    
    local error_command="";
    local file_path_menu="./files/commands.txt";

    __stopAfterExecution() {
        print.out '%s' "Comando executado! Presione [ENTER] para continuar..."; read;
    }

    __runScript() {
        bash start-divine-creation.sh "$@";
        __stopAfterExecution;
    }

    __runAllScripts() {
        bash start-divine-creation.sh "--run-all";
        __stopAfterExecution;
    }

    __listSettings() {
        bash start-divine-creation.sh "--list-set";
        __stopAfterExecution;
    }

    __editSettings() {
        bash start-divine-creation.sh "$@";
        __stopAfterExecution;
    }

    __editScript() {
        bash start-divine-creation.sh "$@";
        __stopAfterExecution;
    }

    __viewLog() {
        bash start-divine-creation.sh "$@";
        __stopAfterExecution;
    }

    __viewDoc() {
        print.info "__viewDoc";
        file_path_menu="./files/doc-commands.txt";
    }

    __exit() {
        print.info "__exit";
        exit 0;
    }

    __initialize() {
        clear;
        while [ true ]; do 
            #http://www.kammerl.de/ascii/AsciiSignature.php
            #http://patorjk.com/software/taag/#p=display&f=Graffiti&t=Type%20Something%20
            cat ./files/header.txt;
            cat $file_path_menu;
            file_path_menu="./files/commands.txt";
            # If error exists, display it
            if [ "$error_command" != "" ]; then
                print.error "Error: $error_command";
                # Clear the error message
                error_command="";
            fi
            # Read the user input
            print.out '%s' "O que tu queres fazer? $ "; read -a input_commands;
            case ${input_commands[0]} in
                --run) __runScript "${input_commands[@]}"; ;;
                --run-all) __runAllScripts; ;;
                --list-set) __listSettings; ;;
                --edit-set) __editSettings "${input_commands[@]}"; ;;
                --edit-script) __editScript "${input_commands[@]}"; ;;
                --view-log) __viewLog "${input_commands[@]}"; ;;
                --view-doc) __viewDoc; ;;
                --exit) __exit; ;;
                *) error_command="Seu burro! Digite a porra do comando certo!";
            esac
            # This will clear the screen so we can redisplay the menu.
            clear;
        done
    }

    __initialize;
} 

# Notificar usuario caso não exista o "jq" instalado na maquina, para instalar o "jq".
if [ `isInstalled "jq"` == 1 ]; then
    StartDivineCreationUI;
else
    print.warning "Aviso: É necessario ter instalado a extenção 'jq' na maquina!";
    print.out '%s' "Deseja que o Garden of Eden instale? [yes/no] $ "; read input_install_jq;
    if [ "$input_install_jq" == "yes" ]; then
        installExtensionJQ;
    fi
fi

exit 0;