#!/bin/bash
 
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Instalação da ferramenta para Terminal ZSH.
# @fonts: https://ohmyz.sh/
#         https://medium.com/@rgdev/como-instalar-oh-my-zsh-c0f96218fd90
#         https://medium.com/@leandroembu/produtividade-com-tilix-no-gnu-linux-35912366e8a9
#         https://blog.rocketseat.com.br/terminal-com-oh-my-zsh-spaceship-dracula-e-mais/
#         https://github.com/ohmyzsh/ohmyzsh/wiki/Themes#frisk
#         https://terminalroot.com.br/2018/02/como-instalar-e-usar-o-shell-zsh-e-o-oh-my-zsh.html
# @example:
#       bash script-zsh.sh --action='install' --param='{}'   
#-------------------------------------------------------------#

# @descr: Função principal do script-zsh.sh 
# @param: 
#    action | text: (install)
function ScriptZsh {
    
    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");

    # @descr: Função de instalação.
    __install() {
        util.print.out '%s\n' "Iniciando a instalação ZSH na maquina..."; 

        sudo apt-get install -y zsh;
        sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)";

        sed -i 's/ZSH_THEME=".*/ZSH_THEME="frisk"/' $HOME/.zshrc;
    }

    # @descr: Função é chamada qndo a um erro de tipo de ação.
    # @param: 
    #    action | text: "..." | Action não encontrado.
    __actionError() {
        local actionErr=$(util.getParameterValue "(--action=|-a=)" "$@");
        util.print.error "Erro: 'action' passado:(${actionErr}) não coincide com [install]!";
        return 1;
    } 

    # @descr: Função principal "um construtor por exemplo".
    __initialize() {
        case ${ACTION} in
            install) { 
                __install; 
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
util.try; ( ScriptZsh "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;
