#!/bin/bash

###################  DOC  ###################
# @descr: Script de instalação
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
    local paramScript="$1";
    local paramOfScript="$2";
    local pathDefault=$(cat settings.json | jq -r '.pathDefault');

    __initialize() {
        # Caso não exista o "jq" instalado na maquina, instale o "jq".
        if [ `isInstalled "jq"` == 1 ]; then
            msgInfo "A extenção 'jq' já está instalanda na maquina...";
        else
            msgInfo "Instalando a extenção 'jq' na maquina...";
            installExtensionJQ;
        fi
 
    }

    __initialize;
} 

# chamar a função e gerar log dela
StartDivineCreation $@ | tee -a ./${0##*/}.log;

exit 0