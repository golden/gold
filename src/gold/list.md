<a name=top>
<h1 align=center>GOLD: the Gawk Object Layer</h1>
<p  align=center>
<a href="http://github.com/golden/one/master/blob/README.md#top">home</a> :: 
<a href="http://github.com/golden/issues">issues</a> 
</p>

# List

- [Update](#update) 
    - [push(+a,x) : n](#pushax--n--push-a-value-to-end-of-list). Push a value to end of list
- [Random items from list](#random-items-from-list) 
    - [anyi(A) : n](#anyia--n--return-a-random-number-for-1-to-size-of-a). Return a random number for 1 to size of "A"
    - [any(V) : x](#anyv--x-any-item-from-a-vector-v). Any item from a vector "V"
    - [anys(S) : x](#anyss--x-any-item-from-a-set-s). Any item from a set "S"
    - [nanys(S) : n](#nanyss--n--any-numeric-item-from-a-set-s). Any numeric item from a set "S".
    - [copy(A1, -A2)](#copya1--a2-recursively-copy-array-a1-to-a2). Recursively copy array "A1" to "A2".
- [Print list](#print-list) 
    - [o(A) : s](#oa--s--return-a-string-of-keyitem-pairs). Return a string of key,item pairs
    - [oo(A, s)](#ooa-s-recursively-print-an-array-a-prefixed-by-s). Recursively print an array "A", prefixed by "s"
- [Sort a list](#sort-a-list) 
    - [keysort(A,s)](#keysortas-sort-an-array-a-using-the-field-s). Sort an array "a", using the field "s".

## Update

### push(+a,x) : n.  Push a value to end of list
Returns the pushed item.
```awk
function push(a,x) { a[ length(a)+1 ] = x; return x; }
```

## Random items from list

### anyi(v) : n.  Return a random number for 1 to size of "v"
```awk
function anyi(v)  { return 1+int(rand()*length(v))  }
```

### any(v) : x. Any item from a vector "v"
```awk
function any(v)   { return v[ anyi(v) ] }
```

### anys(l) : x. Any item from a list of indexes "l"
Note: takes time linear on length of set.
```awk
function anys(l, n,k){
  n = 1/length(l) 
  for(x in l) if (rand() < n) return x
  return x ## make sure something gets returned
}
```

### nanys(l) : n.  Any numeric item from a list of indexes "l".
```awk
function nanys(s) { return 0+anys(s) }
```

### copy(a1, -a2). Recursively copy array "a1" to "a2".
```awk
function copy(a, b,     i){
  for (i in a) {
    if(isarray(a[i])) {
      b[i][0]        # ensure nested list exists
      delete b[i][0] 
      copy(a[i], b[i])
    } else 
      b[i] = a[i] 
}}
```      
## Print list
### o(a) : s.  Return a string of key,item pairs 
Convert a flat array to a string. Not suitable for nested arrays.

```awk
function o(a,     sep,    sep1,i,s) {
  for(i in a) {
    s    = s sep1 a[i]
    sep1 = sep ? sep : ", " }
  return s 
}
```      
### oo(a, s). Recursively print an array "A", prefixed by "s"
Print a nested array, optionally with some `prefix`.
Print keys in sorted order.

```awk
function oo(a,prefix,    indent,   i,txt) {
  txt = indent ? indent : (prefix GOLD["dot"] )
  if (!isarray(a)) {print(a); return a}
  ooSortOrder(a)
  for(i in a)  {
    if (isarray(a[i]))   {
      print(txt i"" )
      oo(a[i],"","|  " indent)
    } else
      print(txt i (a[i]==""?"": ": " a[i])) }
}

function ooSortOrder(a, i) {
  for (i in a)
   return PROCINFO["sorted_in"] =\
     typeof(i+1)=="number" ? "@ind_num_asc" : "@ind_str_asc"
}
```

## Sort a list
### keysort(a,s). Sort an array "a", using the field "s". 
Returns the length of the list.
```awk
function keysort(a,k) {
  GOLD.keysort = k
  return asort(a,a,"keysorter")
}

function keysorter(i1,x,i2,y) {
  return compare(x[ GOLD.keysort ] + 0,
                 y[ GOLD.keysort ] + 0)
} 

function compare(x,y) {
  if (x < y) return -1
  if (x == y) return 0
  return 1
}
```
