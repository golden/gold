<a name=top>
<h1 align=center>GOLD: the Gawk Object Layer</h1>
<p  align=center>
[home](http://github.com/golden/gold/master/blob/README.md) :: 
[issues](http://github.com/golden/gold/isses) 
</p>

# About
GAWK is  GNU Awk (and "awk" is short for its creators: Alfred Aho, Peter Weinberger, and Brian Kernighan).
GAWK is a very portable and succinct scripting language. 

GAWK has some shortcomings: e.g. weak encapsulation and packaging support, no IDE or unit testing framework,
    and not document generation tools. 
But that is all easily fixed with a few small scripts (written in, you guessed it, GAWK):

- GOLD is an object layer that extends GAWK with objects, aggregation, polymorphism and inheritance. 
- GOLDMINE are some data mining tools written in GOLD.
- GOLDSTAR are a set of data mining fairness assurance operators. 
- GOLDEN is a cross-platform development environment for the above,  based on bash, vim and tmux. 
  You do not need to use it to run GOLD code but, FYI,
  a session in GOLDEN looks like this:

<p align=center><a href="https://github.com/golden/dev/blob/master/etc/img/screen.png"><img src="https://github.com/golden/dev/blob/master/etc/img/screen.png" width=900></a></p>



- To write GOLD files, use a `*.md` extension
and store your code in  awk "fence blocks"; e.g.

    ```awk
    code
    ```

- To write unit tests for a file `x.md`, create a file that includes it called
`xok.md`.
- To run GOLD, you need five files 
  `g,o,l,d,en` 
and a set of libraries (found in `./src/gold/*`).  To get these files, use the [INSTALL](INSTALL.md) instructions.


## GOLDEN = g, o, l, d, en

<table>
<tr><td>COMMAND </td><td> NOTES</tr>
<tr><td>`g`  </td><td> The GOLD transpiler. <<ul> <li>Converts all src/*.md to *.awk files.<li> Recursive expand the `@include` commands with the contents of those files.<li> Add executable line `#!/usr/bin/env gawk -f` to top of file.<li> Tell the file was the top level files (using `BEGIN {TOP=FILENAME}`.<li>Change the  file's mode with `chmod +x`.<li> Runs the resulting
.awk</ul></tr>
<tr><td>`o`  </td><td> Overlay<br> Lists the header file in root README.md<br> Useful while editing `*.md` file to  add a standard header.</td></tr>
<tr><td> `l` </td><td> Lists the markdown headers in this file.<br> Useful while editing `*.md` file to  add a table of contents. </td></tr>
<tr><td> `d` </td><td> Demos <br> run all the `src/i*ok.md` files</td></tr>
<tr><td> `en`  </td><td>  Environment tricks.<br> `en -i` is the base install that ensure there  exists the `g,o,l,d,en` files (and they are executable) and that the `./src/gold/\*` files exist (which stores the core GOLD files).If they don't exist, they are copied down from the web.<p> 

Note that, in the above, "ensure exists" means that missing files
will be downloaded but existing files will not be overwritten. This means that
if you do any local config, those changes are safe.


dd`en -O`  runs `o` recursively on all `./src/*.md` files (to give everyone the same look and feel).</td>>/tr>
