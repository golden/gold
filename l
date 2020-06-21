#!/usr/bin/env bash

cat $1 |
gawk '
function ns(n,    s) {
   while(n-- > 0) s= s "    "
   return s
}
function trim(s) {
  gsub(/^[ \t]*/,"",s)
  gsub(/[ \t]*$/,"",s)
  return s
}
function rest(a,  sep,s,i) {
  for(i=2;i<=length(a); i++) {s= s sep a[i]; sep=""}
  return s
}
/^#[#]+[ \t]/ { 
     new = split($1,a,"#") - 3
     s = $0
     gsub(/^[#]+[ \t]*/,"",s) 
     s = trim(s)
     link = s
     gsub(/[^a-zA-Z0-9\- ]/,"",link)
     gsub(/[ \t]/,"-",link)
     split(s,a,/[ \t]*\.[ \t]/)
     left =  trim( a[1] )
     right = trim( rest(a) )
     if (length(a) == 1)
          print ns(new) "- [" left "](#" tolower(link) ") " 
     else print ns(new) "- [" left "](#" tolower(link) "). " right
}
END {print ""}'
