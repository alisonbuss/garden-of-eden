#!/bin/bash
#
#/etc/init.d/mount-disk-auto.sh

# Script gerado automaticamente pelo "Garden Of Eden".
# Script de montagem de partições automatico na inicialização do sistema.

# Especificar o tipo do sistema de arquivos da partição:
# vfat - sistema de arquivos do windows FAT32.
# ntfs - sistema de arquivos do windows NTFS.
# ext2 - sistema de arquivos do linux EXT2.
# ext3 - sistema de arquivos do linux EXT3.
# ext4 - sistema de arquivos do linux EXT4.

# Criando pasta de ponto de montagem, para tornar acessível uma partição.
mkdir -p "/mnt/sda2";
# Montando a partição.
mount -t "ntfs" "/dev/sda2" "/mnt/sda2"

# Criando pasta de ponto de montagem, para tornar acessível uma partição.
mkdir -p "/mnt/my-documents";
# Montando a partição.
mount -t "ntfs" "/dev/sda4" "/mnt/my-documents"

exit 0;
