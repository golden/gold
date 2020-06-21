
# List

## Update

### push : push a value to end of list
Usage: `push(+a,x) : n`  
Returns the pushed item.
```awk
function push(a,x) { a[ length(a)+1 ] = x; return x; }
```

## Random items from list

### anyi : random index 
Usage: `anyi(a) : n`   	
Get a random number 1 to size of `a`.
```awk
function anyi(a)  { return 1+int(rand()*length(a))  }
```

### any :  any item from a vector
Usage: `any(v) : x`
```awk
function any(v)   { return v[ anyi(v) ] }
```

### anys :  any item from a set
Usage: `anys(s) : x`   
Note: takes time linear on length of set.
```awk
function anys(s, n,k){
  n = 1/length(s) 
  for(x in s) if (rand() < n) return x
  return x ## make sure something gets returned
}
```

### nanys: any numberic item fro a set
Usage: `nanys(s) : n`
```awk
function nanys(s) { return 0+anys(s) }
```
### copy() : deep copy

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
### o()

Convert a flat array to a string.

```awk
function o(a,     sep,    sep1,i,s) {
  for(i in a) {
    s    = s sep1 a[i]
    sep1 = sep ? sep : ", " }
  return s 
}
```      
### oo()

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

### keysort()

Some nested array `a` by some field `k`.

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


