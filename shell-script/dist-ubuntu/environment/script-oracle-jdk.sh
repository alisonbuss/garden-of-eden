#!/bin/bash
 
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação e desinstalação do JDK na maquina.
# @fonts: http://www.edivaldobrito.com.br/instalar-o-oracle-java-no-ubuntu/
#         https://www.digitalocean.com/community/tutorials/como-instalar-o-java-com-apt-get-no-ubuntu-16-04-pt#configurando-a-vari%C3%A1vel-de-ambiente-java_home
#         https://www.edivaldobrito.com.br/como-corrigir-o-erro-add-ppa-ubuntu/
#         https://sempreupdate.com.br/como-instalar-o-oracle-java-11-no-ubuntu-linux-mint-ou-debian/
#         https://www.edivaldobrito.com.br/oracle-java-11-no-ubuntu/
#         https://www.javahelps.com/2017/09/install-oracle-jdk-9-on-linux.html
# @example:
#       bash script-oracle-jdk.sh --action='install' --param='{"version":"8"}'
#   OR
#       bash script-oracle-jdk.sh --action='uninstall' --param='{"version":"8"}'    
#-------------------------------------------------------------#

# @descr: Função principal do script-oracle-jdk.sh
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

     # @descr: Variavel da path de instalação.
    local binaryPath=$(echo ${PARAM_JSON} | $RUN_JQ -r '.binaryPath');

    # @descr: Função de instalação.
    # @param: 
    #    version | text: "11"
    # @example:
    #    "param": { "version": "11" }
    __install() {
        util.print.out '%s\n' "Iniciando a instalação do JDK na maquina...";

        sudo apt-get purge openjdk*;

        #sudo add-apt-repository -y ppa:webupd8team/java;
        sudo add-apt-repository -y ppa:linuxuprising/java;
        sudo apt-get update;

        sudo apt search "oracle-java$version";

        sudo apt-get install -y "oracle-java$version-installer";
        sudo apt-get install -y "oracle-java$version-set-default";

        java -version;

        # Install the Apache Maven 3.6.3.

        # sudo apt-get install -y maven;

        # OR:

        wget "https://downloads.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz" -O ./binaries/apache-maven.tar.gz;
        
        util.print.out '%s\n' "Extracting Apache Maven...";
        sudo tar -xzf ./binaries/apache-maven.tar.gz -C /opt;
   
        # Setando variáveis de ambiente.
        touch /etc/profile.d/maven.sh
        {
            echo '#/bin/bash';
            echo '# Apache Maven';
            echo 'export M2_HOME=/opt/maven';
            echo 'export MAVEN_HOME=/opt/maven';
            echo 'export PATH=/opt/maven/bin:${PATH}';
        } > /etc/profile.d/maven.sh;
        
        sudo chmod +x /etc/profile.d/maven.sh;
        
        source /etc/profile.d/maven.sh;

        mvn -version;
    }

    # # @descr: Função de instalação.
    # # @param: 
    # #    version | text: "11.0.3"
    # #    binaryPath | text: "./binaries/jdk-linux64-v11.0.3.tar.gz"
    # # @example:
    # #    "param": { "version": "11.0.3", "binaryPath": "./binaries/jdk-linux64-v11.0.3.tar.gz" }
    # __install() {
    #     util.print.out '%s\n' "Iniciando a instalação do JDK na maquina...";

    #     sudo apt-get purge openjdk*;

    #     # wget --no-cookies \
    #     #      --no-check-certificate \
    #     #      --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    #     #      "https://download.oracle.com/otn/java/jdk/11.0.3+12/37f5e150db5247ab9333b11c1dddcd30/jdk-11.0.3_linux-x64_bin.tar.gz" \
    #     #      -O "./binaries/jdk-11.0.3_linux-x64_bin.tar.gz";

    #     sudo mkdir -p /usr/lib/jvm;
    #     sudo tar -xzf $binaryPath -C /usr/lib/jvm;

    #     # Configurando a variável de ambiente do JAVA_HOME e JRE_HOME.
    #     sudo touch /etc/environment
    #     {     
    #         echo 'PATH="$PATH:/usr/lib/jvm/jdk-'$version'/bin"';
    #         echo 'JAVA_HOME="/usr/lib/jvm/jdk-'$version'"';
    #         echo 'JRE_HOME="/usr/lib/jvm/jdk-'$version'"';
    #     } >> "/etc/environment";

    #     # Recarregar o arquivo de variável de ambiente.
    #     sudo source /etc/environment;

    #     # As variáveis de ambiente do Java.
    #     util.print.out '%s\n' "Variavel JAVA_HOME: " $JAVA_HOME;
    #     util.print.out '%s\n' "Variavel  JRE_HOME: " $JRE_HOME;
        
    #     sudo update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk-$version/bin/java" 0;
    #     sudo update-alternatives --set java "/usr/lib/jvm/jdk-$version/bin/java";

    #     sudo update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk-$version/bin/javac" 0;
    #     sudo update-alternatives --set javac "/usr/lib/jvm/jdk-$version/bin/javac";

    #     java -version;
    # }

    # @descr: Função de desinstalação.
    __uninstall() {
        util.print.out '%s\n' "Iniciando a desinstalação do JDK na maquina..."; 
        
        sudo apt-get --auto-remove remove "oracle-java$version-installer";
        sudo apt-get --auto-remove purge "oracle-java$version-installer";
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