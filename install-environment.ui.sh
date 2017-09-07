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

function InstallEnvironmentUI {

    __initialize() {
        clear;

        #http://www.kammerl.de/ascii/AsciiSignature.php
        #http://patorjk.com/software/taag/#p=display&f=Graffiti&t=Type%20Something%20
        cat ./files/header.txt;



        select option in Factorial Addition Quit; do
        case "$option" in
            "Factorial")
                echo "Factorial"
                break ;;
            "Addition")
                echo "Addition"
                break ;;
            "Quit") exit ;;
        esac
        done
        

    }

    __initialize;
} 

# chamar a função e gerar log dela
InstallEnvironmentUI;

exit 0