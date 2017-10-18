#!/bin/bash

###################  DOC  ###################
# @descr: Script do Bash para automatizar as ferramentas de 
#         instalação da linguagem programação Go em um usuário (Linux) ou remoção.
# @font: https://github.com/canha/golang-tools-install-script
# @param: 
#    action | text: (install, uninstall)
#    paramJson | json: {"version":"..."}
#############################################

source <(wget -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/linux/utility.sh");

function ScriptGoLang {

    local ACTION=$1;
    local PARAM_JSON=$2;

    local version=$(echo ${PARAM_JSON} | jq -r '.version');

    __install() {
        print.info "Iniciando a instalação do GoLang na maquina..."; 

        local DFILE="go$version.linux-amd64.tar.gz";
        
        if [ -d "$HOME/.go" ] || [ -d "$HOME/go" ]; then
            print.warning "Aviso: GoLang já está instalanda na maquina!";
        else
            print.info "Downloading $DFILE...";

            wget "https://storage.googleapis.com/golang/$DFILE" -O ./binaries/go.tar.gz;
            chmod -R 777 ./binaries/go.tar.gz;

            print.info "Extracting GoLang...";

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

    __uninstall() {
        print.info "Iniciando a desinstalação do GoLang na maquina..."; 
        
        rm -rf "$HOME/.go/";
        rm -rf "$HOME/go/";
        sed -i '/# GoLang/d' "$HOME/.bashrc";
        sed -i '/export GOROOT/d' "$HOME/.bashrc";
        sed -i '/:$GOROOT/d' "$HOME/.bashrc";
        sed -i '/export GOPATH/d' "$HOME/.bashrc";
        sed -i '/:$GOPATH/d' "$HOME/.bashrc";

        print.info "Go removed."
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

ScriptGoLang "$@";

exit 0;
