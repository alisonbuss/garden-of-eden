#!/bin/bash
 
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Instalação de Ferramentas comuns na maquina 
# @fonts: https://vitux.com/linux-tree-command/
#         https://github.com/ytdl-org/youtube-dl
#         http://ytdl-org.github.io/youtube-dl/download.html
#         https://ohmyz.sh/
#         https://medium.com/@rgdev/como-instalar-oh-my-zsh-c0f96218fd90
#         https://medium.com/@leandroembu/produtividade-com-tilix-no-gnu-linux-35912366e8a9
#         https://blog.rocketseat.com.br/terminal-com-oh-my-zsh-spaceship-dracula-e-mais/
#         https://github.com/ohmyzsh/ohmyzsh/wiki/Themes#frisk
#         https://terminalroot.com.br/2018/02/como-instalar-e-usar-o-shell-zsh-e-o-oh-my-zsh.html
# @example:
#       bash script-tools.sh --action='install' --param='{}'   
#-------------------------------------------------------------#

# @descr: Função principal do script-tools.sh 
# @param: 
#    action | text: (install)
function ScriptTools {
    
    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");

    # @descr: Função de instalação.
    __install() {
        util.print.out '%s\n' "Iniciando a instalação das Ferramentas na maquina..."; 

        sudo apt-get install -y curl;
        sudo apt-get install -y ctop;
        sudo apt-get install -y tree;
        sudo apt-get install -y net-tools;

        # Command-line program to download videos from YouTube.com and other video sites
        sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl;
        sudo chmod a+rx /usr/local/bin/youtube-dl;

        youtube-dl --version;
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
util.try; ( ScriptTools "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;
