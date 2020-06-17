# vim: set nospell ts=2 sw=2 sts=2 expandtab: 

@include "object.awk"

function abs(x) {return x<0? -1*x : x }

function oo(x,p,pre, i,txt) {
  txt = pre ? pre : (p DOT)
  ooSortOrder(x)
  for(i in x)  {
    if (isarray(x[i]))   {
      print(txt i"" )
      oo(x[i],"","|  " pre)
    } else
      print(txt i (x[i]==""?"": ": " x[i]))
}}
function ooSortOrder(x, i) {
  for (i in x)
    return PROCINFO["sorted_in"] = \
      typeof(i + 1)=="number" ? "@ind_num_asc" : "@ind_str_asc" 
}


