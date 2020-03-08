function List(i) { 
  split("",i,"") 
}
function T(i) {
  List(i)
  i.id = ++Id
  i.is = "Object"
}
function is(i,k)             { k=k?k:"T"; &k(i);       i.is=k }
function isa(i,k,a)          { k=k?k:"T"; &k(i,a);     i.is=k }
function isab(i,k,a,b)       { k=k?k:"T"; &k(i,a,b);   i.is=k }
function isabc(i,k,a,b,c)    { k=k?k:"T"; &k(i,a,b,c); i.is=k }

function has( i,k,f)         { f=f?f:"List"; @f(i[k])         }
function hasa(i,k,f,a)       {               @f(i[k],a)       }
function hasab(i,k,f,a,b)    {               @f(i[k],a,b)     }
function hasabc(i,k,f,a,b,c) {               @f(i[k],a,b,c)   }

function isa(i,x) {
}
  &x(i)
function isaa(i,x, y) {


function oo(i) {
  for(j in i) print j " " i[j] 
}
