```awk
@include "gold/test"
@include "gold/list"

BEGIN { tests("list", "_list") }

function _list(f, v,n,  n2,bad) {
  v[1]=1
  for(n=2;n<=20;n++)
    push(v,n)
  ok(f, length(v) == 20)
  ok(f, v[2] = 2)
  for(n=1; n<=1000; n++) {
    n2 = anyi(v)
    bad += ( ! ( n2>=1 && n2<= length(v)))
  } 
  ok(f, bad== 0)
}
```
