<a name=top>
<h1 align=center>GOLD: the Gawk Object Layer</h1>
<p  align=center>
<a href="http://github.com/golden/one/master/blob/README.md#top">home</a> :: 
<a href="http://github.com/golden/issues">issues</a> 
</p>

# Objects

## isa(f,a). Return true if "a" is an object of type "f", or any super-type of "f".
GOLD objects have certain properties:

- They are a list with keys:
  - `ois` (object "is") : a class signifier
  - `oid` (object "id") : a unique id number for this object.
- The  class signifier is a  known function.
- The keys of this array correspond to the keys and value types 
  of any other "f" thing, (or any of its super types).

```awk
function isa(f,a) {
  if ( ! isarray(a)         ) return 0
  if ( ! ("ois" in a)       ) return 0 
  if ( ! ("oid" in a)       ) return 0 
  if ( f != a.ois           ) return 0
  if ( ! (a.ois in FUNCTAB) ) return 0
  if ( ! (f     in FUNCTAB) ) return 0
  while(f) { 
    if (isa1(f, a)) return 1
    f = GOLD.ois[f]
  }
  return 0
}

function isa1(f,a,   b) { @f(b); return isa2(a,b) }

function isa2(a,b,     j) {
  if (isarray(a) && isarray(b)) {
    for(j in a) 
      if ( ! isa2(a[j], b[j]) ) return 0
  } else
      if ( typeof(a) != typeof(b) ) return 0;
  return 1
}
```
```awk
function List(i)    { split("",i,"") }
function Object(i)  { List(i); i.ois= "Object";  i.oid = ++GOLD.oid }
```

Note the "dot notation" (e.g. i.oid) in the `Object` function. These
are converted into field names of GAWK arrays. Most specifically, the GOLD transpiler
converts all  .md files to .awk files as follows:

     /\.([^0-9\\*\\$\\+])([a-zA-Z0-9_]*)/ ==> "[\"\\1\\2\"]"

For example, after transpiling, the `Object` function becomes::

    function Object(i)  { List(i); i["ois"]= "Object";  i["oid"]= ++GOLD["oid"] }

Notes:
- GOLD strives to minimize its intrusion to the global space. Hence, all its bookkeeping
  is done as fields of the `GOLD` variables.
- The GOLD transpiler generates stand-alone GAWK files. Apart from the above
  transpiling, GOLD will:
  - Recursively include the text of any `@include` files
  - Add the "she-bang" line to line1 (`#/usr/bin/env gawk -f `cre

 internal represetnation fo the
Note the "dot notation" (e.g. i.oid) in the `Object` functionn

function has(i,k,f, s) { i
   if (!f) f = "List"               # ensure we are creating something
   if (!k) k = length(i)+1          # ensure we have a place to put it
   i[k]["\001"]; delete i[k]["\001] # ensure we adding to a sulist
   @f(i[k])                         # create
   return k                         # return where we put it
}

function inherit(k,f,   g) {
  while(k) {
    g = k f
    if (g in FUNCTAB) return g
    k = GOLD.ois[k]
  }
  print "#E> failed method lookup: ["f"]"
  exit 2
}
function is(i,x) {
  if ("ois" in i) { GOLD.ois[x] = iois }
  i.ois = x
}
```
