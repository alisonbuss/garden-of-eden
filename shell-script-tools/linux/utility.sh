#!/bin/bash

###################  DOC  ###################
# @descr: ...  
# @fonts: ...
# @example: 
#    $ sudo chmod a+x utility.sh
#    $ sudo ./utility.sh
#############################################

export currentDate=`date +%d%m%y`;
export currentDateTime=`date +%d%m%y%H%M%S`;

# @descr: return 1 if global command line program installed, else 0
# @example:
#    if [ `isInstalled "git"` == 1 ]; then
#        echo "Git já está instalanda na maquina...";
#    else
#        echo "Git não está instalanda na maquina...";
#    fi
function isInstalled {
    # set to 1 initially
    local return_=1
    # set to 0 if not found
    type $1 >/dev/null 2>&1 || { local return_=0; }
    # return value
    echo "$return_";
} 
export -f isInstalled;

# @descr: 
# @example:
#    local test=$(ifInline "`isInstalled "git"` == 1" "Git is installed :)" "Git is not installed :(");
#    echo $test;
function ifInline {
    local conditional=$1;
    local conditionalTrue=$2;
    local conditionalFalse=$3;

    if [ $conditional ]; then
        echo $conditionalTrue;
    else
        echo $conditionalFalse;
    fi
}
export -f ifInline;

# @descr: 
# @example:
#
function msgInfo {
    local message=$1;
    # Text in bold and blue  
    echo -e "\033[1;34m${message}\033[0m";
}
export -f msgInfo;

# @descr: 
# @example:
#
function msgSuccess {
    local message=$1;
    # Text in bold and green
    echo -e "\033[1;32m${message}\033[0m";
}
export -f msgSuccess;

# @descr: 
# @example:
#
function msgWarning {
    local message=$1;
    # Text in bold and yellow
    echo -e "\033[1;33m${message}\033[0m";
}
export -f msgWarning;

# @descr: 
# @example:
#
function msgError {
    local message=$1;
    # Text in bold and red
    echo -e "\033[1;31m${message}\033[0m";
}
export -f msgError;