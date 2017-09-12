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
    #declare -a parameters=("$@");

    local pathDefault=$(cat settings.json | jq -r '.pathDefault');

    __execute() {
        local script=$1;
        local action=$2;
        local param=$3;
        local pathScript="$pathDefault/scripts/$script";

        print.out '%b\n' "\033[0;101m--> INICIANDO A EXECUÇÃO DO SCRIPT...  \033[0m";
        print.out '%b\n'   "--> script: '$pathScript'";
        print.out '%b\n'   "--> action: '$action'";
        print.out '%b\n\n' "--> param:  '$param'";
        
        # chamar o (shell script) e gerar log dele.
        bash "$pathScript" "$action" "$param" | tee -a ./$pathDefault/logs/$script.log 
    }

    __runScript() {
        local script=$1;
        local action=$2;
        local param=$3;

        echo "Not UI ----> " "$@";
        echo $script;
        echo $action;
        echo $param;

        __execute "$script" "$action" "$param";
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
        local action=$1;
        case $action in
            --run) __runScript "$2" "$3" "$4"; ;;
            --run-all) __runAllScripts; ;;
            --edit-set) __editSettings "$2" "$3"; ;;
            --edit-script) __editScript "$2" "$3"; ;;
            --view-log) __viewLog "$2" "$3"; ;;
            *) 
            print.error "Erro: Tipo do (COMANDO) não encontrado!";
            cat ./files/doc-commands.txt;
        esac
    }

    __initialize "$@";
} 

# Notificar usuario caso não exista o "jq" instalado na maquina, para instalar o "jq".
if [ `isInstalled "jq"` == 1 ]; then
    # chamar a função e gerar log dela
    StartDivineCreation "$@" | tee -a ./${0##*/}.log;
else
    print.warning "Aviso: É necessario ter instalado a extenção 'jq' na maquina!";
    print.out '%s' "Deseja que o Garden of Eden instale? [yes/no] $ "; read input_install_jq;
    if [ "$input_install_jq" == "yes" ]; then
        installExtensionJQ;
    fi
fi

exit 0




























# chamar o shell-script e gerar log dela
        #( exec $pathScript $action $param | tee -a ./$pathDefault/logs/$script.log );
        bash "$pathScript" "$action" "$param" | tee -a ./$pathDefault/logs/$script.log 


 __runAllScripts() {
        local counter=$(cat settings.json | jq '.settings | length'); 
        for (( i=1; i<=$counter; i++ )); do
            local index=$(($i-1));
            local execute=$(cat settings.json | jq ".settings[$index].execute");
            if [ "${execute}" == "true" ]; then
                local script=$(cat settings.json | jq -r ".settings[$index].script"); 
                local action=$(cat settings.json | jq -r ".settings[$index].action"); 
                local param=$(cat settings.json | jq ".settings[$index].param"); 

                local base64FromHell=$(printf '%s' "$param" | base64); 
                local decodeFromHell=$(printf '%s' "$base64FromHell" | base64 -d); 

                echo "----------base64"  
                echo "$base64FromHell"    
                echo "$decodeFromHell"

                __execute $script $action "$base64FromHell";
            fi
        done
    }















# @descr: http://urbanautomaton.com/blog/2014/09/09/redirecting-bash-script-output-to-syslog/ 
readonly SCRIPT_NAME=$(basename $0);
function log {
    echo "$@";
    logger -p user.notice -t $SCRIPT_NAME "$@";
}
function err {
    echo "$@" >&2;
    logger -p user.error -t $SCRIPT_NAME "$@";
}



declare -A colors
#curl www.bunlongheng.com/code/colors.png

# Reset
colors[Color_Off]='\033[0m'       # Text Reset

# Regular Colors
colors[Black]='\033[0;30m'        # Black
colors[Red]='\033[0;31m'          # Red
colors[Green]='\033[0;32m'        # Green
colors[Yellow]='\033[0;33m'       # Yellow
colors[Blue]='\033[0;34m'         # Blue
colors[Purple]='\033[0;35m'       # Purple
colors[Cyan]='\033[0;36m'         # Cyan
colors[White]='\033[0;37m'        # White

# Bold
colors[BBlack]='\033[1;30m'       # Black
colors[BRed]='\033[1;31m'         # Red
colors[BGreen]='\033[1;32m'       # Green
colors[BYellow]='\033[1;33m'      # Yellow
colors[BBlue]='\033[1;34m'        # Blue
colors[BPurple]='\033[1;35m'      # Purple
colors[BCyan]='\033[1;36m'        # Cyan
colors[BWhite]='\033[1;37m'       # White

# Underline
colors[UBlack]='\033[4;30m'       # Black
colors[URed]='\033[4;31m'         # Red
colors[UGreen]='\033[4;32m'       # Green
colors[UYellow]='\033[4;33m'      # Yellow
colors[UBlue]='\033[4;34m'        # Blue
colors[UPurple]='\033[4;35m'      # Purple
colors[UCyan]='\033[4;36m'        # Cyan
colors[UWhite]='\033[4;37m'       # White

# Background
colors[On_Black]='\033[40m'       # Black
colors[On_Red]='\033[41m'         # Red
colors[On_Green]='\033[42m'       # Green
colors[On_Yellow]='\033[43m'      # Yellow
colors[On_Blue]='\033[44m'        # Blue
colors[On_Purple]='\033[45m'      # Purple
colors[On_Cyan]='\033[46m'        # Cyan
colors[On_White]='\033[47m'       # White

# High Intensity
colors[IBlack]='\033[0;90m'       # Black
colors[IRed]='\033[0;91m'         # Red
colors[IGreen]='\033[0;92m'       # Green
colors[IYellow]='\033[0;93m'      # Yellow
colors[IBlue]='\033[0;94m'        # Blue
colors[IPurple]='\033[0;95m'      # Purple
colors[ICyan]='\033[0;96m'        # Cyan
colors[IWhite]='\033[0;97m'       # White

# Bold High Intensity
colors[BIBlack]='\033[1;90m'      # Black
colors[BIRed]='\033[1;91m'        # Red
colors[BIGreen]='\033[1;92m'      # Green
colors[BIYellow]='\033[1;93m'     # Yellow
colors[BIBlue]='\033[1;94m'       # Blue
colors[BIPurple]='\033[1;95m'     # Purple
colors[BICyan]='\033[1;96m'       # Cyan
colors[BIWhite]='\033[1;97m'      # White

# High Intensity backgrounds
colors[On_IBlack]='\033[0;100m'   # Black
colors[On_IRed]='\033[0;101m'     # Red
colors[On_IGreen]='\033[0;102m'   # Green
colors[On_IYellow]='\033[0;103m'  # Yellow
colors[On_IBlue]='\033[0;104m'    # Blue
colors[On_IPurple]='\033[0;105m'  # Purple
colors[On_ICyan]='\033[0;106m'    # Cyan
colors[On_IWhite]='\033[0;107m'   # White


color=${colors[$input_color]}
white=${colors[White]}
# echo $white



for i in "${!colors[@]}"
do
  echo -e "$i = ${colors[$i]}I love you$white"
done