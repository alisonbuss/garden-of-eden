#!/bin/bash

# @descr: URL padrão do "shell_script_tools" do repositorio "https://github.com/alisonbuss/garden-of-eden"
export URL_GARDEN_OF_EDEN="https://raw.githubusercontent.com/alisonbuss/garden-of-eden/master";

# @descr: Importa os shell scripts do repositorio.
# @example:
#
#    import.GardenOfEden "/dist-ubuntu/scripts/script-keyssh.sh";
#
function import.GardenOfEden {
    local shellScript=$1;
    source <(wget -qO- "${URL_GARDEN_OF_EDEN}${shellScript}"); 
} 
export -f import.GardenOfEden;
