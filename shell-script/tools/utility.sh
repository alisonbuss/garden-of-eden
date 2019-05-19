#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de utilitarios para shell script. 
# @example:
#       bash utility.sh 
#   OR
#       source <("utility.sh ");
#-------------------------------------------------------------#

# @descr: variavel de data e data com hora 
export CURRENT_DATE=`date +%d%m%y`;
export CURRENT_DATE_TIME=`date +%d%m%y%H%M%S`;

# @descr: output color of print in Linux
# @fonts: https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
# @example:
#       util.print.out '%b\n' "$BLACK TESTE... $COLOR_OFF";
#       util.print.out '%b\n' "$RED TESTE... $COLOR_OFF";
#       util.print.out '%b\n' "$GREEN TESTE... $COLOR_OFF";
#       util.print.out '%b\n' "$YELLOW TESTE... $COLOR_OFF";
#       util.print.out '%b\n' "$BLUE TESTE... $COLOR_OFF";
#       util.print.out '%b\n' "$PURPLE TESTE... $COLOR_OFF";
#       util.print.out '%b\n' "$CYAN TESTE... $COLOR_OFF";
#       util.print.out '%b\n' "$WHITE TESTE... $COLOR_OFF";
#
export COLOR_OFF='\033[0m';       # Text Reset
# Regular Colors
export BLACK='\033[0;30m';        # Black
export RED='\033[0;31m';          # Red
export GREEN='\033[0;32m';        # Green
export YELLOW='\033[0;33m';       # Yellow
export BLUE='\033[0;34m';         # Blue
export PURPLE='\033[0;35m';       # Purple
export CYAN='\033[0;36m';         # Cyan
export WHITE='\033[0;37m';        # White
# Bold
export B_BLACK='\033[1;30m';      # Bold Black
export B_RED='\033[1;31m';        # Bold Red
export B_GREEN='\033[1;32m';      # Bold Green
export B_YELLOW='\033[1;33m';     # Bold Yellow
export B_BLUE='\033[1;34m';       # Bold Blue
export B_PURPLE='\033[1;35m';     # Bold Purple
export B_CYAN='\033[1;36m';       # Bold Cyan
export B_WHITE='\033[1;37m';      # Bold White
# Underline
export U_BLACK='\033[4;30m';      # Underline Black
export U_RED='\033[4;31m';        # Underline Red
export U_GREEN='\033[4;32m';      # Underline Green
export U_YELLOW='\033[4;33m';     # Underline Yellow
export U_BLUE='\033[4;34m';       # Underline Blue
export U_PURPLE='\033[4;35m';     # Underline Purple
export U_CYAN='\033[4;36m';       # Underline Cyan
export U_WHITE='\033[4;37m';      # Underline White
# Background
export ON_BLACK='\033[40m';       # Background Black
export ON_RED='\033[0;101m';      # Background Red
export ON_GREEN='\033[0;102m';    # Background Green
export ON_YELLOW='\033[0;103m';   # Background Yellow
export ON_BLUE='\033[44m';        # Background Blue
export ON_BLUE1='\033[0;104m';    # Background Blue 1
export ON_PURPLE='\033[45m';      # Background Purple
export ON_PURPLE1='\033[0;105m';  # Background Purple 1
export ON_CYAN='\033[46m';        # Background Cyan
export ON_CYAN1='\033[0;106m';    # Background Cyan 1
export ON_WHITE='\033[47m';       # Background White


# @descr: return 1 if global command line program installed, else 0
# @example:
#    if [ `util.isInstalled "git"` == 1 ]; then
#        echo "Git já está instalanda na maquina...";
#    else
#        echo "Git não está instalanda na maquina...";
#    fi
function util.isInstalled {
    # set to 1 initially
    local _return=1;
    # set to 0 if not found
    type $1 >/dev/null 2>&1 || { local _return=0; }
    # return value
    echo "$_return";
} 
export -f util.isInstalled;

# @descr: 
# @example:
#    local test=$(ifInline "`isInstalled "git"` == 1" "Git is installed :)" "Git is not installed :(");
#    echo $test;
function util.ifInline {
    local conditional=$1;
    local conditionalTrue=$2;
    local conditionalFalse=$3;

    if [ $conditional ]; then
        echo $conditionalTrue;
    else
        echo $conditionalFalse;
    fi
}
export -f util.ifInline;

# @descr: 
# @fonts: http://wiki.bash-hackers.org/commands/builtin/printf
#         https://linuxconfig.org/bash-printf-syntax-basics-with-examples
#         https://www.vivaolinux.com.br/dica/Conhecendo-o-printf
#         https://www.computerhope.com/unix/uprintf.htm
#         https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
# @example:
#
function util.print.out {
    printf "$@";
}
export -f util.print.out;

# @descr: 
# @example:
#
function util.print.notify {
    local length=$((${#1}+2));
    util.print.out "\n+";
    util.print.out -- "-%.0s" $(seq 1 $length);
    util.print.out "+\n| $1 |\n+";
    util.print.out -- "-%.0s" $(seq 1 $length);
    util.print.out "+\n\n";
}
export -f util.print.notify;

# @descr: 
# @example:
#
function util.print.info {
    local message=$1;
    # Text in bold and blue  
    util.print.out '%b' "\033[1;34m";
    util.print.notify "ℹ️ ${message}";
    util.print.out '%b' "\033[0m";
}
export -f util.print.info;

# @descr: 
# @example:
#
function util.print.success {
    local message=$1;
    # Text in bold and green
    util.print.out '%b' "\033[1;32m";
    util.print.notify "✔  ${message}";
    util.print.out '%b' "\033[0m";
}
export -f util.print.success;

# @descr: 
# @example:  
#
function util.print.warning {
    local message=$1; 
    # Text in bold and yellow
    util.print.out '%b' "\033[1;33m";
    util.print.notify "➜  ${message}";
    util.print.out '%b' "\033[0m";
}
export -f util.print.warning;

# @descr: 
# @example:
#
function util.print.error {
    local message=$1;
    # Text in bold and red
    util.print.out '%b' "\033[1;31m";
    util.print.notify "🔥  ${message}";
    util.print.out '%b' "\033[0m";
}
export -f util.print.error;

# @descr: 
# @fonts: https://stackoverflow.com/questions/22009364/is-there-a-try-catch-command-in-bash
# @example:
#
function util.try() {
    [[ $- = *e* ]]; SAVED_OPT_E=$?;
    set +e;
}
export -f util.try;

# @descr: 
# @example:
#
function util.throw() {
    exit $1;
}
export -f util.throw;

# @descr: 
# @example:
#
function util.catch() {
    # Set code the exception.
    export exception=$?;
    (( $SAVED_OPT_E )) && set +e;
    return $exception;
}
export -f util.catch;

# @descr: 
# @example:
#
function util.throwErrors() {
    set -e
}
export -f util.throwErrors;

# @descr: 
# @example:
#
function util.ignoreErrors() {
    set +e
}
export -f util.ignoreErrors;

# @descr: Função simples para verificar o código de resposta http antes de baixar um arquivo remoto.
# @fonts: https://gist.github.com/hrwgc/7455343
# @example:
#    local isValidUrl=$(util.validateURL "https://www.gogle.com.hell/");    
#    if [ "${isValidUrl}" == "true" ]; then 
#        echo "Valid URL!";
#    else 
#        echo "Invalid URL!";
#    fi
function util.validateURL(){
    if [[ `wget -S --spider "$1" 2>&1 | grep 'HTTP/1.1 200 OK'` ]]; then 
        echo "true";
    else 
        echo "false";
    fi
}
export -f util.validateURL;

# @descr: Função simples para verificar se o arquivo existe.
# @fonts: https://stackoverflow.com/questions/638975/how-do-i-tell-if-a-regular-file-does-not-exist-in-bash
#         https://www.cyberciti.biz/faq/unix-linux-test-existence-of-file-in-bash/
# @example:
#    local isValidPath=$(util.validateFilePath "~/file.txt");    
#    if [ "${isValidPath}" == "true" ]; then 
#        echo "Valid Path!";
#    else 
#        echo "Invalid Path!";
#    fi
function util.validateFilePath(){
    local file="$1";
    if [[ -e "${file}" ]]; then 
        echo "true";
    else 
        echo "false";
    fi
}
export -f util.validateFilePath;

# @descr:
# @example:
#    $ util.executeBash "./script.sh"
function util.executeBash(){
    local scriptPath="$1";
    local isValidPath=$(util.validateFilePath "${scriptPath}");
    if [ "${isValidPath}" == "true" ]; then           
        local params=("$@");
        bash "${scriptPath}" "${params[@]:1:$#}";
        return $?;
    else 
        util.print.out '%b\n' "${RED}--> Error: Invalid Path! ${B_RED}'$1' ${COLOR_OFF}";
        return 1;
    fi
    return 0;
}
export -f util.executeBash;

# @descr:
# @example:
#    $ util.importSourceCloud "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/src/linux/utility.sh"
function util.importSourceCloud(){
    local url="$1";
    local isValidUrl=$(util.validateURL "$url");
    if [ "${isValidUrl}" == "true" ]; then 
        #source <(curl -H "Cache-Control: no-cache" "$url");
        source <(wget --no-cache -qO- "${url}");
    else 
        util.print.out '%b\n' "$RED--> Error: Invalid URL! $B_RED'$1' $COLOR_OFF";
        return 1;
    fi
    return 0;
}
export -f util.importSourceCloud;

# @descr:
# @example:
#    $ util.executeBashCloud "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/src/linux/utility.sh"
function util.executeBashCloud(){
    local url="$1";
    local isValidUrl=$(util.validateURL "$url");
    if [ "${isValidUrl}" == "true" ]; then            
        local params=("$@");
        #curl -H "Cache-Control: no-cache" "$url" | bash -s "${params[@]:1:$#}";
        wget --no-cache -qO- "$url" | bash -s - "${params[@]:1:$#}";
        return $?;
    else 
        util.print.out '%b\n' "$RED--> Error: Invalid URL! $B_RED'$1' $COLOR_OFF";
        return 1;
    fi
    return 0;
}
export -f util.executeBashCloud;

# @descr:
# @fonts: https://www.digitalocean.com/community/tutorials/using-grep-regular-expressions-to-search-for-text-patterns-in-linux
# @example:
#    $ util.getParameterValue "(--param3=|-p3=)" "$@"
function util.getParameterValue(){
    local exp=$1;
    local params=("$@");
    local valueEnd="";
    for value in "${params[@]:1:$#}"; do
        if grep -E -q "${exp}" <<< "${value}"; then
            valueEnd="${value#*=}";
            break;
        fi        
    done
    echo $valueEnd;
}
export -f util.getParameterValue;
