<a name=top>
<h1 align=center>GOLD: the Gawk Object Layer</h1>
<p  align=center>
[home](http://github.com/golden/gold/master/blob/README.md) :: 
[issues](http://github.com/golden/gold/isses) 
</p>

# Objects

GAWK functions process  a limited number of types

- `a` : any string
- `$a` : a numeric
- `?a` : a boolean, which can be 0/1 or empty/non-empty string.
- `[x]` : a list
- `-[x] : an list that will be fully reset within a function
- `+[x] : an list that will be augmented within this function

GOLD adds user objects; i.e. lists with slots for:

- `ois` (object "is") : a class signifier
- `oid` (object "id") : a unique id number for this object.

The simplest such user object is `Object`:

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
