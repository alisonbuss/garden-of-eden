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

function StartDivineCreationUI {

    local error_command="";
    local file_path_menu="./files/commands.txt";

    __runScript() {
        print.info "__runScript";
        sleep 2s;
    }

    __runAllScripts() {
        print.info "__runAllScripts";
        sleep 2s;
    }

    __listSettings() {
        print.info "__listSettings";
        sleep 2s;
    }

    __editSettings() {
        print.info "__editSettings";
        sleep 2s;
    }

    __editScript() {
        print.info "__editScript";
        sleep 2s;
    }

    __viewLog() {
        print.info "__viewLog";
        sleep 2s;
    }

    __viewDoc() {
        print.info "__viewDoc";
        file_path_menu="./files/doc-commands.txt";
    }

    __exit() {
        print.info "__exit";
        exit;
    }

    __initialize() {
        # This will clear the screen before displaying the menu.
        clear;

        while : 
        do
            #http://www.kammerl.de/ascii/AsciiSignature.php
            #http://patorjk.com/software/taag/#p=display&f=Graffiti&t=Type%20Something%20
            cat ./files/header.txt;
            cat $file_path_menu;
            file_path_menu="./files/commands.txt";

            # If error exists, display it
            if [ "$error_command" != "" ]; then
                print.warning "Aviso: $error_command";
                # Clear the error message
                error_command="";
            fi

            # Read the user input
            print.out '%s' "O que tu queres fazer? $ "; read input_command;

            case $input_command in
                --run) __runScript; ;;
                --run-all) __runAllScripts; ;;
                --list-set) __listSettings; ;;
                --edit-set) __editSettings; ;;
                --edit-script) __editScript; ;;
                --view-log) __viewLog; ;;
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

StartDivineCreationUI;

exit 0