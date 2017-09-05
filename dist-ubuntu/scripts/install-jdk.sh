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

        apt-get install oracle-java9-installer;
        apt-get install oracle-java9-set-default;

	# Configurando a variável de ambiente do JAVA_HOME

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
