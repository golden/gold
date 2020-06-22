<a name=top>
<h1 align=center>GOLD: the Gawk Object Layer</h1>
<p  align=center>
<a href="http://github.com/golden/one/master/blob/README.md#top">home</a> :: 
<a href="http://github.com/golden/issues">issues</a> 
</p>

## Variables

All local variables in functions
should start with lower case.

## Types versus Constructors

Types `T` are created by a function that accepts
one argument `i`; i.e. `T(i)`.

Constructors are functions with more than one
argument that handle side-effects after type
creation. Typically, constructors start by
calling `T(i)`,  then adjust the variables
withing `i`.

## Signatures

Anything:

|Symbol| Meaning                                 |
|------|:----------------------------------------|
| y    | anything: atoms, lists, whatever        |

Atoms:

|Symbol| Meaning                                 |
|------|:----------------------------------------|
| x    | any atom : a string or number or x or f |
| s    | string                                  |
| f    | something to be called as an indirect function |
| n    | number                                  |
| b    | a 0,1 variables (which might an empty or non-nil string. |


Lists:

|Symbol| Meaning                                 |
|------|:----------------------------------------|
| a    | any list: vectors, indexes, other       |
| v    | vector: a list with all numeric indexes |
| l    | a list of all indexes, no values        |
| i    | object (a.k.a. "self" or "this")        |

Meta:

|Symbol| Meaning                                 |
|------|:----------------------------------------|
| +    | a list, to be augmented with more keys  |   
| -    | an empty list, to be filled in          |
| =    | set a default value                     |
| ?    | optional argument                       |
| : T  | some type "T"                           | 


