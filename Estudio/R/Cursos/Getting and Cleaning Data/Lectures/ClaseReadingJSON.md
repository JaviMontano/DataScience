Practica
========================================================
Clase: Reading JSON 05/2014
========================================================

Curso: "Getting and Cleaning Data"
========================================================
Programa de Análisis de Datos de la John Hopkins en Coursera
========================================================

JSON refiera a Java Script Object Notation.

Generalmente son archivos de bajo peso frente a la información que contienen.

Su estructura es similar a XML en el sentido de ser estructurado, pero utiliza diferente sintáxis, tipos de datos (no son tags) y formato.

Sirve para almacenar:

- Numeros ("Dobles")
- Textos (En comillas dobles)
- Boleanos (true o false)
- Array (Ordenados, separados por comas y encerrado entre corchetes [])
- Objetos (Desordenados, colección de datos emparejados de llave:valores en llaves {})

El paquete JSON lite
---------------

### Es el recomendado por el instructor.

Las funciones del paquete JSON lite básicas que pueden ser utilizadas.
-----------

### from fromJSON()

Función que interpreta un archivo JSON y lo carga.

```
> library(jsonlite) # Asumiendo que el paquete está instlado
> jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
> names(jsonData)
 [1] "id"                "name"              "full_name"         "owner"            
 [5] "private"           "html_url"          "description"       "fork"             
 [9] "url"               "forks_url"         "keys_url"          "collaborators_url"
[13] "teams_url"         "hooks_url"         "issue_events_url"  "events_url"       
[17] "assignees_url"     "branches_url"      "tags_url"          "blobs_url"        
[21] "git_tags_url"      "git_refs_url"      "trees_url"         "statuses_url"     
[25] "languages_url"     "stargazers_url"    "contributors_url"  "subscribers_url"  
[29] "subscription_url"  "commits_url"       "git_commits_url"   "comments_url"     
[33] "issue_comment_url" "contents_url"      "compare_url"       "merges_url"       
[37] "archive_url"       "downloads_url"     "issues_url"        "pulls_url"        
[41] "milestones_url"    "notifications_url" "labels_url"        "releases_url"     
[45] "created_at"        "updated_at"        "pushed_at"         "git_url"          
[49] "ssh_url"           "clone_url"         "svn_url"           "homepage"         
[53] "size"              "stargazers_count"  "watchers_count"    "language"         
[57] "has_issues"        "has_downloads"     "has_wiki"          "forks_count"      
[61] "mirror_url"        "open_issues_count" "forks"             "open_issues"      
[65] "watchers"          "default_branch"

```

### from toJSON()

La función tojson() interpreta un data.frame y lo convierte a JSON. Utilizando el parametro pretty, lo hace con espaciado uniforme.

```
irisJSON <- toJSON(x=iris,pretty=TRUE)
cat(irisJSON)
[
    {
        &quot;Sepal.Length&quot; : 5.1,
        &quot;Sepal.Width&quot; : 3.5,
        &quot;Petal.Length&quot; : 1.4,
        &quot;Petal.Width&quot; : 0.2,
        &quot;Species&quot; : &quot;setosa&quot;
    },
    {
        &quot;Sepal.Length&quot; : 4.9,
        &quot;Sepal.Width&quot; : 3,
        &quot;Petal.Length&quot; : 1.4,
        &quot;Petal.Width&quot; : 0.2,
        &quot;Species&quot; : &quot;setosa&quot;
    },

```

Explorando el JSON
---------

Una vez cargado el documento se puede explorar los documentos usando el operador $ para explorar dataframes. Una diferencia está dada por la capacidad de explorar según el nivel de anidación.

```
names(jsonData$owner)
 [1] "login"               "id"                  "avatar_url"          "gravatar_id"        
 [5] "url"                 "html_url"            "followers_url"       "following_url"      
 [9] "gists_url"           "starred_url"         "subscriptions_url"   "organizations_url"  
[13] "repos_url"           "events_url"          "received_events_url" "type"               
[17] "site_admin" 
```

```
> jsonData$owner$login
 [1] "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek"
[10] "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek"
[19] "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek"
[28] "jtleek" "jtleek" "jtleek"

```



