#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação e desinstalação da linguagem programação Go na maquina.
# @font: https://github.com/canha/golang-tools-install-script
# @example:
#       bash script-golang.sh --action='install' --param='{"version":"8"}'
#   OR
#       bash script-golang.sh --action='uninstall' --param='{"version":"8"}'    
#-------------------------------------------------------------#

source <(wget --no-cache -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/import.sh"); 

import.ShellScriptTools "/linux/utility.sh";

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
    local version=$(echo ${PARAM_JSON} | jq -r '.version');

    # @descr: Função de instalação.
    __install() {
        util.print.info "Iniciando a instalação do GoLang na maquina..."; 

        local DFILE="go$version.linux-amd64.tar.gz";
        
        if [ -d "$HOME/.go" ] || [ -d "$HOME/go" ]; then
            util.print.warning "Aviso: GoLang já está instalanda na maquina!";
        else
            util.print.info "Downloading $DFILE...";

            wget "https://storage.googleapis.com/golang/$DFILE" -O ./binaries/go.tar.gz;
            chmod -R 777 ./binaries/go.tar.gz;

            util.print.info "Extracting GoLang...";

            tar -C "$HOME" -xzf ./binaries/go.tar.gz;
            mv "$HOME/go" "$HOME/.go";

            # Setando variáveis de ambiente.
            touch "$HOME/.profile"
            {
                echo '# GoLang';
                echo 'export GOROOT=$HOME/.go';
                echo 'export PATH=$PATH:$GOROOT/bin';
                echo 'export GOPATH=$HOME/go';
                echo 'export PATH=$PATH:$GOPATH/bin';
            } >> "$HOME/.profile";
            source ~/.profile;

            touch "$HOME/.bashrc"
            {
                echo '# GoLang';
                echo 'export GOROOT=$HOME/.go';
                echo 'export PATH=$PATH:$GOROOT/bin';
                echo 'export GOPATH=$HOME/go';
                echo 'export PATH=$PATH:$GOPATH/bin';
            } >> "$HOME/.bashrc";
            source ~/.bashrc;

            mkdir -p $HOME/go/{src,pkg,bin};
            echo -e "\nGo $version was installed.\nMake sure to relogin into your shell or run:";
            echo -e "\n\tsource $HOME/.bashrc\n\nto update your environment variables.";
            echo "Tip: Opening a new terminal window usually just works. :)";
            rm -f ./binaries/go.tar.gz;

            chmod -R 777 $HOME/go;
            chmod -R 777 $HOME/.go;

            go version;
        fi
    }

    # @descr: Função de desinstalação.
    __uninstall() {
        util.print.info "Iniciando a desinstalação do GoLang na maquina..."; 
        
        rm -rf "$HOME/.go/";
        rm -rf "$HOME/go/";
        sed -i '/# GoLang/d' "$HOME/.bashrc";
        sed -i '/export GOROOT/d' "$HOME/.bashrc";
        sed -i '/:$GOROOT/d' "$HOME/.bashrc";
        sed -i '/export GOPATH/d' "$HOME/.bashrc";
        sed -i '/:$GOPATH/d' "$HOME/.bashrc";

        util.print.info "Go removed."
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
