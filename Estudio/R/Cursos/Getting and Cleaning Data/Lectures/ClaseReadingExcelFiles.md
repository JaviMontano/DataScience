Practica
========================================================
Clase: Reading Files from Excel 05/2014
========================================================

Curso: "Getting and Cleaning Data"
========================================================
Programa de Análisis de Datos de la John Hopkins en Coursera
========================================================

En esta lección se pretende trabajar la carga de documentos de excel a R.

Una vez más debe cargarse datos de la base de datos de las cámaras de velocidad de la ciudad de Baltimore. Solo que ahora el enlace, será el de la URL del archivo xlsx, de excel.



```r
if (!file.exists("data")) {
    dir.create("data")
}
# Si el directorio 'data' no existía, se ha creado
if (!file.exists("data/cameras.xlsx")) {
    FileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"  #Llena la variable con la URL de descarga
    download.file(url = FileUrl, destfile = "./data/cameras.xlsx")  #,method= 'curl') #Descarga los datos (el fichero)
}
```

```
## Error: esquema de URL sin soporte
```

```r
# Si el archivo 'cameras.xlsx' no existe, lo descarga method='curl' debe
# agregarse en algunos OS Aparentemente la función download file, puede
# fallar con algunos ficheros de excel, en ese caso tratar de bajar
# manualmente y continuar con la lección es ideal.

DateDownloaded <- date()

DateDownloaded
```

```
## [1] "Mon May 12 22:06:15 2014"
```


Librería xlsx
-------------------------


```r
library(xlsx)  # asumiendo que la librería xlsx ya está instalada
```

```
## Loading required package: rJava
## Loading required package: xlsxjars
```


La librería xlsx requiere además tener otras librerías y cargarlas, entre ellas rJava. Que requiere que el JRE esté funcionando e instalado correctamente.

### Función read.xlsx()


```r
cameraData <- read.xlsx(file = "./data/cameras.xlsx", sheetIndex = 1, header = TRUE)
```

```
## Error: Cannot find ./data/cameras.xlsx
```

```r
head(cameraData)
```

```
## Error: error in evaluating the argument 'x' in selecting a method for function 'head': Error: objeto 'cameraData' no encontrado
```

````
                         address direction      street  crossStreet
1       S CATON AVE & BENSON AVE       N/B   Caton Ave   Benson Ave
2       S CATON AVE & BENSON AVE       S/B   Caton Ave   Benson Ave
3 WILKENS AVE & PINE HEIGHTS AVE       E/B Wilkens Ave Pine Heights
4        THE ALAMEDA & E 33RD ST       S/B The Alameda      33rd St
5        E 33RD ST & THE ALAMEDA       E/B      E 33rd  The Alameda
6        ERDMAN AVE & N MACON ST       E/B      Erdman     Macon St
                intersection                      Location.1
1     Caton Ave & Benson Ave (39.2693779962, -76.6688185297)
2     Caton Ave & Benson Ave (39.2693157898, -76.6689698176)
3 Wilkens Ave & Pine Heights  (39.2720252302, -76.676960806)
4     The Alameda  & 33rd St (39.3285013141, -76.5953545714)
5      E 33rd  & The Alameda (39.3283410623, -76.5953594625)
6         Erdman  & Macon St (39.3068045671, -76.5593167803)
````
## Otros usos

```
colIndex <- 2:3
rowIndex <- 1:4
cameraDataSubset <- read.xlsx(file= "./data/cameras.xlsx",sheetIndex= 1,header=TRUE, colIndex= colIndex,rowIndex= rowIndex)
cameraDataSubset
 direction      street
1       N/B   Caton Ave
2       S/B   Caton Ave
3       E/B Wilkens Ave
````
### Función write.xlsx

Es capaz de crear un archivo de excel reescribe el archivo de excel con atributos similares.

### read.xlsx2()

Es similar a read.xlsx pero mucho más rápida, sin embargo para filtrar resulta inestable.


Librería XLConnect
-------------------------

Mayores opciones para el trabajo con archivos de excel

