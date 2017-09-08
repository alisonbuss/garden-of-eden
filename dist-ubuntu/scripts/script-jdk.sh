#!/bin/bash

###################  DOC  ###################
# @descr: Instalação do JDK na maquina.
# @fonts: http://www.edivaldobrito.com.br/instalar-o-oracle-java-no-ubuntu/
#         https://www.digitalocean.com/community/tutorials/como-instalar-o-java-com-apt-get-no-ubuntu-16-04-pt#configurando-a-vari%C3%A1vel-de-ambiente-java_home
# @param: param | json
# @example: 
#    $ sudo chmod a+x install-jdk.sh
#    $ sudo ./install-jdk.sh
#############################################

function InstallJDK {
    local param=$1;

    __install() {
        msgInfo "Iniciando a instalação do JDK na maquina...";
         
        apt-get purge openjdk*;

        add-apt-repository ppa:webupd8team/java;
        apt-get update;

        apt-get install oracle-java8-installer;
        apt-get install oracle-java8-set-default;

        # Configurando a variável de ambiente do JAVA_HOME e JRE_HOME.
        msgWarning "O arquivo '/etc/environment' será aberto para ser configurado as variáveis de ambiente.";
        msgWarning "Ao final desse arquivo, adicione as seguintes linhas:";
        msgWarning 'JAVA_HOME="/usr/lib/jvm/java-8-oracle"';
        msgWarning 'JRE_HOME="/usr/lib/jvm/java-8-oracle"';
        msgWarning "Salve e saia do arquivo, para recarregar as variáveis de ambiente.";
        sleep 1s;
        read -p "Deseja realizar essa configuração? (yes/no): " input_proceed;
        if [ "$input_proceed" == "yes" ]; then
            # Abrindo o arquivo de variável de ambiente.
            gedit /etc/environment;
            # Recarregar o arquivo de variável de ambiente.
            source /etc/environment;
            # Imprimindo as variáveis de ambiente do Java.
            echo "Variavel JAVA_HOME: " $JAVA_HOME;
            echo "Variavel JRE_HOME: " $JRE_HOME;
        fi

        java -version;
    }

    __initialize() {
        if [ `isInstalled "jdk"` == 1 ]; then
            msgInfo "JDK já está instalanda na maquina...";
        else
            __install;
        fi 
    }

    __initialize;
}

InstallJDK $1;

exit 0;
