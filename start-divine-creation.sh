#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de inicialização do (Garden of Eden) para 
#         provisionamento do ambiente básico de desenvolvimento. 
#-------------------------------------------------------------#

readonly DOCUMENTATION="
Documentação:

| Comandos                      | Descrição                                             |
| ----------------------------- | ----------------------------------------------------- |
| --run|-r                      | - Executa todos os scrits definidos no settings.json  |
| --list|-l                     | - Lista todos os scripts definidos no settings.json   |
| --setting-file|-s             | - Seta o caminho do arquivo de configuração do Garden |
|                               | Of Eden, caso o camnho não seja passado o valor       |
|                               | padrão será (./settings.json). Esse parametro deve    |
|                               | ser acompanhado junto com o comando (--run OU --list) |   
| --version|-version|-v|version | - Imprime a versão do Garden Of Eden                  |
| --help|-help|-h|help          | - Ajuda                                               |
-----------------------------------------------------------------------------------------

| Exemplos                                                                |
| ----------------------------------------------------------------------- |
|                                                                         |
| RUN-------------------------------------------------------------------- |
| $ bash start-divine-creation.sh --run                                   |
| ----------------------------------------------------------------------- |
| $ bash start-divine-creation.sh -r                                      |
| ----------------------------------------------------------------------- |
| $ bash start-divine-creation.sh --run --setting-file='./settings.json'  |
| ----------------------------------------------------------------------- |
| $ bash start-divine-creation.sh -r -s='./settings.json'                 |
|                                                                         |
| LIST------------------------------------------------------------------- |
| $ bash start-divine-creation.sh --list                                  |
| ----------------------------------------------------------------------- |
| $ bash start-divine-creation.sh -l                                      |
| ----------------------------------------------------------------------- |
| $ bash start-divine-creation.sh --list --setting-file='./settings.json' |
| ----------------------------------------------------------------------- |
| $ bash start-divine-creation.sh -l -s='./settings.json'                 |
|                                                                         |
| VERSION---------------------------------------------------------------- |
| $ bash start-divine-creation.sh --version                               |
|                                                                         |
| HELP------------------------------------------------------------------- |
| $ bash start-divine-creation.sh --help                                  |
";

source ./shell-script/tools/utility.sh;

export readonly LOCAL_DIR="$PWD";
export readonly RUN_JQ="./binaries/jq-linux64-v1.6" && chmod +x $RUN_JQ;

function StartDivineCreation {

    local settingFile=$(util.getParameterValue "(--setting-file=|-s=)" "$@");
    if [ ! -n "${settingFile}" ]; then 
        settingFile="./settings-environment.json";
    fi

    # @descr: 
    __executeBash() {
        local script="$1"; 
        local action="$2"; 
        local param="$3";
        local isValidPath=$(util.validateFilePath "${script}");

        if [ "${isValidPath}" == "true" ]; then
            sleep 1s; 
            util.executeBash "${script}" "--action=${action}" "--param=${param}";
            return $?;
        else 
            util.print.out '%b\n' "${RED}--> Error: Arquivo ou diretório não encontrado! ${B_RED}'${script}' ${COLOR_OFF}";
            return 1;
        fi
    }

    # @descr: 
    __runScript() {
        local path="$1"; 
        local script="$2"; 
        local action="$3"; 
        local param="$4";

        local startTime=$(date +'%H:%M:%S');
        local startDate=$(date -u -d "${startTime}" +"%s");

        util.print.out '%b\n\n' "";
        util.print.out '%b\n' "${ON_BLUE}${B_WHITE}--> INICIANDO A EXECUÇÃO DO SCRIPT --> ${startTime} ${COLOR_OFF}";
        util.print.out '%b\n' "${WHITE}--> Script........: '${script}'${COLOR_OFF}";
        util.print.out '%b\n' "${WHITE}--> Action........: '${action}'${COLOR_OFF}";
        util.print.out '%b\n' "${WHITE}--> Param.........: '${param}'${COLOR_OFF}";
        util.print.out '%b\n' "${WHITE}--> Default Path..: '${path}'${COLOR_OFF}";

        util.print.out '\n%b\n...\n' "${WHITE}Running the script, ${B_YELLOW}Output:${COLOR_OFF}";
        __executeBash "${path}/${script}" "${action}" "${param}";

        local executionWasOk=$?;
        if [[ $executionWasOk -eq 0 ]]; then
            util.print.out "...\n%b\n" "${B_YELLOW}Script Executado com sucesso!${COLOR_OFF}";
        else
            util.print.out '%b\n' "${B_RED}Falha ao executar o script ${CYAN}'${script}'${B_RED}!${COLOR_OFF}";
            util.print.out '%b\n' "${B_RED}Exception Code: ${RED}${executionWasOk}${COLOR_OFF}";
        fi

        local endTime=$(date +'%H:%M:%S');
        local endDate=$(date -u -d "${endTime}" +"%s")
        local finalTime=$(date -u -d "0 ${endDate} sec - ${startDate} sec" +"%H:%M:%S");
        util.print.out '%b\n' "${ON_BLUE}${B_WHITE}--> FINALIZADA A EXECUÇÃO DO SCRIPT! ${COLOR_OFF}";
        util.print.out '%b\n' "${ON_BLUE}${B_WHITE}--> TEMPO DA EXECUÇÃO --> ${finalTime}   ${COLOR_OFF}";

        util.print.out '%b' "${B_WHITE}Presione [ENTER] para continuar... ${COLOR_OFF}"; read;

        return 0;
    }

    # @descr: 
    __runAllActiveScripts() {
        local settingFile="$1";

        local startTime=$(date +'%H:%M:%S');
        local startDate=$(date -u -d "${startTime}" +"%s")

        util.print.out '%s\n' "Atualizar informações dos pacotes para instalação...";
        sudo apt-get update;

        local modulesSize=$(cat "${settingFile}" | $RUN_JQ ".settings | length"); 
        for (( x=1; x<=$modulesSize; x++ )); do
            local moduleIndex=$(($x-1));
            local scriptsPath=$(cat "${settingFile}" | $RUN_JQ -r ".settings[${moduleIndex}].scriptsPath");
            local    logsPath=$(cat "${settingFile}" | $RUN_JQ -r ".settings[${moduleIndex}].logsPath");
            local      active=$(cat "${settingFile}" | $RUN_JQ    ".settings[${moduleIndex}].active");
            local  scriptSize=$(cat "${settingFile}" | $RUN_JQ    ".settings[${moduleIndex}].scripts | length"); 

            if [ "${active}" == "true" ]; then
                mkdir -p "${logsPath}";
                chmod -R 777 "${logsPath}";
                for (( y=1; y<=$scriptSize; y++ )); do
                    local scriptIndex=$(($y-1));
                    local execute=$(cat "${settingFile}" | $RUN_JQ ".settings[${moduleIndex}].scripts[${scriptIndex}].execute");
                    if [ "${execute}" == "true" ]; then
                        local script=$(cat "${settingFile}" | $RUN_JQ -r ".settings[${moduleIndex}].scripts[${scriptIndex}].script"); 
                        local action=$(cat "${settingFile}" | $RUN_JQ -r ".settings[${moduleIndex}].scripts[${scriptIndex}].action"); 
                        local  param=$(cat "${settingFile}" | $RUN_JQ -c ".settings[${moduleIndex}].scripts[${scriptIndex}].param");

                        __runScript "${scriptsPath}" "${script}" "${action}" "${param}" | tee -a "${logsPath}/${script}.log";

                        chmod -R 777 "${logsPath}/${script}.log";
                    fi
                done
            fi
        done

        local endTime=$(date +'%H:%M:%S');
        local endDate=$(date -u -d "${endTime}" +"%s")
        local finalTime=$(date -u -d "0 ${endDate} sec - ${startDate} sec" +"%H:%M:%S");
        util.print.warning "A execução dos scripts teve duração de: ${finalTime}";
    }

    # @descr: 
    __startNotifying() {
        util.print.out '%b' "${GREEN}";
        cat "./support-files/files/header.txt";
        util.print.out '%b' "${COLOR_OFF}";
        
        util.print.info " Reading File: '${settingFile}'";
        sleep 1s;

        util.print.out '%b\n' "${ON_BLUE}${B_WHITE}--> TIPO DO SISTEMA DA MAQUINA: ${COLOR_OFF}";
        lsb_release -a;
    }

    # @descr: 
    __showAllActiveScripts() {
        local modulesSize=$(cat "${settingFile}" | $RUN_JQ ".settings | length"); 

        __startNotifying;

        util.print.out '\n%b\n\n' "${ON_BLUE}${B_WHITE}--> SCRIPTS A SEREM EXECUTADOS... ${COLOR_OFF}";

        local countScripts=0;
        for (( x=1; x<=$modulesSize; x++ )); do
            local moduleIndex=$(($x-1));
            local scriptSize=$(cat "${settingFile}" | $RUN_JQ ".settings[${moduleIndex}].scripts | length"); 

            local      module=$(cat "${settingFile}" | $RUN_JQ -r ".settings[${moduleIndex}].module");
            local description=$(cat "${settingFile}" | $RUN_JQ -r ".settings[${moduleIndex}].description");
            local      active=$(cat "${settingFile}" | $RUN_JQ    ".settings[${moduleIndex}].active");
            local scriptsPath=$(cat "${settingFile}" | $RUN_JQ -r ".settings[${moduleIndex}].scriptsPath");
            local    logsPath=$(cat "${settingFile}" | $RUN_JQ -r ".settings[${moduleIndex}].logsPath");

            if [ "${active}" == "true" ]; then
                util.print.out '%b\n' "${B_CYAN}--> Group of Scripts";
                util.print.out '%b\n' "${CYAN}----> Module..........: ${YELLOW}'${module}'${COLOR_OFF}";
                util.print.out '%b\n' "${CYAN}----> Description.....: ${YELLOW}'${description}'${COLOR_OFF}";
                util.print.out '%b\n' "${CYAN}----> Active..........: ${B_YELLOW}'${active}'${COLOR_OFF}";
                util.print.out '%b\n' "${CYAN}----> Scripts Path....: ${YELLOW}'${scriptsPath}'${COLOR_OFF}";
                util.print.out '%b\n' "${CYAN}----> Logs Path.......: ${YELLOW}'${logsPath}'${COLOR_OFF}";
                util.print.out '%b\n' "${CYAN}----> Script Numbers..: ${YELLOW}'${scriptSize}'${COLOR_OFF}";
                for (( y=1; y<=$scriptSize; y++ )); do
                    local scriptIndex=$(($y-1));
                    local execute=$(cat "${settingFile}" | $RUN_JQ ".settings[${moduleIndex}].scripts[${scriptIndex}].execute");
                    if [ "${execute}" == "true" ]; then
                        countScripts=$(($countScripts+1));
                        local script=$(cat "${settingFile}" | $RUN_JQ -r ".settings[${moduleIndex}].scripts[${scriptIndex}].script"); 
                        local action=$(cat "${settingFile}" | $RUN_JQ -r ".settings[${moduleIndex}].scripts[${scriptIndex}].action"); 
                        local  param=$(cat "${settingFile}" | $RUN_JQ -c ".settings[${moduleIndex}].scripts[${scriptIndex}].param");
                    
                        util.print.out '%b\n' "${B_WHITE}------> N. Execution Order.: ${B_CYAN}'${countScripts}ª'${COLOR_OFF}";
                        util.print.out '%b\n'   "${WHITE}------> Script.............: ${WHITE}'${script}'${COLOR_OFF}";
                        util.print.out '%b\n'   "${WHITE}------> Action.............: ${WHITE}'${action}'${COLOR_OFF}";
                        util.print.out '%b\n'   "${WHITE}------> Param..............: ${WHITE}'${param}'${COLOR_OFF}";
                        util.print.out '%b\n'   "${WHITE}------> Execute............: ${B_GREEN}'${execute}'${COLOR_OFF}";
                        util.print.out '%b\n' "";
                    fi
                done
            fi
        done
    }

    # @descr: 
    __showAllScripts() {
        local modulesSize=$(cat "${settingFile}" | $RUN_JQ ".settings | length"); 

        __startNotifying;

        util.print.out '\n%b\n\n' "${ON_BLUE}${B_WHITE}--> LISTAR TODOS OS SCRIPTS EM ORDEM DE EXECUÇÃO... ${COLOR_OFF}";

        local countScripts=0;
        for (( x=1; x<=$modulesSize; x++ )); do
            local moduleIndex=$(($x-1));
            local scriptSize=$(cat "${settingFile}" | $RUN_JQ ".settings[${moduleIndex}].scripts | length"); 

            local      module=$(cat "${settingFile}" | $RUN_JQ -r ".settings[${moduleIndex}].module");
            local description=$(cat "${settingFile}" | $RUN_JQ -r ".settings[${moduleIndex}].description");
            local      active=$(cat "${settingFile}" | $RUN_JQ    ".settings[${moduleIndex}].active");
            local scriptsPath=$(cat "${settingFile}" | $RUN_JQ -r ".settings[${moduleIndex}].scriptsPath");
            local    logsPath=$(cat "${settingFile}" | $RUN_JQ -r ".settings[${moduleIndex}].logsPath");

            util.print.out '%b\n' "${B_CYAN}--> Group of Scripts";
            util.print.out '%b\n' "${CYAN}----> Module..........: ${YELLOW}'${module}'${COLOR_OFF}";
            util.print.out '%b\n' "${CYAN}----> Description.....: ${YELLOW}'${description}'${COLOR_OFF}";
            util.print.out '%b\n' "${CYAN}----> Active..........: ${B_YELLOW}'${active}'${COLOR_OFF}";
            util.print.out '%b\n' "${CYAN}----> Scripts Path....: ${YELLOW}'${scriptsPath}'${COLOR_OFF}";
            util.print.out '%b\n' "${CYAN}----> Logs Path.......: ${YELLOW}'${logsPath}'${COLOR_OFF}";
            util.print.out '%b\n' "${CYAN}----> Script Numbers..: ${YELLOW}'${scriptSize}'${COLOR_OFF}";

            for (( y=1; y<=$scriptSize; y++ )); do
                countScripts=$(($countScripts+1));
                local scriptIndex=$(($y-1));
                local  script=$(cat "${settingFile}" | $RUN_JQ -r ".settings[${moduleIndex}].scripts[${scriptIndex}].script"); 
                local  action=$(cat "${settingFile}" | $RUN_JQ -r ".settings[${moduleIndex}].scripts[${scriptIndex}].action"); 
                local   param=$(cat "${settingFile}" | $RUN_JQ -c ".settings[${moduleIndex}].scripts[${scriptIndex}].param");
                local execute=$(cat "${settingFile}" | $RUN_JQ    ".settings[${moduleIndex}].scripts[${scriptIndex}].execute");

                util.print.out '%b\n' "${B_WHITE}------> N. Execution Order.: '${countScripts}ª'${COLOR_OFF}";
                util.print.out '%b\n'   "${WHITE}------> Script.............: '${script}'${COLOR_OFF}";
                util.print.out '%b\n'   "${WHITE}------> Action.............: '${action}'${COLOR_OFF}";
                util.print.out '%b\n'   "${WHITE}------> Param..............: '${param}'${COLOR_OFF}";
                util.print.out '%b\n'   "${WHITE}------> Execute............: ${B_GREEN}'${execute}'${COLOR_OFF}";
                util.print.out '%b\n' "";
            done
        done
    }
    
    # @descr: 
    __prepareScriptsExecution() {
        if [ -n "${settingFile}" ]; then 
            local isValidPath=$(util.validateFilePath "${settingFile}");    
            if [ "${isValidPath}" == "true" ]; then
                __showAllActiveScripts;
                util.print.out '%b%s' "${B_WHITE}Deseja executar os scripts detalhados acima? [yes/no] $ ${COLOR_OFF}"; read input_run_scripts; 
                if [ "${input_run_scripts}" == "yes" ] || [ "${input_run_scripts}" == "y" ]; then
                    __runAllActiveScripts "${settingFile}";
                fi
            else 
                util.print.out '%b\n' "${RED}--> Error: Arquivo ou diretório não encontrado! ${B_RED}'${settingFile}'${COLOR_OFF}";
                return 1;
            fi
        else
            util.print.error "Erro: Parametro --setting-file='...' não existe!";
            return 1;
        fi
    }

    # @descr: 
    __help() {
        util.print.out '%b' "${GREEN}";
        cat "./support-files/files/header.txt";
        util.print.out '%b' "${COLOR_OFF}";
        util.print.out '%b\n' "${DOCUMENTATION}";
    }

    # @descr: 
    __version() {
        util.print.out '%s\n' "3.3.666-beta";
    }

    # @descr: 
    __initialize() {
        # set parameters
        local _params="$@";
        
        case $_params in
            *--run*|*-r*) { 
                __prepareScriptsExecution "$@"; 
            };;
            *--list*|*-l*) { 
                __showAllScripts "$@";
            };;
            *--help*|*-help*|*-h*|*help*) {
                __help; 
            };;
            *--version*|*-version*|*-v*|*version*) {
                __version "$@"; 
            };;
            *) {
               __help; 
            };;
        esac
    }
    
    __initialize "$@";   
} 

# SCRIPT INITIALIZE...
util.try; ( 
    
    mkdir -p "./logs" && chmod -R 777 "./logs";
    StartDivineCreation "$@" | tee -a "./logs/${0##*/}.log";

); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;
