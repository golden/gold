<a name=top>
<h1 align=center>GOLD: the Gawk Object Layer</h1>
<p  align=center>
[home](http://github.com/golden/gold/master/blob/README.md) :: 
[issues](http://github.com/golden/gold/isses) 
</p>

# Polymorphism

```awk
function add(i,x,    f) { f=i.ois "Add";   return @f(i,x)  }
function dec(i,x,    f) { f=i.ois "Dec";   return @f(i,x)  }
function show(i,     f) { f=i.ois "Show";  return @f(i)    }
function doing(i,    f) { f=i.ois "Doing"; return @f(i)    }
function score(i,    f) { f=i.ois "Score"; return @f(i)    }
function dist(i,x,y, f) { f=i.ois "Dist";  return @f(i,x,y)}
function merge(i,j,  f) { f=i.ois "Merge"; return @f(i,j) }
function filled(i,x,y, f) { f=i.ois "Filled"; return @f(i,x,y) }
function mayMerge(i,a,b,c,d,e,  f) { f=i.ois "MayMerge";  return @f(i,a,b,c,d,e) }
```
