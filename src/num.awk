#  vim: set nospell ts=2 sw=2 sts=2 expandtab: 

# Num 

@include "gold.awk" 

function Num(i,pos,txt,w) {
  isa(i,"Num")
  i.w   = i.w ? i.w : 1
  i.hi  = -1e32
  i.lo  =  1e32
  i.mu = i.m2 = i.sd = 0
  return "Num"
}
function NumNorm(i,x) {
  return (x - i.lo)/(i.hi - i.lo + 1e-32)
}
function NumAdd(i,x,          delta) {
  x    += 0
  i.n  += 1
  i.lo  = x < i.lo ? x : i.lo
  i.hi  = x > i.hi ? x : i.hi
  delta = x - i.mu
  i.mu += delta/i.n
  i.m2 += delta*(x - i.mu)
  i.sd = (i.m2/(i.n-0.99999999))^0.5
  return x
}

