#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de inicialização do (Garden of Eden) para 
#         provisionamento do ambiente básico de desenvolvimento. 
# @example: 
#    $ sudo chmod a+x start-divine-creation.sh
#    $ bash start-divine-creation.sh --help 
#  OR
#    $ bash start-divine-creation.sh --version
#
#  OR
#    $ sudo bash start-divine-creation.sh --list
#  OR
#    $ sudo bash start-divine-creation.sh --list --setting-file='./settings.json'
#  OR
#    $ sudo bash start-divine-creation.sh -l -s='./settings.json'
#
#  OR
#    $ sudo bash start-divine-creation.sh --run
#  OR
#    $ sudo bash start-divine-creation.sh --run --setting-file='./settings.json'
#  OR
#    $ sudo bash start-divine-creation.sh -r -s='./settings.json'
#-------------------------------------------------------------#

source <(wget --no-cache -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/import.sh"); 

import.ShellScriptTools "/linux/utility.sh";
import.ShellScriptTools "/ubuntu/extension-jq.sh";

function StartDivineCreation {
    local settingFile=$(util.getParameterValue "(--setting-file=|-s=)" "$@");
    if [ ! -n "${settingFile}" ]; then 
        settingFile="./settings.json";
    fi
    local pathLogGeneral=$(cat "${settingFile}" | jq -r ".pathLogGeneral");
    local pathLogScripts=$(cat "${settingFile}" | jq -r ".pathLogScripts");
    local distribution=$(cat "${settingFile}" | jq -r ".distribution");

    # @descr: 
    __executeBash() {
        local script="$1"; 
        local action="$2"; 
        local param="$3";
        local isValidPath=$(util.validateFilePath "${script}");

        if [ "${isValidPath}" == "true" ]; then
            util.executeBash "${script}" "--action=${action}" "--param=${param}";
            return $?;
        else 
            util.print.out '%b\n' "${RED}--> Error: Arquivo ou diretório não encontrado! ${B_RED}'${script}' ${COLOR_OFF}";
            return 1;
        fi
    }

    # @descr: 
    __executeBashCloud() {
        local script="$1"; 
        local action="$2"; 
        local param="$3";
        local isValidUrl=$(util.validateURL "${script}");

        if [ "${isValidUrl}" == "true" ]; then
            util.executeBashCloud "${script}" "--action=${action}" "--param=${param}";
            return $?;
        else 
            util.print.out '%b\n' "${RED}--> Error: Invalid URL! ${B_RED}'${script}' ${COLOR_OFF}";
            return 1;
        fi
    }

    # @descr: 
    __runScript() {
        local repositoryPath="$1"; 
        local script="$2"; 
        local action="$3"; 
        local param="$4";

        local startTime=$(date +'%H:%M:%S');
        local startDate=$(date -u -d "${startTime}" +"%s");

        util.print.out '%b\n\n' "";
        util.print.out '%b\n' "${ON_BLUE}--> INICIANDO A EXECUÇÃO DO SCRIPT --> ${startTime} ${COLOR_OFF}";
        util.print.out '%b\n' "${B_WHITE}--> Script........:${B_CYAN} '${script}'${COLOR_OFF}";
        util.print.out '%b\n' "${B_WHITE}--> Action........:${CYAN} '${action}'${COLOR_OFF}";
        util.print.out '%b\n' "${B_WHITE}--> Param.........:${CYAN} '${param}'${COLOR_OFF}";
        util.print.out '%b\n' "${B_WHITE}--> Default Path..:${CYAN} '${repositoryPath}'${COLOR_OFF}";
        #util.print.out '%b\n' "";

        if [[ $repositoryPath == "http"* ]]; then
            __executeBashCloud "${repositoryPath}${script}" "${action}" "${param}";
        else
            __executeBash "${repositoryPath}${script}" "${action}" "${param}";
        fi
        local executionWasOk=$?;
        if [[ $executionWasOk -eq 0 ]]; then
            util.print.out "%b\n" "${B_BLUE}Script ${CYAN}'${script}' ${B_BLUE}Executado com sucesso!${COLOR_OFF}";
        else
            util.print.out '%b\n' "${B_RED}Falha ao executar o script ${CYAN}'${script}'${B_RED}!${COLOR_OFF}";
            util.print.out '%b\n' "${B_RED}Exception Code: ${RED}${executionWasOk}${COLOR_OFF}";
        fi

        local endTime=$(date +'%H:%M:%S');
        local endDate=$(date -u -d "${endTime}" +"%s")
        local finalTime=$(date -u -d "0 ${endDate} sec - ${startDate} sec" +"%H:%M:%S");
        util.print.out '%b\n' "${ON_BLUE}--> FINALIZADA A EXECUÇÃO DO SCRIPT! ${COLOR_OFF}";
        util.print.out '%b\n' "${ON_BLUE}--> TEMPO DA EXECUÇÃO --> ${finalTime}   ${COLOR_OFF}";

        util.print.out '%b' "${B_WHITE}Presione [ENTER] para continuar... ${COLOR_OFF}"; read;

        return 0;
    }

    # @descr: 
    __runAllActiveScripts() {
        local settingFile="$1";

        local startTime=$(date +'%H:%M:%S');
        local startDate=$(date -u -d "${startTime}" +"%s")

        local repositoriesSize=$(cat "${settingFile}" | jq ".scriptsRepositories | length"); 
        for (( x=1; x<=$repositoriesSize; x++ )); do
            local repositoryIndex=$(($x-1));
            local scriptSize=$(cat "${settingFile}" | jq ".scriptsRepositories[${repositoryIndex}].scripts | length"); 

            local repository=$(cat "${settingFile}" | jq -r ".scriptsRepositories[${repositoryIndex}].repository");
            local repositoryPath=$(cat "${settingFile}" | jq -r ".scriptsRepositories[${repositoryIndex}].repositoryPath");
            local repositoryActive=$(cat "${settingFile}" | jq ".scriptsRepositories[${repositoryIndex}].repositoryActive");

            if [ "${repositoryActive}" == "true" ]; then
                mkdir -p "${pathLogScripts}${repository}";
                chmod -R 755 "${pathLogScripts}${repository}";
                for (( y=1; y<=$scriptSize; y++ )); do
                    local scriptIndex=$(($y-1));
                    local execute=$(cat "${settingFile}" | jq ".scriptsRepositories[${repositoryIndex}].scripts[${scriptIndex}].execute");
                    if [ "${execute}" == "true" ]; then
                        local script=$(cat "${settingFile}" | jq -r ".scriptsRepositories[${repositoryIndex}].scripts[${scriptIndex}].script"); 
                        local action=$(cat "${settingFile}" | jq -r ".scriptsRepositories[${repositoryIndex}].scripts[${scriptIndex}].action"); 
                        local param=$(cat "${settingFile}" | jq -c ".scriptsRepositories[${repositoryIndex}].scripts[${scriptIndex}].param");

                        __runScript "${repositoryPath}" "${script}" "${action}" "${param}" | tee -a "${pathLogScripts}${repository}/${script}.log";
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
        cat "./files/header.txt";
        util.print.out '%b' "${COLOR_OFF}";
        
        util.print.info "Reading File: '${settingFile}'";
        sleep 1s;

        util.print.out '%b\n' "${ON_YELLOW}${B_RED}--> TIPO DO SISTEMA DA MAQUINA: ${COLOR_OFF}";
        lsb_release -a;
        util.print.out '\n%b\n' "${ON_YELLOW}${B_RED}--> DISTRIBUIÇÃO DA MAQUINA:    ${COLOR_OFF}";
        lsb_release -i;
        util.print.out '\n%b\n' "${ON_YELLOW}${B_RED}--> DISTRIBUIÇÃO DO ARQUIVO (${settingFile}): ${COLOR_OFF}";
        util.print.out '%b\n\n' "Distributor ID:	${distribution}";
    }

    # @descr: 
    __showAllActiveScripts() {
        local settingFile="$1";
        local repositoriesSize=$(cat "${settingFile}" | jq ".scriptsRepositories | length"); 
        
        __startNotifying;

        util.print.out '%b\n\n' "${ON_BLUE}${B_WHITE}--> SCRIPTS A SEREM EXECUTADOS: ${COLOR_OFF}";
        
        local countScripts=0;
        for (( x=1; x<=$repositoriesSize; x++ )); do
            local repositoryIndex=$(($x-1));
            local scriptSize=$(cat "${settingFile}" | jq ".scriptsRepositories[${repositoryIndex}].scripts | length"); 

            local repository=$(cat "${settingFile}" | jq -r ".scriptsRepositories[${repositoryIndex}].repository");
            local repositoryInfo=$(cat "${settingFile}" | jq -r ".scriptsRepositories[${repositoryIndex}].repositoryInfo");
            local repositoryPath=$(cat "${settingFile}" | jq -r ".scriptsRepositories[${repositoryIndex}].repositoryPath");
            local repositoryActive=$(cat "${settingFile}" | jq ".scriptsRepositories[${repositoryIndex}].repositoryActive");

            if [ "${repositoryActive}" == "true" ]; then
                util.print.out '%b\n' "${B_RED}--> Repository......:${B_YELLOW} '${repository}' ${COLOR_OFF}";
                util.print.out '%b\n' "${B_RED}--> Repository Info.:${B_YELLOW} '${repositoryInfo}' ${COLOR_OFF}";
                util.print.out '%b\n' "${B_RED}--> Repository Path.:${B_YELLOW} '${repositoryPath}' ${COLOR_OFF}";
                util.print.out '%b\n' "${B_RED}--> Script Numbers..:${B_YELLOW} '${scriptSize}' ${COLOR_OFF}";

                for (( y=1; y<=$scriptSize; y++ )); do
                    local scriptIndex=$(($y-1));
                    local execute=$(cat "${settingFile}" | jq ".scriptsRepositories[${repositoryIndex}].scripts[${scriptIndex}].execute");
                    if [ "${execute}" == "true" ]; then
                        countScripts=$(($countScripts+1));
                        local script=$(cat "${settingFile}" | jq -r ".scriptsRepositories[${repositoryIndex}].scripts[${scriptIndex}].script"); 
                        local action=$(cat "${settingFile}" | jq -r ".scriptsRepositories[${repositoryIndex}].scripts[${scriptIndex}].action"); 
                        local param=$(cat "${settingFile}" | jq -c ".scriptsRepositories[${repositoryIndex}].scripts[${scriptIndex}].param");
                    
                        util.print.out '%b\n' "${B_WHITE}-----> N. Execution Order.:${B_CYAN} '${countScripts}ª' ${COLOR_OFF}";
                        util.print.out '%b\n' "${B_WHITE}-----> Script.............:${B_CYAN} '${script}'${COLOR_OFF}";
                        util.print.out '%b\n' "${B_WHITE}-----> Action.............:${CYAN} '${action}' ${COLOR_OFF}";
                        util.print.out '%b\n' "${B_WHITE}-----> Param..............:${CYAN} '${param}' ${COLOR_OFF}";
                        util.print.out '%b\n' "";
                    fi
                done
            fi
        done
    }

    # @descr: 
    __showAllScripts() {
        local repositoriesSize=$(cat "${settingFile}" | jq ".scriptsRepositories | length"); 

        __startNotifying;

        util.print.out '%b\n\n' "${ON_BLUE}${B_WHITE}--> LISTAR TODOS OS SCRIPTS EM ORDEM DE EXECUÇÃO... ${COLOR_OFF}";

        local countScripts=0;
        for (( x=1; x<=$repositoriesSize; x++ )); do
            local repositoryIndex=$(($x-1));
            local scriptSize=$(cat "${settingFile}" | jq ".scriptsRepositories[${repositoryIndex}].scripts | length"); 

            local repository=$(cat "${settingFile}" | jq -r ".scriptsRepositories[${repositoryIndex}].repository");
            local repositoryInfo=$(cat "${settingFile}" | jq -r ".scriptsRepositories[${repositoryIndex}].repositoryInfo");
            local repositoryPath=$(cat "${settingFile}" | jq -r ".scriptsRepositories[${repositoryIndex}].repositoryPath");
            local repositoryActive=$(cat "${settingFile}" | jq ".scriptsRepositories[${repositoryIndex}].repositoryActive");

            util.print.out '%b\n' "${B_RED}--> Repository........:${B_YELLOW} '${repository}' ${COLOR_OFF}";
            util.print.out '%b\n' "${B_RED}--> Repository Info...:${B_YELLOW} '${repositoryInfo}' ${COLOR_OFF}";
            util.print.out '%b\n' "${B_RED}--> Repository Path...:${B_YELLOW} '${repositoryPath}' ${COLOR_OFF}";
            util.print.out '%b\n' "${B_RED}--> Repository Active.:${B_YELLOW} '${repositoryActive}' ${COLOR_OFF}";
            util.print.out '%b\n' "${B_RED}--> Script Numbers....:${B_YELLOW} '${scriptSize}' ${COLOR_OFF}";

            for (( y=1; y<=$scriptSize; y++ )); do
                countScripts=$(($countScripts+1));
                local scriptIndex=$(($y-1));
                local script=$(cat "${settingFile}" | jq -r ".scriptsRepositories[${repositoryIndex}].scripts[${scriptIndex}].script"); 
                local action=$(cat "${settingFile}" | jq -r ".scriptsRepositories[${repositoryIndex}].scripts[${scriptIndex}].action"); 
                local param=$(cat "${settingFile}" | jq -c ".scriptsRepositories[${repositoryIndex}].scripts[${scriptIndex}].param");
                local execute=$(cat "${settingFile}" | jq ".scriptsRepositories[${repositoryIndex}].scripts[${scriptIndex}].execute");

                util.print.out '%b\n' "${B_WHITE}-----> N. Execution Order.: '${countScripts}ª' ${COLOR_OFF}";
                util.print.out '%b\n' "${WHITE}-----> Script.............: '${script}' ${COLOR_OFF}";
                util.print.out '%b\n' "${WHITE}-----> Action.............: '${action}' ${COLOR_OFF}";
                util.print.out '%b\n' "${WHITE}-----> Param..............: '${param}' ${COLOR_OFF}";
                if [ "${execute}" == "true" ]; then
                    util.print.out '%b\n' "${WHITE}-----> Execute............: ${B_GREEN}'${execute}' ${COLOR_OFF}";
                else
                    util.print.out '%b\n' "${WHITE}-----> Execute............: ${WHITE}'${execute}' ${COLOR_OFF}";
                fi

                util.print.out '%b\n' "";
            done
        done
    }
    
    # @descr: 
    __prepareScriptsExecution() {
        if [ -n "${settingFile}" ]; then 
            local isValidPath=$(util.validateFilePath "${settingFile}");    
            if [ "${isValidPath}" == "true" ]; then
                __showAllActiveScripts "${settingFile}";
                util.print.out '%b%s' "${B_WHITE}Deseja executar os scripts detalhados acima? [yes/no] $ ${COLOR_OFF}"; read input_run_scripts; 
                if [ "${input_run_scripts}" == "yes" ] || [ "${input_run_scripts}" == "y" ]; then
                    __runAllActiveScripts "${settingFile}";
                fi
            else 
                util.print.out '%b\n' "${RED}--> Error: Arquivo ou diretório não encontrado! ${B_RED}'${settingFile}' ${COLOR_OFF}";
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
        cat "./files/header.txt";
        util.print.out '%b\n' "${COLOR_OFF}";
        cat "./files/doc-commands.txt";
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
                clear;
                __prepareScriptsExecution "$@"; 
            };;
            *--list*|*-l*) { 
                clear;
                __showAllScripts "$@";
            };;
            *--help*|*-help*|*-h*|*help*) {
                clear;
                __help "$@"; 
            };;
            *--version*|*-version*|*-v*|*version*) {
                __version "$@"; 
            };;
        esac
    }
    
    # @descr: 
    mkdir -p "$pathLogGeneral";
    chmod -R 755 "$pathLogGeneral";
    __initialize "$@" | tee -a "${pathLogGeneral}${0##*/}.log";   
} 

# SCRIPT INITIALIZE...
util.try; ( 
    # Notificar usuario caso não exista o "jq" instalado na maquina, para instalar o "jq".
    if [ `util.isInstalled "jq"` == 1 ]; then
        StartDivineCreation "$@";
    else
        util.print.warning "Aviso: É necessario ter instalado a extensão 'jq' na maquina!";
        util.print.out '%b%s' "${B_WHITE}Deseja que o Garden of Eden instale? [yes/no] $ ${COLOR_OFF}"; read input_install_jq;
        if [ "${input_install_jq}" == "yes" ]; then
            installExtensionJQ;
            # Após a instalação da extensão 'jq' execute o Garden of Eden.
            StartDivineCreation "$@";
        fi
    fi
); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;