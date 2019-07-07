#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação e desinstalação da linguagem programação Go na maquina.
# @fonts: https://github.com/canha/golang-tools-install-script
#         https://snapcraft.io/go
# @example:
#       bash script-golang.sh --action='install' --param='{"version":"8"}'
#   OR
#       bash script-golang.sh --action='uninstall' --param='{"version":"8"}'    
#-------------------------------------------------------------#

# @descr: Função principal do script-golang.sh
# @param: 
#    action | text: (install, uninstall)
#    param | json: '{"version":"..."}'
function ScriptGoLang {

    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");
    # @descr: Variavel de parametros JSON.
    local PARAM_JSON=$(util.getParameterValue "(--param=|-p=)" "$@");

    # @descr: Variavel da versão de instalação.
    local version=$(echo ${PARAM_JSON} | $RUN_JQ -r '.version');

    # @descr: Função de instalação.
    __install() {
        util.print.out '%s\n' "Iniciando a instalação do GoLang na maquina..."; 

        if [ $(which go) ] ; then
            util.print.warning "Aviso: GoLang já está instalanda na maquina!";
        else
            util.print.out '%s\n' "Downloading go${version}.linux-amd64.tar.gz...";

            # https://snapcraft.io/go
            # sudo snap install --classic --channel=1.12/stable go
            # go version

            # OR...

            wget "https://storage.googleapis.com/golang/go${version}.linux-amd64.tar.gz" -O ./binaries/go.tar.gz;

            util.print.out '%s\n' "Extracting GoLang...";
            tar -C $HOME -xzf ./binaries/go.tar.gz;
            mv $HOME/go $HOME/.go;

            # Setando variáveis de ambiente.
            touch $HOME/.profile
            {
                echo '# GoLang';
                echo 'export GOROOT=$HOME/.go';
                echo 'export PATH=$PATH:$GOROOT/bin';
                echo 'export GOPATH=$HOME/go';
                echo 'export PATH=$PATH:$GOPATH/bin';
            } >> $HOME/.profile && source $HOME/.profile;

            touch $HOME/.bashrc
            {
                echo '# GoLang';
                echo 'export GOROOT=$HOME/.go';
                echo 'export PATH=$PATH:$GOROOT/bin';
                echo 'export GOPATH=$HOME/go';
                echo 'export PATH=$PATH:$GOPATH/bin';
            } >> $HOME/.bashrc && source ~/.bashrc;

            go version;
        fi
    }

    # @descr: Função de desinstalação.
    __uninstall() {
        util.print.out '%s\n' "Iniciando a desinstalação do GoLang na maquina..."; 
        
        rm -rf $HOME/.go;
        rm -rf $HOME/go;

        sed -i '/# GoLang/d' $HOME/.profile;
        sed -i '/export GOROOT/d' $HOME/.profile;
        sed -i '/:$GOROOT/d' $HOME/.profile;
        sed -i '/export GOPATH/d' $HOME/.profile;
        sed -i '/:$GOPATH/d' $HOME/.profile;

        sed -i '/# GoLang/d' $HOME/.bashrc;
        sed -i '/export GOROOT/d' $HOME/.bashrc;
        sed -i '/:$GOROOT/d' $HOME/.bashrc;
        sed -i '/export GOPATH/d' $HOME/.bashrc;
        sed -i '/:$GOPATH/d' $HOME/.bashrc;

        util.print.out '%s\n' "Go removed."
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
util.try; ( ScriptGoLang "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;
