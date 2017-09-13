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
        print.out '%b' "\033[1;33m";
        print.out '%b' "Comando executado! Presione [ENTER] para continuar..."; read;
        print.out '%b' "\033[0m";
    }

    __runAllScripts() {
        bash start-divine-creation.sh "--run";
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
        file_path_menu="./files/doc-for-ui-commands.txt";
    }

    __exit() {
        print.out '%b\n\n' "\033[1;33mSaindo do modo Eden...\033[0m"; sleep 1s;
        exit 0;
    }

    __initialize() {
        # Isso irá limpar a tela para que possamos exibir o menu.
        clear;
        while [ true ]; do 
            cat ./files/header.txt;
            cat $file_path_menu;
            file_path_menu="./files/commands.txt";
            # Se houver algum erro, exiba-o.
            if [ "$error_command" != "" ]; then
                print.error "Erro: $error_command";
                # Limpe a mensagem de erro.
                error_command="";
            fi
            # Leia a entrada do usuário
            print.out '%b' "O que tu queres fazer? \033[1;32m$ "; read -a input_commands;
            print.out '%b' "\033[0m";
            case ${input_commands[0]} in
                --run) __runAllScripts; ;;
                --edit-settings) __editSettings "${input_commands[@]}"; ;;
                --edit-script) __editScript "${input_commands[@]}"; ;;
                --view-log) __viewLog "${input_commands[@]}"; ;;
                --view-doc) __viewDoc; ;;
                --exit) __exit; ;;
                *) error_command="Seu burro! Digite a porra do comando certo!";
            esac
            # Isso irá limpar a tela para que possamos exibir novamente o menu.
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