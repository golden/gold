<a name=top>
<h1 align=center>GOLD: the Gawk Object Layer</h1>
<p  align=center>
<a href="http://github.com/golden/one/master/blob/README.md#top">home</a> :: 
<a href="http://github.com/golden/issues">issues</a> 
</p>

# Objects

- [Type Checking](#type-checking) 
    - [isa(f,a)](#isafa-return-true-if-a-is-an-object-of-type-f-or-any-super-type-of-f). Return true if "a" is an object of type "f", or any super-type of "f".
- [Creation](#creation) 
    - [Object(?a) : create a newlist](#objecta--create-a-newlist) 
- [Composition](#composition) 
    - [has(a,?s,?f = "List") : n](#hasasf--list--n-add-an-object-of-type-f-at-the-key-as). Add an object of type "f" at the key "a[s]"
- [Inheritance](#inheritance) 
    - [is(+a,f)](#isaf-tag-the-object-a-with-the-class-signifier-f). Tag the object "a" with the class signifier "f".
    - [inherit(s,f)](#inheritsf--look-up-the-type-hierarchy-from-s-looking-for-the-method-f). Look up the type hierarchy from "s" looking for the method "f".

## Type Checking
### isa(f,a). Return true if "a" is an object of type "f", or any super-type of "f".
GOLD objects have certain properties:

- They are a list with keys:
  - `ois` (object "is") : a class tag
  - `oid` (object "id") : a unique id number for this object.
- The  class tag is a  known function.
- The keys of this array correspond to the keys and value types 
  of any other "f" thing, (or any of its super types).

```awk
function isa(f,a) {
  if (isarray(a) && "ois" in a && "oid" in a && 
      f==a.ois && a.ois in FUNCTAB) {
       if (GOLD.brave)
         return 1
       else {
         while(f) { 
           if (isa1(f, a)) 
             return 1
           f = GOLD.ois[f] }}}
  return 0
}

function isa1(f,a,   b) { @f(b); return isa2(a,b) }

function isa2(a,b,     j) {
  if (isarray(a) && isarray(b)) {
    for(j in b) 
      if ( ! isa2(a[j], b[j]) ) 
        return 0
  } else {
      if (typeof(a) != typeof(b)) 
        return 0 
  }
  return 1
}
```
## Creation
### Obj(?a) : create a newlist
```awk
function Obj(i)  { 
  List(i); i.ois= "Obj";  i.oid = ++GOLD.oid 
}

function List(i)    { split("",i,"") }
```

Note the "dot notation" (e.g. i.oid) in the `Obj` function. These
are converted into field names of GAWK arrays. Most specifically, the GOLD transpiler
converts all  .md files to .awk files as follows:

        /\.([^0-9\\*\\$\\+])([a-zA-Z0-9_]*)/ ==> "[\"\\1\\2\"]"

For example, after transpiling, the above`Obj` function becomes::

        function Obj(i)  { 
          List(i); i["ois"]= "Obj";  i["oid"]= ++GOLD["oid"] 
        }

GOLD strives to minimize its intrusion to the global space. Hence, all its bookkeeping
is done as fields of the `GOLD` variables.

## Composition
### has(a,?s,?f = "List") : n. Add an object of type "f" at the key "a[s]"
If "s" is omitted, use length of "a"+1 (i.e. push to end of list).
Return the key where we added the new thing.
```awk
function has(i,k,f,   s) { 
  if (!f) f = "List"               # ensure we are creating something
  if (!k) k = length(i)+1          # ensure we have a place to put it
  i[k]["\001"]; delete i[k]["\001"] # ensure we adding to a sulist
  @f(i[k])                         # create
  return k                         # return where we put it
}
```

## Inheritance
### is(+a,f1,?f2). Tag the object "a" with the class tag "f1". Optioanlly, make this a subclass of "f2".
As a side-effect, make a note about what sub-classes are known in this system.
```awk
function is(i,f1,f2) {
  if (f2) @f2(i)
  if ("ois" in i) { GOLD.ois[f1] = i.ois }
  i.ois = f1
}
```

### inherit(s,f).  Look up the type hierarchy from "s" looking for the method "f".
```awk
function inherit(s,f,   g) {
  while(s) {
    g = s f
    if (g in FUNCTAB) return g
    s = GOLD.ois[s] # look upward in the class hierarchy
  }
  print "#E> failed method lookup: ["f"]"
  exit 2
}
```
