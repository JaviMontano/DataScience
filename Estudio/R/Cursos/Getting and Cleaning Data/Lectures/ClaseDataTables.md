Practica
========================================================
Clase: Reading DataTables 05/2014
========================================================

Curso: "Getting and Cleaning Data"
========================================================
Programa de Análisis de Datos de la John Hopkins en Coursera
========================================================


Utilizar la información en R con funciones escritas en C, por lo que son más rápidas.

El paquete Data Table
------------------

El paquete fue escrito en C y ha demostrado ser mucho más eficiente para la ejecución de ciertas tareas, de manera especial para realizar filtros, grupos (agrupamientos) entre varios cálculos.

```
> library(data.table) # Asumiendo que el paquete fue instalado correctamente
> DF = data.frame(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
> head(DF,3)
          x y           z
1 0.8458746 a -0.05059749
2 0.4456808 a -0.51280434
3 1.8164608 a  0.63592681

> DT = data.table(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
> head(DT,3)
             x y          z
1:  0.18934421 a  0.2314946
2:  0.75691644 a -0.5226971
3: -0.04592483 a  1.7968805

```
Con el código anterior se declaró a DT, tomando los datos de un data frames, como tabla. Veamos:

```
> tables()
     NAME NROW MB COLS  KEY
[1,] DT      9 1  x,y,z    
Total: 1MB

```
Filtrando en Tablas
------------------

Para filtrar se utilizan los operadores [] pero de manera(s) diferente(s) a los dataframes.

```
> DT[2,] # Filtrar la segunda columna de la tabla
           x y          z
1: 0.7569164 a -0.5226971
> DT[DT$y=="a",] # Filtrar la columna "y" donde los elementos son iguales que "a"
             x y          z
1:  0.18934421 a  0.2314946
2:  0.75691644 a -0.5226971
3: -0.04592483 a  1.7968805

```
El filtro usando sólo un índice es basado en selección de filas. "Rowbased"

```
> DT[c(2,3)]
           x y          z
1: 2.2599195 a -0.9796584
2: 0.2276369 a  0.4690074

```
Intentar filtrar por columnas como en el dataframe, no funciona, pues realmente funciona diferente.

En las DT todo lo que va después de la coma (por ejemplo: DT[,lo-que-sea]) es una expresión. Las expresiones son un grupo de declaraciones entre llaves. {}

Las expresiones en los DT sirven para resumir grupos de datos.

```
> DT[,list(mean(x),sum(z))] # Genera el promedio de X y la sumatoria de Z. Los muestra ordenadamente en dos columnas, para esto, las expresiones se unen en una lista.

          V1        V2
1: 0.4051781 -4.050779

> DT[,table(y)] # Genera un resumen de los datos que contiene el campo Y
y
a b c 
3 3 3 

```
Otra cosa que se hace muy rápidamente, es agregar columnas.

```
> DT[,w:=z^2] # Crea la nueva columna, creando un campo calculado.
> DT
              x y          z         w
1:  0.571448027 a -1.2162079 1.4791617
2:  2.259919486 a -0.9796584 0.9597305
3:  0.227636869 a  0.4690074 0.2199680
4: -0.638341813 b -2.4511098 6.0079395
5:  0.231304528 b -1.4863269 2.2091675
6: -0.284364769 b  0.7950608 0.6321217
7: -0.005913955 c -0.7871268 0.6195686
8:  1.642346665 c  0.3585890 0.1285860
9: -0.357432442 c  1.2469941 1.5549942

```
### Ojo
Crear un DT copiando el contenido de otro DT debe hacerse con cautela. Veamos lo que ocurre:

````
> DT2 <- DT # Definimos DT2 como DT1
> DT[,Y:=2] # En DT creamos la columna Y (mayúscula) con muchos 2 en su contenido
> DT2 # Se evidencia que recibió los valores de Y igual a 2
              x y          z         w Y
1:  0.571448027 a -1.2162079 1.4791617 2
2:  2.259919486 a -0.9796584 0.9597305 2
3:  0.227636869 a  0.4690074 0.2199680 2
4: -0.638341813 b -2.4511098 6.0079395 2
5:  0.231304528 b -1.4863269 2.2091675 2
6: -0.284364769 b  0.7950608 0.6321217 2
7: -0.005913955 c -0.7871268 0.6195686 2
8:  1.642346665 c  0.3585890 0.1285860 2
9: -0.357432442 c  1.2469941 1.5549942 2

```
Queda claro que debe usarse la función copy() para hacer una copia.

Pueden realizarse múltiples operaciones

```
> DT[,m:={tmp<-(x+z);log2(tmp+5)}]# Se genera una expresión extensa para definir m
> DT
              x y          z         w Y
1:  0.571448027 a -1.2162079 1.4791617 2
2:  2.259919486 a -0.9796584 0.9597305 2
3:  0.227636869 a  0.4690074 0.2199680 2
4: -0.638341813 b -2.4511098 6.0079395 2
5:  0.231304528 b -1.4863269 2.2091675 2
6: -0.284364769 b  0.7950608 0.6321217 2
7: -0.005913955 c -0.7871268 0.6195686 2
8:  1.642346665 c  0.3585890 0.1285860 2
9: -0.357432442 c  1.2469941 1.5549942 2
           m
1: 2.1227523
2: 2.6508245
3: 2.5101123
4: 0.9339868
5: 1.9049571
6: 2.4622345
7: 2.0727778
8: 2.8075477
9: 2.5581603
```

También pueden presentarse operaciones tipo plyr.

Se plantea el hecho de evaluar si x es mayor que cero. Después de eso, se plantea que cuando eso sea cierto, se asigne en una nueva columna, el promedio de los valores que cumplen la condición. De igual forma hacer el mismo procedimiento para los falsos.

```
> DT[,a:=x>0] # Crea una variable a, que identifica si x es mayor o no a 0.

> DT
              x y          z         w Y
1:  0.571448027 a -1.2162079 1.4791617 2
2:  2.259919486 a -0.9796584 0.9597305 2
3:  0.227636869 a  0.4690074 0.2199680 2
4: -0.638341813 b -2.4511098 6.0079395 2
5:  0.231304528 b -1.4863269 2.2091675 2
6: -0.284364769 b  0.7950608 0.6321217 2
7: -0.005913955 c -0.7871268 0.6195686 2
8:  1.642346665 c  0.3585890 0.1285860 2
9: -0.357432442 c  1.2469941 1.5549942 2
           m     a
1: 2.1227523  TRUE
2: 2.6508245  TRUE
3: 2.5101123  TRUE
4: 0.9339868 FALSE
5: 1.9049571  TRUE
6: 2.4622345 FALSE
7: 2.0727778 FALSE
8: 2.8075477  TRUE
9: 2.5581603 FALSE

> DT[,b:= mean(x+w),by=a] # Genera el promedio de todos los x+y cuando, a es TRUE, se lo asigna a su posición en b. Hace lo mismo con los falsos.

> DT
              x y          z         w Y
1:  0.571448027 a -1.2162079 1.4791617 2
2:  2.259919486 a -0.9796584 0.9597305 2
3:  0.227636869 a  0.4690074 0.2199680 2
4: -0.638341813 b -2.4511098 6.0079395 2
5:  0.231304528 b -1.4863269 2.2091675 2
6: -0.284364769 b  0.7950608 0.6321217 2
7: -0.005913955 c -0.7871268 0.6195686 2
8:  1.642346665 c  0.3585890 0.1285860 2
9: -0.357432442 c  1.2469941 1.5549942 2
           m     a        b
1: 2.1227523  TRUE 1.985854
2: 2.6508245  TRUE 1.985854
3: 2.5101123  TRUE 1.985854
4: 0.9339868 FALSE 1.882143
5: 1.9049571  TRUE 1.985854
6: 2.4622345 FALSE 1.882143
7: 2.0727778 FALSE 1.882143
8: 2.8075477  TRUE 1.985854
9: 2.5581603 FALSE 1.882143

```
### Variables especiales

.N un entero que contiene el número r. Sirve para contar cuántos de algún valor se dan.

```
> set.seed(123);
> DT <- data.table(x=sample(letters[1:3],1E5,TRUE))
> DT[,.N,by=x]
   x     N
1: a 33387
2: c 33201
3: b 33412
````
### Llaves primarias

Veamos el code:

````
> DT <- data.table(x=rep(c("a","b","c"),each=100),y=rnorm(300))
> setkey[DT,x]
> DT['a']
     x             y
  1: a  0.3065846792
  2: a  0.3227435073
  3: a  1.3660792972
  4: a -0.5888163026
  5: a  1.6978318646
  6: a  0.0563632681
  7: a -0.0995934650
  8: a -0.2101989963
  ...
  
```
Teniendo una tabla dada, la función setkey sirve para establecer un campo como llave primaria. Esto es útil para establecer relaciones.

````
> DT1 <- data.table(x=c('a', 'a', 'b', 'dt1'), y=1:4)
> DT2 <- data.table(x=c('a', 'b', 'dt2'), z=5:7)
> setkey(DT1, x); setkey(DT2, x)
> merge(DT1, DT2)
   x y z
1: a 1 5
2: a 2 5
3: b 3 6

```
Con lo anterior se han combinado las tablas.

Como último paso de la lección, tenemos la evaluación del tiempo transcurrido.
 Así:
 
```
> big_df <- data.frame(x=rnorm(1E6), y=rnorm(1E6))
> file <- tempfile()
> write.table(big_df, file=file, row.names=FALSE, col.names=TRUE, sep="\t", quote=FALSE)
> system.time(fread(file))
   user  system elapsed 
   1.31    0.01    1.32 
> system.time(read.table(file, header=TRUE, sep="\t"))
   user  system elapsed 
  11.06    0.00   11.07 

```
Se logra ver una diferencia de casi diez veces del tiempo!
