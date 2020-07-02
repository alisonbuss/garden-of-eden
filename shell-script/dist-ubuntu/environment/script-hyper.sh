#!/bin/bash
 
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação e desinstalação do Hyper na maquina 
# @fonts: https://hyper.is/
#         https://starship.rs/
#         https://linuxhint.com/install_hyper_terminal_ubuntu18/
#         https://tjay.dev/howto-my-terminal-shell-setup-hyper-js-zsh-starship/
#         https://github.com/vercel/hyper/releases
# @example:
#       bash script-hyper.sh --action='install' --param='{"version":"..."}'
#   OR
#       bash script-hyper.sh --action='uninstall' --param='{}'    
#-------------------------------------------------------------#

# @descr: Função principal do script-hyper.sh
# @param:
#    action | text: (install, uninstall)
#    param | json: '{"version":"..."}'
function ScriptHyper {
    
    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");
    # @descr: Variavel de parametros JSON.
    local PARAM_JSON=$(util.getParameterValue "(--param=|-p=)" "$@");

    # @descr: Variavel da versão de instalação.
    local version=$(echo ${PARAM_JSON} | $RUN_JQ -r '.version');

    # @descr: Função de instalação.
    __install() {
        util.print.out '%s\n' "Iniciando a instalação do Hyper na maquina..."; 

        wget "https://github.com/vercel/hyper/releases/download/${version}/hyper_${version}_amd64.deb" -O ./binaries/hyper.deb;

        # sudo dpkg -i ./binaries/hyper.deb;
        sudo apt install ./binaries/hyper.deb;

        hyper version;
        # https://github.com/Hyperline/hyperline
        hyper install hyperline;
        # https://hyper.is/store/hyper-search
        hyper install hyper-search;
        # https://hyper.is/store/hyper-one-dark
        hyper install hyper-one-dark;

        curl -fsSL https://starship.rs/install.sh | bash;
        starship --version;       
        echo -e '\n\n# Config Starship' >> ~/.bashrc;
        echo -e 'eval "$(starship init bash)" \n' >> ~/.bashrc;
        mkdir -p ~/.config;
        cp -f -v ./support-files/configs/starship/starship.toml ~/.config/starship.toml; 
    }

    # @descr: Função de desinstalação.
    __uninstall() {
        util.print.out '%s\n' "Iniciando a desinstalação do Hyper na maquina..."; 
        
        hyper uninstall hyperline;
        hyper uninstall hyper-search;
        hyper uninstall hyper-one-dark;

        sudo apt-get remove --auto-remove hyper;
        sudo apt-get purge --auto-remove hyper;
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
util.try; ( ScriptHyper "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;
