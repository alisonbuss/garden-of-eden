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
#         https://www.linode.com/docs/security/authentication/gpg-key-for-ssh-authentication/
#         https://medium.com/@TheEdenCrazy/ssh-gpg-there-is-a-better-way-6f11365627a
#         https://medium.com/@mattdark/backup-restore-github-gpg-ssh-keys-a335db22b953
#         https://www.digitalocean.com/community/tutorials/como-instalar-e-usar-o-docker-no-ubuntu-18-04-pt
#         https://ajinkya007.in/2016/05/
#         https://cursos.alura.com.br/forum/topico-executar-o-docker-sem-precisar-de-sudo-50764
#         https://techoverflow.net/2018/12/15/how-to-fix-docker-got-permission-denied-while-trying-to-connect-to-the-docker-daemon-socket/
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

     # @descr: Variavel da versão de instalação.
    local version=$(echo ${PARAM_JSON} | $RUN_JQ -r '.version');

    # @descr: Função de instalação.
    # @param:
    #    version | text: "19.0.0"
    # @example:
    #    "param": { "version": "18.09.6" }
    __install_bin() {
        util.print.out '%s\n' "Iniciando a instalação do Docker na maquina..."; 

        # Install packages to allow apt to use a repository over HTTPS:
        sudo apt-get install -y curl \
                                gnupg-agent \
                                ca-certificates \
                                apt-transport-https \
                                software-properties-common;

        # Download the static binary archive:
        wget "https://download.docker.com/linux/static/stable/x86_64/docker-${version}.tgz" -O "./binaries/docker.tgz"; 

        util.print.out '%s\n' "Extracting Docker...";
        # Extract the archive using the tar utility. The dockerd and docker binaries are extracted.
        tar -xzvf ./binaries/docker.tgz -C ./binaries;

        # Move the binaries to a directory on your executable path, such as /usr/bin/
        sudo cp -f -v ./binaries/docker/* /usr/local/bin/;
        sudo chmod 755 /usr/local/bin/{containerd,containerd-shim,ctr,docker,dockerd,docker-init,docker-proxy,runc};

        # Moving the configuration files:
        sudo cp -f -v ./support-files/docker-configs/docker.socket /etc/systemd/system/docker.socket;
        sudo chmod 644 /etc/systemd/system/docker.socket;

        sudo cp -f -v ./support-files/docker-configs/docker.service /etc/systemd/system/docker.service;
        sudo chmod 644 /etc/systemd/system/docker.service;

        sudo cp -f -v ./support-files/docker-configs/containerd.service /etc/systemd/system/containerd.service;
        sudo chmod 644 /etc/systemd/system/containerd.service;

        # Create the docker group:
        sudo groupadd docker;

        # Add your user to the docker group:
        sudo usermod -a -G docker $USER;

        # Creating the docker configuration directory:
        mkdir -p $HOME/.docker;

        # Add permission for the configurations:
        sudo chmod -R g+rwx $HOME/.docker;
        sudo chown -v -R $USER:$USER $HOME/.docker;

        # Reload the systemd services:
        sudo systemctl daemon-reload;

        # Enable and start the (containerd) service on systemd:
        sudo systemctl enable containerd;
        #sudo systemctl start containerd;

        # Enable and start the (docker) service on systemd:
        sudo systemctl enable docker;
        #sudo systemctl start docker;

        # checking the installation of the docker version.
        docker --version;
    }

    # @descr: Função de instalação.
    __install_bash() {
        util.print.out '%s\n' "Iniciando a instalação do Docker na maquina..."; 

        # Install packages to allow apt to use a repository over HTTPS:
        sudo apt-get install -y curl \
                                gnupg-agent \
                                ca-certificates \
                                apt-transport-https \
                                software-properties-common;

        # Install Docker CE:
        curl -fsSL https://get.docker.com | bash;

        # Create the docker group:
        sudo groupadd docker;

        # Add your user to the docker group:
        sudo usermod -a -G docker $USER;

        # Creating the docker configuration directory.
        mkdir -p $HOME/.docker;

        # Add permission for the configurations:
        sudo chmod -R g+rwx $HOME/.docker;
        sudo chown -v -R $USER:$USER $HOME/.docker;

        # checking the installation of the docker version.
        docker version;
    }

    # @descr: Função de instalação.
    __install_apt() {
        util.print.out '%s\n' "Iniciando a instalação do Docker na maquina..."; 

        # Install packages to allow apt to use a repository over HTTPS:
        sudo apt-get install -y curl \
                                gnupg-agent \
                                ca-certificates \
                                apt-transport-https \
                                software-properties-common;

        # Add Docker’s official GPG key:
        curl -fsSL "https://download.docker.com/linux/ubuntu/gpg" | sudo apt-key add - ;

        # Now add the official Docker repository:
        sudo add-apt-repository -y \
            "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
            $(lsb_release -cs) stable";

        # Now let's update the apt packages again:
        sudo apt-get update;

        # Install Docker CE:
        sudo apt-get install -y docker-ce \
                                docker-ce-cli \
                                containerd.io;

        # Create the docker group:
        sudo groupadd docker;

        # Add your user to the docker group:
        sudo usermod -a -G docker $USER;

        # Creating the docker configuration directory.
        mkdir -p $HOME/.docker;

        # Add permission for the configurations:
        sudo chmod -R g+rwx $HOME/.docker;
        sudo chown -v -R $USER:$USER $HOME/.docker;

        # checking the installation of the docker version.
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
util.try; ( ScriptDocker "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;
