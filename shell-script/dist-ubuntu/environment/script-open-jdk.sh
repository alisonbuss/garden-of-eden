#!/bin/bash
 
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação e desinstalação do JDK na maquina.
# @fonts: https://www.hostinger.com.br/tutoriais/install-maven-ubuntu/
#         https://techexpert.tips/pt-br/apache-maven-pt-br/apache-maven-instalacao-no-ubuntu-linux/
#         https://www.youtube.com/watch?v=23rN0oDdOKg
# @example:
#       bash script-open-jdk.sh --action='install' --param='{"version":"11"}'
#   OR
#       bash script-open-jdk.sh --action='uninstall' --param='{"version":"11"}'    
#-------------------------------------------------------------#

# @descr: Função principal do script-open-jdk.sh
# @param: 
#    action | text: (install, uninstall)
#    param | json: '{"version":"..."}'
function ScriptJDK {
    
    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");
    # @descr: Variavel de parametros JSON.
    local PARAM_JSON=$(util.getParameterValue "(--param=|-p=)" "$@");

    # @descr: Variavel da versão de instalação.
    local version=$(echo ${PARAM_JSON} | $RUN_JQ -r '.version');

    # @descr: Função de instalação.
    # @param: 
    #    version | text: "11"
    # @example:
    #    "param": { "version": "11" }
    __install() {
        util.print.out '%s\n' "Iniciando a instalação do JDK na maquina...";

        sudo apt-get install -y "openjdk-$version-jdk";

        java -version;

        # Install the Apache Maven 3.6.3.

        sudo apt-get install -y maven;

        mvn -version;

        # OR:

        # wget "https://downloads.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz" -O ./binaries/apache-maven.tar.gz;
        
        # util.print.out '%s\n' "Extracting Apache Maven...";
        # sudo tar -xzf ./binaries/apache-maven.tar.gz -C /opt;
   
        # # Setando variáveis de ambiente.
        # touch /etc/profile.d/maven.sh
        # {
        #     echo '#/bin/bash';
        #     echo '# Apache Maven';
        #     echo 'export M2_HOME=/opt/maven';
        #     echo 'export MAVEN_HOME=/opt/maven';
        #     echo 'export PATH=/opt/maven/bin:${PATH}';
        # } > /etc/profile.d/maven.sh;
        
        # sudo chmod +x /etc/profile.d/maven.sh;
        
        # source /etc/profile.d/maven.sh;

        # mvn -version;
    }

    # @descr: Função de desinstalação.
    __uninstall() {
        util.print.out '%s\n' "Iniciando a desinstalação do JDK na maquina..."; 
        
        sudo apt-get purge openjdk*;
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