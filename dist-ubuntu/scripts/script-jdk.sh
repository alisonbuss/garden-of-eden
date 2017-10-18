#!/bin/bash

###################  DOC  ###################
# @descr: Instalação do JDK na maquina.
# @fonts: http://www.edivaldobrito.com.br/instalar-o-oracle-java-no-ubuntu/
#         https://www.digitalocean.com/community/tutorials/como-instalar-o-java-com-apt-get-no-ubuntu-16-04-pt#configurando-a-vari%C3%A1vel-de-ambiente-java_home
# @param: 
#    action | text: (install, uninstall)
#    paramJson | json: {"version":"..."}
#############################################

source <(wget -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/linux/utility.sh");

function ScriptJDK {
    
    local ACTION=$1;
    local PARAM_JSON=$2;

    local version=$(echo ${PARAM_JSON} | jq -r '.version');

    __install() {
        print.info "Iniciando a instalação do JDK na maquina...";

        apt-get purge openjdk*;

        add-apt-repository ppa:webupd8team/java;
        apt-get update;

        apt-get install "oracle-java$version-installer";
        apt-get install "oracle-java$version-set-default";

        # Configurando a variável de ambiente do JAVA_HOME e JRE_HOME.
        print.out '%b' "\033[1;32m";
        print.out '%s\n' "O arquivo '/etc/environment' será editado para ser adicionado as variáveis de ambiente.";
        print.out '%s\n' "Ao final desse arquivo, será adicionado as seguintes linhas:";
        print.out '%b\n' 'JAVA_HOME="/usr/lib/jvm/java-'$version'-oracle"';
        print.out '%b\n' 'JRE_HOME="/usr/lib/jvm/java-'$version'-oracle"';
        print.out '%b' "\033[0m";
        sleep 1s;

        print.out '%b' "\033[1;33m";
        print.out '%b' "Deseja realizar essa configuração? [yes/no] $ "; read input_proceed;
        print.out '%b' "\033[0m";
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
            print.out '%s\n' "Variavel JAVA_HOME: " $JAVA_HOME;
            print.out '%s\n' "Variavel JRE_HOME: " $JRE_HOME;
        fi

        java -version;
    }

    __uninstall() {
        print.info "Iniciando a desinstalação do JDK na maquina..."; 
        
        apt-get --auto-remove remove "oracle-java$version-installer";
        apt-get --auto-remove purge "oracle-java$version-installer";
    }

    __actionError() {
        print.error "Erro: 'action' passado:($ACTION) não coincide com [install, uninstall]!";
    } 

    __initialize() {
        case ${ACTION} in
            install) __install; ;;
            uninstall) __uninstall; ;;
            *) __actionError;
        esac
    }

    __initialize;
}

ScriptJDK "$@";

exit 0;
