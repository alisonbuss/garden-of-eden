#!/bin/bash
 
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do PyEnv na maquina 
# @fonts: https://github.com/pyenv/pyenv
#         https://github.com/pyenv/pyenv#installation
#         https://github.com/pyenv/pyenv-installer
#         https://medium.com/trainingcenter/utilizando-pyenv-para-manter-multiplas-vers%C3%B5es-de-python-em-seus-projetos-8fce76d35b99
#         https://gist.github.com/luzfcb/ef29561ff81e81e348ab7d6824e14404
#         https://gist.github.com/jmvrbanac/8793985
#         https://medium.com/@Joachim8675309/installing-pythons-with-pyenv-54cca2196cd3
#         https://medium.com/operacionalti/gerenciamento-de-ambientes-python-com-pyenv-3ce71eb1a2c3
# @example:
#       bash script-pyenv.sh --action='install' --param='{}'
#-------------------------------------------------------------#

# @descr: Função principal do script-pyenv.sh
# @param: 
#    action | text: (install)
function ScriptPyenv {

    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");
    # @descr: Variavel de parametros JSON.
    local PARAM_JSON=$(util.getParameterValue "(--param=|-p=)" "$@");

    # @descr: Função de instalação.
    __install() {
        util.print.out '%s\n' "Iniciando a instalação do pyenv na maquina..."; 

        sudo apt-get install -y curl \
                                llvm \
                                tk-dev \
                                libbz2-dev \
                                liblzma-dev \
                                libsqlite3-dev \
                                libncurses5-dev \
                                libncursesw5-dev \
                                python-dev \
                                python3-dev \
                                python-openssl \
                                python-pip;

        curl -L "https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer" | bash;

        touch $HOME/.profile
        {
            echo '# PyEnv';
            echo 'export PYENV_ROOT="$HOME/.pyenv"';
            echo 'export PATH="$PYENV_ROOT/bin:$PATH"';
            echo 'eval "$(pyenv init -)"';
            echo 'eval "$(pyenv virtualenv-init -)"';
        } >> $HOME/.profile && source $HOME/.profile;

        touch $HOME/.bashrc
        {
            echo '# PyEnv';
            echo 'export PYENV_ROOT="$HOME/.pyenv"';
            echo 'export PATH="$PYENV_ROOT/bin:$PATH"';
            echo 'eval "$(pyenv init -)"';
            echo 'eval "$(pyenv virtualenv-init -)"';
        } >> $HOME/.bashrc && source $HOME/.bashrc;

        pyenv --version;
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
util.try; ( ScriptPyenv "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;
