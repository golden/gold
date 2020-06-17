# vim: set nospell ts=2 sw=2 sts=2 expandtab: 

BEGIN { DOT=sprintf("%s",46) }

function List(i) { split("",i,"") }

function Object(i) {
  List(i)
  i.id = ++Id
  i.is = "Object"
}
function is(i,k)          { k=k?k:"Object"; @k(i);       i.is=k }
function isa(i,k,a)       { k=k?k:"Object"; @k(i,a);     i.is=k }
function isab(i,k,a,b)    { k=k?k:"Object"; @k(i,a,b);   i.is=k }
function isabc(i,k,a,b,c) { k=k?k:"Object"; @k(i,a,b,c); i.is=k }

function has( i,k,f)         { f=f?f:"List"; @f(i[k])            }
function hasa(i,k,f,a)       {               @f(i[k],a)          }
function hasab(i,k,f,a,b)    {               @f(i[k],a,b)        }
function hasabc(i,k,f,a,b,c) {               @f(i[k],a,b,c)      }
