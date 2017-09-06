#!/bin/bash

###################  DOC  ###################
# @descr: ...  
# @fonts: https://howtoprogram.xyz/2016/07/23/install-vagrant-ubuntu-16-04/
#         http://danielfilho.github.io/2013/10/20/front-end-ops-vagrant/
#         https://www.olindata.com/en/blog/2014/07/installing-vagrant-and-virtual-box-ubuntu-1404-lts
# @param: param | json
# @example: 
#    $ sudo chmod a+x install-vagrant.sh
#    $ sudo ./install-vagrant.sh
#############################################

function InstallVagrant {
    local param=$1;

    __install() {
        echo "Iniciando a instalação do Vagrant na maquina..."; 

        wget "https://releases.hashicorp.com/vagrant/1.9.8/vagrant_1.9.8_x86_64.deb" -O ./binaries/vagrant.deb;
        chmod -R 777 ./binaries/vagrant.deb;

        dpkg -i ./binaries/vagrant.deb;

        # Remove o download do Vagrant
        rm ./binaries/vagrant.deb;
    }

    __initialize() {
        if [ `isInstalled "vagrant"` == 1 ]; then
            echo "Vagrant já está instalanda na maquina...";
        else
            __install;
        fi 
    }

    __initialize;
}

InstallVagrant $1;

exit 0;