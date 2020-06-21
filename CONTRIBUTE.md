<a name=top>
<h1 align=center>GOLD: the Gawk Object Layer</h1>
<p  align=center>
<a href="http://github.com/golden/one/master/blob/README.md#top">home</a> :: 
<a href="http://github.com/golden/issues">issues</a> 
</p>

Anything:

|Symbol| Meaning                                 |
|------|-----------------------------------------|
| y    | anything: atoms, lists, whatever        |

Atoms:

|Symbol| Meaning                                 |
|------|-----------------------------------------|
| x    | any atom : a string or number  or x     |
| s    | string                                  |
| n    | number                                  |
| b    | a 0,1 variables (which might an empty or non-nil string. |


Lists:

|Symbol| Meaning                                 |
|------|-----------------------------------------|
| a    | any list: vectors, indexes, other       |
| v    | vector: a list with all numeric indexes |
| i    | a list of all indexes, no values        |

Meta:

|Symbol| Meaning                                 |
|------|-----------------------------------------|
| +    | a list, to be augmented with more keys  |   
| -    | an empty list, to be filled in          |
| ?    | optional argument                       |
| : T  | some type "T"                           | 


