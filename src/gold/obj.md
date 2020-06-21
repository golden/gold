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
## Creation
### Object(?a) : create a newlist
```awk
function Object(i)  { 
  List(i); i.ois= "Object";  i.oid = ++GOLD.oid 
}

function List(i)    { split("",i,"") }
```

Note the "dot notation" (e.g. i.oid) in the `Object` function. These
are converted into field names of GAWK arrays. Most specifically, the GOLD transpiler
converts all  .md files to .awk files as follows:

        /\.([^0-9\\*\\$\\+])([a-zA-Z0-9_]*)/ ==> "[\"\\1\\2\"]"

For example, after transpiling, the above`Object` function becomes::

        function Object(i)  { 
          List(i); i["ois"]= "Object";  i["oid"]= ++GOLD["oid"] 
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
### is(+a,f). Tag the object "a" with the class signifier "f".
As a side-effect, make a note about what sub-classes are known in this system.
```awk
function is(i,f) {
  if ("ois" in i) { GOLD.ois[f] = i.ois }
  i.ois = f
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
