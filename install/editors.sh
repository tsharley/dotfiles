#!/usr/bin/env bash

cat <<- 'EOF' > ~/.config/nano/nanorc
    set autoindent
    set cutfromcursor
    set emptyline
    set historylog
    set indicator
    set linenumbers
    set locking
    set mouse
    set positionlog
    set softwrap
    set stateflags
    set tabsize 4
    set trimblanks
    set zap
    set titlecolor bold,lightwhite,blue
    set statuscolor bold,lightwhite,magenta
    set errorcolor bold,lightwhite,red
    set selectedcolor lightwhite,cyan
    set stripecolor ,yellow
    set scrollercolor magenta
    set numbercolor cyan
    set keycolor lightmagenta
    set functioncolor green
    bind ^Q exit all
    bind ^S savefile main
    bind ^W writeout main
    bind ^H help all
    bind ^H exit help
    bind ^F whereis all
    bind ^X cut all
    bind ^C copy main
    bind ^V paste all
    #include ~/.config/nano/syntax/*.nanorc
EOF
ln -s ../syntax ~/.config/nano/syntax
