Lectura
========================================================
Libro: Learning R
========================================================

Capítulo 2: "A scientific calculator"
========================================================


Anotaciones 2/3
========================================================

Probando el Operador los operadores lógicos
-------------------------

El operador == sirve para verificar la igualdad entre dos enteros. Al igual que los demás operadores es un operador vectorizado. El opuesto de == que se lee "igual que", es != que signficia "diferente de".

Los operadores "mayor que", >, "menor qué", < y sus combinaciones "mayor/menor que o igual", >=, <= están igualmente permitidas. 

Todos estos, pueden ser usados para comparar textos además de lo mostrado con números.


```r
c(3, 4 - 1, 1 + 1 + 1) == 3  # Validaciones veraderas
```

```
## [1] TRUE TRUE TRUE
```

```r

1:3 != 3:1  # Validaciones mixtas
```

```
## [1]  TRUE FALSE  TRUE
```

```r

(1:5)^2 >= 16  # Validaciones falsas
```

```
## [1] FALSE FALSE FALSE  TRUE  TRUE
```

```r
c("Can", "you", "can", "a", "can", "as", "a", "canner", "can", "can", "a", "can?") == 
    "can"
```

```
##  [1] FALSE FALSE  TRUE FALSE  TRUE FALSE FALSE FALSE  TRUE  TRUE FALSE
## [12] FALSE
```


Nota aclaratoria (Citando al libro) 
-------------------------
Tener en cuenta si la precisión es crítica con números muy pequeños
-------------------------

```
Comparing nonintegers using == is problematic. All the numbers we have dealt with so far are floating point numbers. That means that they are stored in the form a * 2 ^ b, for two numbers a and b. Since this whole form has to be stored in 32 bits, the resulting number is only an approximation of what you really want. This means that rounding errors often creep into calculations, and the answers you expected can be wildly wrong. Whole books have been written on this subject; there is too much to worry about here. Since this is such a common mistake, the FAQ on R has an entry about it, and its a good place to start if you want to know more.

Consider these two numbers, which should be the same:

sqrt(2) ^ 2 == 2 #sqrt is the square-root function
## [1] FALSE
sqrt(2) ^ 2 - 2 #this small value is the rounding error
## [1] 4.441e-16

R also provides the function all.equal for checking equality of numbers. This provides a tolerance level (by default, about 1.5e-8), so that rounding errors less than the tolerance are ignored

all.equal(sqrt(2) ^ 2, 2)
## [1] TRUE
If the values to be compared are not the same, all.equal returns a report on the differences.
If you require a TRUE or FALSE value, then you need to wrap the call to
all.equal in a call to isTRUE:

all.equal(sqrt(2) ^ 2, 3)
## [1] "Mean relative difference: 0.5"
isTRUE(all.equal(sqrt(2) ^ 2, 3))
## [1] FALSE

````




