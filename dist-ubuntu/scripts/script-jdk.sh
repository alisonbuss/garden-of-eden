#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação e desinstalação do JDK na maquina.
# @fonts: http://www.edivaldobrito.com.br/instalar-o-oracle-java-no-ubuntu/
#         https://www.digitalocean.com/community/tutorials/como-instalar-o-java-com-apt-get-no-ubuntu-16-04-pt#configurando-a-vari%C3%A1vel-de-ambiente-java_home
# @example:
#       bash script-jdk.sh --action='install' --param='{"version":"8"}'
#   OR
#       bash script-jdk.sh --action='uninstall' --param='{"version":"8"}'    
#-------------------------------------------------------------#

source <(wget --no-cache -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/import.sh"); 

import.ShellScriptTools "/linux/utility.sh";

# @descr: Função principal do script-jdk.sh
# @param: 
#    action | text: (install, uninstall)
#    param | json: '{"version":"..."}'
function ScriptJDK {
    
    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");

    # @descr: Variavel de parametros JSON.
    local PARAM_JSON=$(util.getParameterValue "(--param=|-p=)" "$@");

    # @descr: Variavel da versão de instalação.
    local version=$(echo ${PARAM_JSON} | jq -r '.version');

    # @descr: Função de instalação.
    __install() {
        util.print.info "Iniciando a instalação do JDK na maquina...";

        apt-get purge openjdk*;

        add-apt-repository ppa:webupd8team/java;
        apt-get update;

        apt-get install "oracle-java$version-installer";
        apt-get install "oracle-java$version-set-default";

        # Configurando a variável de ambiente do JAVA_HOME e JRE_HOME.
        util.print.out '%b' "\033[1;32m";
        util.print.out '%s\n' "O arquivo '/etc/environment' será editado para ser adicionado as variáveis de ambiente.";
        util.print.out '%s\n' "Ao final desse arquivo, será adicionado as seguintes linhas:";
        util.print.out '%b\n' 'JAVA_HOME="/usr/lib/jvm/java-'$version'-oracle"';
        util.print.out '%b\n' 'JRE_HOME="/usr/lib/jvm/java-'$version'-oracle"';
        util.print.out '%b' "\033[0m";
        sleep 1s;

        util.print.out '%b' "\033[1;33m";
        util.print.out '%b' "Deseja realizar essa configuração? [yes/no] $ "; read input_proceed;
        util.print.out '%b' "\033[0m";
        if [ "$input_proceed" == "yes" ]; then
            # Editando o arquivo de variável de ambiente.
            touch "/etc/environment"
            {
                echo 'JAVA_HOME="/usr/lib/jvm/java-'$version'-oracle"';
                echo 'JRE_HOME="/usr/lib/jvm/java-'$version'-oracle"';
            } >> "/etc/environment";
  
            # Recarregar o arquivo de variável de ambiente.
            source /etc/environment;
            
            # Imprimindo as variáveis de ambiente do Java.
            util.print.out '%s\n' "Variavel JAVA_HOME: " $JAVA_HOME;
            util.print.out '%s\n' "Variavel JRE_HOME: " $JRE_HOME;
        fi

        java -version;
    }

    # @descr: Função de desinstalação.
    __uninstall() {
        util.print.info "Iniciando a desinstalação do JDK na maquina..."; 
        
        apt-get --auto-remove remove "oracle-java$version-installer";
        apt-get --auto-remove purge "oracle-java$version-installer";
    }

    # @descr: Função é chamada qndo a um erro de tipo de ação.
    # @param: 
    #    action | text: "..." | Action não encontrado.
    __actionError() {
        local actionErr=$(util.getParameterValue "(--action=|-a=)" "$@");
        util.print.error "Erro: 'action' passado:(${actionErr}) não coincide com [install, uninstall]!";
        return 1;
    } 

    # @descr: Função principal "um construtor por exemplo".
    __initialize() {
        case ${ACTION} in
            install) { 
                __install; 
            };;
            uninstall) { 
                __uninstall;
            };;
            *) {
               __actionError "--action=${ACTION}"; 
            };;
        esac
    }

    # @descr: Chamada da função principal de inicialização do script.
    __initialize;
}

# SCRIPT INITIALIZE...
util.try; ( ScriptJDK "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;