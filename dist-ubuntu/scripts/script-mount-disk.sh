#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Criar um script de montagem de partições automatico na inicialização do sistema.     
# @fonts: http://www.projetopinguim.com.br/artigos/acessando-particoes-no-terminal
#         https://www.vivaolinux.com.br/script/Automontador-de-particoes/
#         http://rberaldo.com.br/executando-scripts-na-inicializacao-do-debianubuntu/
#         https://www.vivaolinux.com.br/dica/Inicializar-um-script-automatico-na-inicializacao-do-Linux/  
# @example:
#       bash script-mount-disk.sh --action='add' --param='{"autoInit":true,"initClient":true,"partitions":[{"partition":"/dev/sda2","linkPartition":"/mnt/secondary-system","typePartition":"ntfs"},{"partition":"/dev/sda4","linkPartition":"/mnt/my-documents","typePartition":"ntfs"}]}'
#   OR
#       bash script-mount-disk.sh --action='remove' --param='{}'    
#-------------------------------------------------------------# 

source <(wget --no-cache -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/import.sh"); 

import.ShellScriptTools "/linux/utility.sh";

# @descr: Função principal do script-mount-disk.sh
# @param: 
#    action | text: (install, uninstall)
#    param | json: {"autoInit":true,"initClient":true,"partitions":[{"partition":"...","linkPartition":"...","typePartition":"..."}]}
function ScriptMountDisk {

    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");

    # @descr: Variavel de parametros JSON.
    local PARAM_JSON=$(util.getParameterValue "(--param=|-p=)" "$@");

    local autoInit=$(echo "${PARAM_JSON}" | jq -r '.autoInit');
    local initClient=$(echo "${PARAM_JSON}" | jq -r '.initClient');

    # @descr: Função de criação do script de montagem automatica de partição.
    __add() {
        util.print.info "Iniciando a criação do script de montagem automatica de partição..."; 

        fdisk -l;

        util.print.out '\n%b\n\n' "${B_WHITE}Partições a ser montadas: ${COLOR_OFF}";

        local pathScriptTemp="./binaries/mount-disk-auto.sh";

        touch "${pathScriptTemp}" 
        { 
            echo '#!/bin/bash';
            echo '#';
            echo '#/etc/init.d/mount-disk-auto.sh';
            echo '';
            echo '# Script gerado automaticamente pelo "Garden Of Eden".';
            echo '# Script de montagem de partições automatico na inicialização do sistema.';
            echo '';
            echo '# Especificar o tipo do sistema de arquivos da partição:';
            echo '# vfat - sistema de arquivos do windows FAT32.';
            echo '# ntfs - sistema de arquivos do windows NTFS.';
            echo '# ext2 - sistema de arquivos do linux EXT2.';
            echo '# ext3 - sistema de arquivos do linux EXT3.';
            echo '# ext4 - sistema de arquivos do linux EXT4.';
            echo '';
        } > "${pathScriptTemp}";

        local size=$(echo "${PARAM_JSON}" | jq ".partitions | length"); 
        for (( x=1; x<=$size; x++ )); do
            local index=$(($x-1));
            local partition=$(echo "${PARAM_JSON}" | jq -r ".partitions[${index}].partition"); 
            local linkPartition=$(echo "${PARAM_JSON}" | jq -r ".partitions[${index}].linkPartition"); 
            local typePartition=$(echo "${PARAM_JSON}" | jq -r ".partitions[${index}].typePartition");  
            
            util.print.out '%b\n' "${WHITE}--> Partition.......:${CYAN} '${partition}' ${COLOR_OFF}";
            util.print.out '%b\n' "${WHITE}--> Link Partition..:${CYAN} '${linkPartition}' ${COLOR_OFF}";
            util.print.out '%b\n' "${WHITE}--> Type Partition..:${CYAN} '${typePartition}' ${COLOR_OFF}";
            util.print.out '%b\n' "";

            touch "${pathScriptTemp}" 
            {
                echo '# Criando pasta de ponto de montagem, para tornar acessível uma partição.';
                echo 'mkdir -p "'$linkPartition'";';
                echo '# Montando a partição.';
                echo 'mount -t "'$typePartition'" "'$partition'" "'$linkPartition'"';
                echo '';
            } >> "${pathScriptTemp}";    
        done

        touch "${pathScriptTemp}" 
        { 
            echo 'exit 0;';
        } >> "${pathScriptTemp}";

        chmod -R 777 "${pathScriptTemp}";

        cp "${pathScriptTemp}" "/etc/init.d/";

        chmod +x "/etc/init.d/mount-disk-auto.sh";

        /etc/init.d/mount-disk-auto.sh;

        update-rc.d mount-disk-auto.sh defaults;
    }

    # @descr: Função de remoção do script de montagem automatica de partição.
    __remove() {
        util.print.info "Iniciando a remoção do script de montagem automatica de partição...";

        update-rc.d -f mount-disk-auto.sh remove;

        rm -rf "/etc/init.d/mount-disk-auto.sh"; 
    }

    # @descr: Função é chamada qndo a um erro de tipo de ação.
    # @param: 
    #    action | text: "..." | Action não encontrado.
    __actionError() {
        local actionErr=$(util.getParameterValue "(--action=|-a=)" "$@");
        util.print.error "Erro: 'action' passado:(${actionErr}) não coincide com [add, remove]!";
        return 1;
    } 

    # @descr: Função principal "um construtor por exemplo".
    __initialize() {
        case ${ACTION} in
            add) { 
                __add; 
            };;
            remove) { 
                __remove;
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
util.try; ( ScriptMountDisk "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;