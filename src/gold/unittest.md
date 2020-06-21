<a name=top>
<h1 align=center>GOLD: the Gawk Object Layer</h1>
<p  align=center>
<a href="http://github.com/golden/one/master/blob/README.md#top">home</a> :: 
<a href="http://github.com/golden/issues">issues</a> 
</p>

# Unit Tests

To test a file `x.md`, create a file in
the same directory called `xok.md` that

- Loads the `x.md` file;
- The runs the `tests` function to call a set of test functions...
- ... where each function has a reserved argument `f` ...
- ... and the `ok` tests in each function take two arguments:
  - that `f` variable
  - and a second argument that evaluates to true if

## Top-level Test Driver
### tests(s,s)

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
### :w
ok()

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
