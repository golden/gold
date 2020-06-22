#!/usr/bin/env bash

Gold=$(cd $( dirname "${BASH_SOURCE[0]}" ) && pwd )

path=$(dirname $1)
stem=$(basename $1 ".md")
awk=$path/${stem}.awk

(
echo  "#!/usr/bin/env gawk -f"  
echo ""

if [ -f "$Gold/LICENSE.md" ]
then
  cat "$Gold/LICENSE.md" | gawk '
        BEGIN { FS="\n"; RS="" }
        NR==1 && $1~/name=top>/ { next }
              { print ""
                print $0} ' |
  sed 's/^/# /'
fi
echo ""
echo "BEGIN {MAIN=\"" $stem "\"}" 

cat $1 |
gawk \
  -v Path="$path/$stem" -v Stem="$stem" -v Src="$Gold/src" '
BEGIN { 
  inc(Path) 
}
function exists(f,   status) {
  status = getline < f
  status = status >= 0
  close(f)
  return status
}
function find(f,   a,s) {
  s = Src ":" ENVIRON["AWKPATH"]
  split(s, a,":")
  for(j in a) {
    g = a[j] "/" f ".md"
    if (exists(g))
      return g }
} 
function show(g,s, use) {
  if (s ~ /^```awk/) return 1
  if (s ~ /^```/)    return 0
  if (use) 
     print gensub(/\.([^0-9\\*\\$\\+])([a-zA-Z0-9_]*)/,
                  "[\"\\1\\2\"]","g",s);

  return use
}
function inc(f, seen,
            g,i,use,s) {
  if (g = find(f)) {
    if (g in seen) return
    seen[g] 
    s="# -------------------------------------------------"
    printf("\n%s\n# %s\n%s\n",s,f,s)
    while((getline < g) > 0)  {
      if($0 ~ /^@include/) {
        i = $2
        gsub(/[" \t]/,"",i)
        inc(i, seen) 
     } else
       use = show(g, $0,use);
    }
    close(g) }
}

') > $awk

if [ -t 0 ]; then gawk  -f $awk
else      cat - | gawk  -f $awk
fi

