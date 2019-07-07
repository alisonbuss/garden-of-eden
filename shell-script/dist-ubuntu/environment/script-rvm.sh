#!/bin/bash
 
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação e desinstalação do RVM na maquina.
# @fonts: https://rvm.io/rvm/install
#	      https://tutorialforlinux.com/2017/10/24/ruby-rvm-install-on-ubuntu-17-10-artful-step-by-step/
#         https://github.com/rvm/ubuntu_rvm
#         https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rvm-on-ubuntu-16-04
#         https://stackoverflow.com/questions/3558656/how-can-i-remove-rvm-ruby-version-manager-from-my-system
# @example:
#       bash script-rvm.sh --action='install' --param='{}'
#   OR
#       bash script-rvm.sh --action='uninstall' --param='{}'    
#-------------------------------------------------------------#

# @descr: Função principal do script-rvm.sh
# @param: 
#    action | text: (install, uninstall)
function ScriptRVM {

    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");

    # @descr: Função de instalação.
    __install() {
        util.print.out '%s\n' "Iniciando a instalação do RVM na maquina..."; 

        sudo add-apt-repository -y ppa:rael-gc/rvm;
        sudo apt-get update;

        sudo apt-get install -y curl gnupg2
        sudo apt-get install -y rvm;
        
        source /etc/profile.d/rvm.sh;

        echo -n "Version rvm: " && rvm version;
    }

    # @descr: Função de instalação.
    __install_bash() {
        util.print.out '%s\n' "Iniciando a instalação do RVM na maquina..."; 

        sudo apt-get install -y curl gnupg2;
        
        sudo gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB;

        curl -sSL https://get.rvm.io | sudo bash -s stable;

        source /etc/profile.d/rvm.sh;

        echo -n "Version rvm: " && rvm version;
    }

    # @descr: Função de desinstalação.
    __uninstall() {
        util.print.out '%s\n' "Iniciando a desinstalação do RVM na maquina..."; 

        #https://stackoverflow.com/questions/3558656/how-can-i-remove-rvm-ruby-version-manager-from-my-system
        rm -rf $HOME/.rvm;
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
util.try; ( ScriptRVM "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;
