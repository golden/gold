<a name=top>
<h1 align=center>GOLD: the Gawk Object Layer</h1>
<p  align=center>
[home](http://github.com/golden/gold/master/blob/README.md) :: 
[issues](http://github.com/golden/gold/isses) 
</p>

# Lib :o:

- [Maths](#maths) 
- [Lists](#lists) 
    - [copy()](#copy) 
    - [o()](#o) 
    - [oo()](#oo) 
    - [keysort()](#keysort) 
- [Unit tests](#unit-tests) 
    - [tests()](#tests) 
    - [ok()](#ok) 
    - [near()](#near) 
    - [within()](#within) 
    - [rogues()](#rogues) 
- [Input](#input) 
    - [csv()](#csv) 
    - [Row()](#row) 

        GOLD.dot    = sprintf("%c",46)
        GOLD.up     = GOLD.dot GOLD.dot
}

```awk
@include "gold/const"
@include "gold/math"

## Maths

```awk
function abs(x)  { return x>=0 ? x : -1*x }
```
## Lists

`push` to a list.

```awk
function push(a,x) { return a[ length(a)+1 ] = x; }
```

Get a random item from a list

```awk
function anyi(a)  { return 1+int(rand()*length(a))  }
function any(a)   { return a[ anyi(a) ] }
function nanys(s) { return 0+anys(s) }
function anys(s, n,k){
  n = 1/length(s) 
  for(k in s) if (rand() < n) return k
  return k ## make sure something gets returned
}
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

## Unit tests

### tests()

Top level unit-test driver.  Resets the random number generator
before each test.  Prints the group and name of the test.
Warns about stray globals at the end.

```awk
function tests(what, all,   f,a,i,n) {
  n = split(all,a,",")
  print "\n#--- " what " -----------------------"
  for(i=1;i<=n;i++) { 
    srand(1)
    f = a[i]; 
    @f(f) 
  }
  rogues()
}
```
### ok()

Report the `yes` or `no` message if a test passes or fails.
Increments the global `test.yes` and `test.no` counters.

```awk
function ok(f,yes,    msg) {
  msg = yes ? "PASSED!" : "FAILED!"
  if (yes) 
     GOLD.test.yes++ 
  else
     GOLD.test.no++;
  print "#test:\t" msg "\t" f
}
```
### near()

Return true if what you `got` is within `epsilon` of
what you `want` (`epsilon` defaults to 0.001).

```awk
function near(got,want,     epsilon) {
   epsilon = epsilon ? epsilon : 0.001
   return abs(want - got)/(want + 10^-32)  < epsilon
}
```
### within()

Return true if what you `got` is within 
`lo` to `hi`.

```awk
function within(got,lo,hi) { 
   return  got >= lo && got <= hi
}
```
### rogues()

Report variables that have escaped from functions.

```awk
function rogues(    s) {
  for(s in SYMTAB) 
    if (s ~ /^[A-Z][a-z]/) 
      print "#W> Global " s>"/dev/stderr"
  for(s in SYMTAB) 
    if (s ~ /^[_a-z]/    ) 
      print "#W> Rogue: " s>"/dev/stderr"
}
```
