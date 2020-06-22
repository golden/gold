```awk
@include "gold/test"

BEGIN {tests("test","_failingTest,_passingTest") }

function _failingTest(f) { ok(f,0==1) }
function _passingTest(f) { 
  ok(f,1==1) 
  ok(f, near(1,1))
  ok(f, near(1,2,2))
  ok(f, within(1,2,3))
  ok(f, GOLD.test.yes > 0)
  ok(f, GOLD.test.no  > 0)
}
```
