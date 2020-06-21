<a name=top>
<h1 align=center>GOLD: the Gawk Object Layer</h1>
<p  align=center>
<a href="http://github.com/golden/one/master/blob/README.md#top">home</a> :: 
<a href="http://github.com/golden/issues">issues</a> 
</p>


# List

- [Update](#update) : 
    - [push(a,x)](#pushax--push-a-value-to-end-of-list) : push a value to end of list
- [Random items from list](#random-items-from-list) : 
    - [anyi(a)](#anyia--random-index) : random index
    - [any(v)](#anyv---any-item-from-a-vector) : any item from a vector
    - [anys(s)](#anyss---any-item-from-a-set) : any item from a set
    - [nanys(s)](#nanyss-any-numeric-item-fro-a-set) : any numeric item fro a set
    - [copy(a, b)](#copya-b--recursively-copy-array-a-to-b) : recursively copy array a to b
- [Print list](#print-list) : 
    - [o(a)](#oa--return-a-string-of-keyitem-pairs) : return a string of key,item pairs
    - [oo(a, s)](#ooa-s--recursively-print-an-array-prefixed-by-s) : recursively print an array, prefixed by "s"
- [Sort a list](#sort-a-list) : 
    - [keysort(a,s)](#keysortas--sort-an-array-a-using-the-field-s) : sort an array "a", using the field "s".

## Update

### push(+a,x):n.  Push a value to end of list
Returns the pushed item.
```awk
function push(a,x) { a[ length(a)+1 ] = x; return x; }
```

## Random items from list

### anyi(A):n.  random index 
Get a random number 1 to size of `A`.
```awk
function anyi(a)  { return 1+int(rand()*length(a))  }
```

### any(V):x. Any item from a vector
```awk
function any(v)   { return v[ anyi(v) ] }
```

### anys(S):x. Any item from a set
Note: takes time linear on length of set.
```awk
function anys(s, n,k){
  n = 1/length(s) 
  for(x in s) if (rand() < n) return x
  return x ## make sure something gets returned
}
```

### nanys(S):n.  Any numeric item from a set
```awk
function nanys(s) { return 0+anys(s) }
```

### copy(A1, -A2). Recursively copy array a to b
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
### o(A):s.  Return a string of key,item pairs 
Convert a flat array to a string. Not suitable for nested arrays.

```awk
function o(a,     sep,    sep1,i,s) {
  for(i in a) {
    s    = s sep1 a[i]
    sep1 = sep ? sep : ", " }
  return s 
}
```      
### oo(A, s) : recursively print an array, prefixed by "s"
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
### keysort(A,s) : sort an array "a", using the field "s". 
Usage: `keysort(+a, s): n`    
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
