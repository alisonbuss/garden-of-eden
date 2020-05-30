#!/bin/bash
 
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do Docker Machine na maquina 
# @fonts: https://docs.docker.com/machine/install-machine/
#         https://linuxhint.com/setup_docker_machine_virtualbox/
#         https://linuxtechlab.com/create-manage-docker-hosts-with-docker-machine/
#         https://linoxide.com/linux-how-to/host-virtualbox-docker-machine/
# @example:
#       bash script-machine.sh --action='install' --param='{}'
#-------------------------------------------------------------#

# @descr: Função principal do script-docker-machine.sh
# @param: 
#    action | text: (install)
function ScriptDockerMachine {

    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");
    # @descr: Variavel de parametros JSON.
    local PARAM_JSON=$(util.getParameterValue "(--param=|-p=)" "$@");

     # @descr: Variavel da versão de instalação.
    local version=$(echo ${PARAM_JSON} | $RUN_JQ -r '.version');

    # @descr: Função de instalação.
    # @param:
    #    version | text: "19.0.0"
    # @example:
    #    "param": { "version": "18.09.6" }
    __install_bin() {
        util.print.out '%s\n' "Iniciando a instalação do (Docker Machine) na maquina..."; 

        # Download the static binary archive:
        wget "https://github.com/docker/machine/releases/download/v${version}/docker-machine-Linux-x86_64" -O "./binaries/docker-machine"; 

        # Move the Docker Machine to a directory on your executable path, such as /usr/bin/
        sudo cp -f -v ./binaries/docker-machine /usr/local/bin/docker-machine;
        sudo chmod 755 /usr/local/bin/docker-machine;

        # Moving the configuration files:
        local urlRawGithub="https://raw.githubusercontent.com/docker/machine/v${version}";

        for fileConfig in docker-machine-prompt.bash docker-machine-wrapper.bash docker-machine.bash; do
            sudo wget "$urlRawGithub/contrib/completion/bash/${fileConfig}" -P /etc/bash_completion.d;
        done

        # # Checks whether the file exists and runs:
        # for fileConfig in /etc/bash_completion.d/* ; do
        #     echo "Executando bash: '$fileConfig'";
        #     [ -f "$fileConfig" ] && source $fileConfig;
        # done
        sudo source /etc/bash_completion.d/docker-machine-prompt.bash;

        docker-machine --version;

        # Executar o (Docker Machine)
        # Fonte: https://linuxhint.com/setup_docker_machine_virtualbox/

        # Para criar uma nova VM(Docker Machine), execute o seguinte comando:
        # $ docker-machine create --driver=virtualbox default;

        # Listando todas as máquinas Docker disponíveis:
        # $ docker-machine ls;

        # Ativando uma determinada VM(Docker Machine) na sessão atual:
        # $ docker-machine use default; ## Ou $ eval $(docker-machine env default);
        # Executar o (Docker Client) da VM(Docker Machine) default:
        # docker version;

        # Verificando qual VM(Docker Machine) está ativa:
        # $ docker-machine active;

        # Desativando uma VM(Docker Machine) ativa:
        # $ docker-machine use -u; # Ou $ eval $(docker-machine env -u);

        # Conexão via SSH de uma determinada VM(Docker Machine):
        # $ docker-machine ssh default;
        # $ exit;

        # Imprimindo o endereço IP de uma determinada VM(Docker Machine):
        # $ docker-machine ip default;

        # Parando uma determinada VM(Docker Machine):
        # $ docker-machine stop default;
        # $ docker-machine ls;

        # Iniciando/Subindo uma determinada VM(Docker Machine):
        # $ docker-machine start default;
        # $ docker-machine ls;
        
        # Remoção uma determinada VM(Docker Machine):
        # $ docker-machine rm default;
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
                __install_bin; 
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
util.try; ( ScriptDockerMachine "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;
