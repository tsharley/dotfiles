#!/usr/bin/env bash

pathmaker() {
  paths=(
    ~/.local/bin
    /usr/local/sbin
    /usr/local/bin
    /usr/sbin
    /usr/bin
    /sbin
    /bin
    )

test=""
  for d in ${paths[@]}; do
    test="$d:$test"
  done
  echo $test
}

#pathmaker
#echo $test
export PATH=~/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
