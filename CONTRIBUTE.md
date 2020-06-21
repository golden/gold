<a name=top>
<h1 align=center>GOLD: the Gawk Object Layer</h1>
<p  align=center>
<a href="http://github.com/golden/one/master/blob/README.md#top">home</a> :: 
<a href="http://github.com/golden/issues">issues</a> 
</p>

|Symbol| Type | Meaning                                 |
|------|------|-----------------------------------------|
| s    | atom | string                                  |
| n    |      | number                                  |
| b    |      | a 0,1 variables (which might an empty or non-nil string. |
| x    |      | string or number                        |
|------|------|-----------------------------------------|
| v    | list | vector: a list with all numeric indexes |
| i    |      | a set of all indexes, no values         |
| a    |      | an array. Includes V and S              | 
| +    |      | a list, to be augmented with more keys  |   
| -    |      | an empty list, to be filled in          |
|------|------|-----------------------------------------|
| ?    | meta | optional argument                       |
| : T  |      | some type "T"                           | 
