#!/bin/bash

###################  DOC  ###################
# @descr: ...  
# @fonts: ...
# @example: 
#    $ sudo chmod a+x utility.sh
#    $ sudo ./utility.sh
#############################################

function Utility {

    export CURRENT_DATE=`date +%d%m%y`;
    export CURRENT_DATE_TIME=`date +%d%m%y%H%M%S`;

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
    # @font: https://stackoverflow.com/questions/3811345/how-to-pass-all-arguments-passed-to-my-bash-script-to-a-function-of-mine
    # @example:
    #    $ testSetParameters a1 a2 a3;
    function testSetParameters {
        args=("$@")
        echo args: "$@";
        echo Number of arguments: $#;
        echo 1st argument: ${args[0]};
        echo 2nd argument: ${args[1]};
    }

    # @descr: 
    # @font: http://wiki.bash-hackers.org/commands/builtin/printf
    #        https://linuxconfig.org/bash-printf-syntax-basics-with-examples
    #        https://www.vivaolinux.com.br/dica/Conhecendo-o-printf
    #        https://www.computerhope.com/unix/uprintf.htm
    # @example:
    #
    function print.out {
        printf "$@";
    }
    export -f print.out;

    # @descr: 
    # @example:
    #
    function print.notify {
        local length=$((${#1}+2));
        print.out "\n+";
        print.out -- "-%.0s" $(seq 1 $length);
        print.out "+\n| $1 |\n+";
        print.out -- "-%.0s" $(seq 1 $length);
        print.out "+\n\n";
    }
    export -f print.notify;

    # @descr: 
    # @example:
    #
    function msgInfo {
        local message=$1;
        # Text in bold and blue  
        print.out '%b' "\033[1;34m";
        print.notify "${message}";
        print.out '%b' "\033[0m";
    }
    export -f msgInfo;

    # @descr: 
    # @example:
    #
    function msgSuccess {
        local message=$1;
        # Text in bold and green
        print.out '%b' "\033[1;32m";
        print.notify "${message}";
        print.out '%b' "\033[0m";
    }
    export -f msgSuccess;

    # @descr: 
    # @example:
    #
    function msgWarning {
        local message=$1;
        # Text in bold and yellow
        print.out '%b' "\033[1;33m";
        print.notify "${message}";
        print.out '%b' "\033[0m";
    }
    export -f msgWarning;

    # @descr: 
    # @example:
    #
    function msgError {
        local message=$1;
        # Text in bold and red
        print.out '%b' "\033[1;31m";
        print.notify "${message}";
        print.out '%b' "\033[0m";
    }
    export -f msgError;

} 
Utility; #->>> Initializing the Utility;