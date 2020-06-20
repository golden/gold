#!/usr/bin/env bash

Gold=$(cd $( dirname "${BASH_SOURCE[0]}" ) && pwd )

F=$Gold/README.md
if [ -f "$f" ]; then
  cat $f| gawk '
     BEGIN { FS="\n"; RS="" } 
           { print; exit 0  }'  
fi
