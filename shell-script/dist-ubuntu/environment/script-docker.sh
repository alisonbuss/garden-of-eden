#!/bin/bash
 
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do Docker na maquina 
# @fonts: https://docs.docker.com/install/linux/docker-ce/ubuntu/
#         https://docs.docker.com/install/linux/linux-postinstall/
#         https://medium.com/@Grigorkh/how-to-install-docker-on-ubuntu-19-04-7ccfeda5935
#         https://www.fernandoike.com/2017/04/03/instalando-docker-ce-no-debian/
#         https://www.tauceti.blog/post/kubernetes-the-not-so-hard-way-with-ansible-worker/
#         https://github.com/githubixx/ansible-role-docker/blob/master/defaults/main.yml
#         https://github.com/githubixx/ansible-role-docker/blob/master/tasks/main.yml
#         https://linux4one.com/how-to-install-and-use-docker-on-ubuntu-18-04/?fbclid=IwAR3mG1VSUkLXiLGeN-cslh3V1cne0m5DrPGVtl8jhBIBygZeolzEtVz1lgM
# @example:
#       bash script-docker.sh --action='install' --param='{}'
#-------------------------------------------------------------#

# @descr: Função principal do script-docker.sh
# @param: 
#    action | text: (install)
function ScriptDocker {

    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");
    # @descr: Variavel de parametros JSON.
    local PARAM_JSON=$(util.getParameterValue "(--param=|-p=)" "$@");

    # @descr: Descrição da Variavel.
    local version=$(echo "${PARAM_JSON}" | $RUN_JQ -r '.version');
    local username=$(echo "${PARAM_JSON}" | $RUN_JQ -r '.username');

    # @descr: Função de instalação.
    __install() {
        util.print.out '%s\n' "Iniciando a instalação do Docker na maquina..."; 

        # Uninstall old versions
        # Older versions of Docker were called  
        # docker, docker.io , or docker-engine. 
        # If these are installed, uninstall them:
        apt-get remove docker docker-engine docker.io containerd runc;

        # Install packages to allow apt to use a repository over HTTPS:
        apt-get install \
                apt-transport-https \
                ca-certificates \
                curl \
                gnupg-agent \
                software-properties-common;
        
        # Add Docker’s official GPG key:
        curl -fsSL "https://download.docker.com/linux/ubuntu/gpg" | apt-key add - ;

        # To add the edge or test repository, add the word edge or 
        # test (or both) after the word stable in the commands below.
        add-apt-repository \
            "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
            $(lsb_release -cs) \
            stable edge test";

        # Install the latest version of Docker CE and containerd, 
        # or go to the next step to install a specific version:
        apt-get install docker-ce="${version}" \
                        docker-ce-cli="${version}" \
                        containerd.io;
        
        # To create the docker group and add your user:
        # Create the docker group.
        groupadd docker;
        # Add your user to the docker group.
        usermod -aG docker ${username};

        chown "${username}":"${username}" /home/"${username}"/.docker -R;
        chmod g+rwx "$HOME/.docker" -R;

        docker version;
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
util.try; ( ScriptDocker "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;
