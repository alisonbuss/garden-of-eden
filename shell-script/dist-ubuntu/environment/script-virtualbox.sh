#!/bin/bash
 
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação e desinstalação do VirtualBox na maquina.    
# @fonts: https://websiteforstudents.com/installing-virtualbox-5-2-ubuntu-17-04-17-10/
#         https://askubuntu.com/questions/762136/cannot-reinstall-virtualbox-on-ubuntu-16-04
#	      http://www.edivaldobrito.com.br/virtualbox-no-linux/
#         http://www.edivaldobrito.com.br/sbinvboxconfig-nao-esta-funcionando/
#         https://www.olindata.com/en/blog/2014/07/installing-vagrant-and-virtual-box-ubuntu-1404-lts
#         https://www.howtoinstall.co/pt/ubuntu/xenial/virtualbox?action=remove
#         https://tecadmin.net/install-virtualbox-on-ubuntu-18-04/
#         https://www.linuxtechi.com/install-virtualbox6-ubuntu-18-04-centos-7/
#         https://www.diolinux.com.br/2019/02/como-instalar-o-virtualbox-6-no-linux.html
# @example:
#       bash script-virtualbox.sh --action='install' --param='{"version":"5.1.30","tagVersion":"5.1.30-118389"}'
#   OR
#       bash script-virtualbox.sh --action='uninstall' --param='{}'    
#-------------------------------------------------------------#

# @descr: Função principal do script-virtualbox.sh
# @info: o parametro "tagVersion" é um padrão dos programas do site oficial do VirtualBox.
#        Para extrair o "tagVersion" análise o a numeração do link abaixo após o versionamento do programa:
#  
#   http://download.virtualbox.org/virtualbox/5.2.2/VirtualBox-5.2.2-119230-Linux_amd64.run
#   http://download.virtualbox.org/virtualbox/5.2.2/Oracle_VM_VirtualBox_Extension_Pack-5.2.2-119230.vbox-extpack
#
#   http://download.virtualbox.org/virtualbox/6.0.0/VirtualBox-6.0.0-127566-Linux_amd64.run
#   http://download.virtualbox.org/virtualbox/6.0.0/Oracle_VM_VirtualBox_Extension_Pack-6.0.0-127566.vbox-extpack 
#
#   Após o análise, se extrai o tagVersion -> 5.2.2-119230 OR 5.2.30-130521
#
#   Exemplo: {"version":"5.2.2","tagVersion":"5.2.2-119230"}
#
# @param: 
#    action | text: (install, uninstall)
#    param | json: '{"version":"5.1.30","tagVersion":"5.1.30-118389"}'
function ScriptVirtualBox {
    
    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");
    # @descr: Variavel de parametros JSON.
    local PARAM_JSON=$(util.getParameterValue "(--param=|-p=)" "$@");

    # @descr: Variavel da versão de instalação.
    local    version=$(echo ${PARAM_JSON} | $RUN_JQ -r '.version');
    # @descr: Variavel Extension Pack, uma extensão do VirtualBox.
    local tagVersion=$(echo ${PARAM_JSON} | $RUN_JQ -r '.tagVersion');

    # @descr: Função de instalação.
    __install() {
        util.print.out '%s\n' "Iniciando a instalação do VirtualBox na maquina..."; 

        local nameVirtualBox="VirtualBox-${tagVersion}-Linux_amd64.run";
        local nameExtensionPack="Oracle_VM_VirtualBox_Extension_Pack-${tagVersion}.vbox-extpack";

        # wget "https://download.virtualbox.org/virtualbox/5.2.40/VirtualBox-5.2.40-137108-Linux_amd64.run" -O "./binaries/virtualbox-5.2.run";
        wget "https://download.virtualbox.org/virtualbox/${version}/${nameVirtualBox}" -O "./binaries/virtualbox.run";
        # wget "https://download.virtualbox.org/virtualbox/5.2.40/Oracle_VM_VirtualBox_Extension_Pack-5.2.40.vbox-extpack" -O "./binaries/Oracle_VM_VirtualBox_Extension_Pack-5.2.34.vbox-extpack";
        wget "https://download.virtualbox.org/virtualbox/${version}/${nameExtensionPack}" -O "./binaries/${nameExtensionPack}";

        # Instalar algumas dependências
        sudo apt-get install -y gcc make linux-headers-$(uname -r) dkms;
        sudo apt-get install -f;

        # Instalar o VirtualBox e suas dependências 
        sudo chmod +x ./binaries/virtualbox.run;
        sudo ./binaries/virtualbox.run;
        sudo apt-get install -f;

        # Instalar a extensão do VirtualBox 
        VBoxManage extpack install "./binaries/${nameExtensionPack}";

        echo -n "Version VirtualBox: ";
        VBoxManage -v;
        echo "";
        VBoxManage list extpacks;
    }

    # @descr: Função de desinstalação.
    __uninstall() {
        util.print.out '%s\n' "Iniciando a desinstalação do VirtualBox na maquina..."; 
        
        sudo sh /opt/VirtualBox/uninstall.sh;
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
util.try; ( ScriptVirtualBox "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;
