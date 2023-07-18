#!/usr/bin/env bash

########################                               ########################
######################    Autoloaded Shell Functions    #######################
########################                               ########################

#------------------------------------------------------------------------------
# COPI_CURL_CERT: View target's SSL certificate and save to file
# Arguments: $1 -> hostname;      Return: Text of certificate and local copy
function copi_curl-cert() {
        openssl s_client -showcerts -connect "${1}":443 -servername ${1} \
    </dev/null 2>/dev/null | openssl x509 -outform PEM | tee ${1}.pem
}

#------------------------------------------------------------------------------
# CURL_CERT: View target's SSL certificate
# Arguments: $1 -> hostname;      Return: Text of certificate (single or chain)
function curl-cert() {
        openssl s_client -showcerts -connect "${1}":443 -servername ${1}
}

#------------------------------------------------------------------------------
# MCD: Make directory, including any intermediate directories, and cd to it
# Arguments: $1 -> dir name/path;        Return: 0
function mcd() {
        mkdir -p "$1"
        cd "$1"
}

#------------------------------------------------------------------------------
# CMX: Make file executable
# Arguments: $1 -> filename;          Return: 0
function cmx() {
    chmod +x "$1"
}

#------------------------------------------------------------------------------
# RAND_UP_TO: Prints a random number between 0 and the argument
# Arguments: $1 -> max of range;          Return: 0
function rand_up_to() {
    _cap=$1
    echo $[${RANDOM}%_cap]     # random between 0-999
}

#------------------------------------------------------------------------------
# SHOUT: Echo with color
# Arguments: $1 -> color, $2 -> characters to echo;          Return: 0
function shout() {
    echo "$fg[$1] $2 $reset_color"
}

#------------------------------------------------------------------------------
# UP: cd up n levels
# Arguments: $1 -> levels (default=1);                                   Return: 0
function up(){
  if [[ "$#" -ne 1 ]]; then
    cd ..
  elif ! [[ $1 =~ '^[0-9]+$' ]]; then
    echo "Error: up should be called with the number of directories to go up. The default is 1."
  else
    local d=""
    limit=$1
    for ((i=1 ; i <= limit ; i++))
      do
        d=$d/..
      done
    d=$(echo $d | sed 's/^\///')
    cd $d
  fi
}

#------------------------------------------------------------------------------
# Start an HTTP server from a directory, optionally specifying the port
function server() {
local port="${1:-8000}";
	sleep 1 && open "http://localhost:${port}/" &
	# Set the default Content-Type to `text/plain` instead of `application/octet-stream`
	# And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
	python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port";
}

#------------------------------------------------------------------------------
# Start a PHP server from a directory, optionally specifying the port
# (Requires PHP 5.4.0+.)
function phpserver() {
	local port="${1:-4000}";
	local ip=$(ipconfig getifaddr en1);
	sleep 1 && open "http://${ip}:${port}/" &
	php -S "${ip}:${port}";
}

#####  TODO:  Past this point are functions I have not yet tested or cleaned up.

# Lists every executable in PATH
#  $ print -l ${^path}/*(-*N)

# recursive chmod
#  $ chmod 700 **/(.) # Only files
#  $ chmod 700 **/(/) # Only directories

#------------------------------------------------------------------------------
# MULTICOLOR: Customize each element of an array with color
# Arguments: $1 -> color, $2 -> characters to echo;          Return: 0
#RunService ()
#{
#    case $1 in
#      start  ) StartService   ;;
#      stop   ) StopService    ;;
#      restart) RestartService ;;
#      *      ) echo "$0: unknown argument: $1";;
#    esac
#}
#
## Remove a trailing pathname component, leaving the head. This works like
## `dirname'.
#  $ echo =ls(:h)
#  /bin
#
## Remove all leading pathname components, leaving the tail. This works
## like `basename'.
#  $ echo =ls(:t)
#  ls
#
## Remove the suffix from each file (*.sh in this example)
#   $f:e is $f file extension
#   :h --> head (dirname)
#   :t --> tail (basename)
#   :r --> rest (extension removed)
#  $ for f (*.sh) mv $f $f:r
#
## Remove a filename extension of the form `.xxx', leaving the root name.
#  $ echo $PWD
#  /usr/src/linux
#  $ echo $PWD:t
#  linux
#
## Remove all but the extension.
#  $ foo=23.42
#  $ echo $foo
#  23.42
#  $ echo $foo:e
#  42
#
## Print the new command but do not execute it. Only works with history
## expansion.
#  $ echo =ls(:h)
#  /bin
#  $ !echo:p
#  $ echo =ls(:h)
#
## Quote the substituted words, escaping further substitutions.
#  $ bar="23'42"
#  $ echo $bar
#  23'42
#  $ echo $bar:q
#  23\'42
#
## Convert the words to all lowercase.
#  $ bar=FOOBAR
#  $ echo $bar
#  FOOBAR
#  $ echo $bar:l
#  foobar
#
## Convert the words to all uppercase.
#  $ bar=foobar
#  $ echo $bar
#  foobar
#  $ echo $bar:u
#  FOOBAR
#
## convert 1st char of a word to uppercase
#  $ foo="one two three four"
#  $ print -r -- "${(C)foo}"
#  One Two Three Four

#------------------------------------------------------------------------------
