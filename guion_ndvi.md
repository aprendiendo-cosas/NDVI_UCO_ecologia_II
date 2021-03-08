# Guión de la práctica "caracterización de cambios temporales en el funcionamiento de ecosistemas Mediterráneos mediante teledetección"


> + **_Versión_**: v.2020-2021
> + **_Asignatura (grado)_**: Ecología II (Biología)
> + **_Autor_**: Curro Bonet-García (fjbonet@uco.es)
> + **_Duración_**: 2,5 horas.



## Objetivos 

 

En esta práctica se plantéan los siguientes objetivos:

+ Disciplinares: Están relacionados con competencias propias de la ecología.
  + Mejorar nuestra comprensión de los conceptos de estructura y funcionamiento en un ecosistema forestal.
  + Conocer el concepto de serie temporal.
  + Relacionar los cambios en la estructura con los cambios en el funcionamiento de un ecosistema.
  + Aprender la utilidad de los índices de vegetación obtenidos mediante satélites para caracterizar la estructura y el funcionamiento de los ecosistemas.
+ Instrumentales: Están relacionados con la adquisición de competencias en el manejo de herramientas potencialmente útiles en ecología y en otros ámbitos.
  + Afianzar los conocimientos ya adquiridos sobre el manejo de SIG y de R.
  + Aprender a caracterizar cuantitativamente una serie temporal de una variable biofísica (índice de vegetación).
  + Aprender a manejar imágenes de satélite para caracterizar el funcionamiento de los ecosistemas.
  + Establecer relaciones entre datos tomados en campo y datos observados vía satélite.

Estos objetivos se abordarán usando como contexto espacial la finca de el Patriarca, donde ya se han realizado otras prácticas de esta asignatura. 



## Introducción: teledetección y ecología

El conjunto de prácticas denominadas "caracterización ecológica del Patriarca" nos permite aplicar una serie de técnicas que son útiles para conocer mejor la estructura (ej. densidad del bosque, diversidad, etc.) y el funcionamiento (ej. tasa de regeneración, descomposición, producción primaria, etc.) del sistema ecológico que hay en esa zona. La información recopilada durante estas prácticas es de gran interés para mejorar la forma en la que los humanos obtenemos servicios de dichos ecosistemas. 

En esta práctica trabajaremos en un aspecto muy importante en los ecosistemas terrestres: la producción primaria. Cuantificaremos cómo se lleva a cabo el proceso de transformación de la materia inorgánica en orgánica a través de la fotosíntesis. Para ello usaremos imágenes procedentes de sensores alojados a bordo de satélites que orbitan alrededor de la Tierra. 

Los satélites pueden detectar y cuantificar la actividad fotosintética porque son sensibles a las longitudes de onda que utilizan las plantas cuando para generar materia orgánica. Cuando una planta está viva y haciendo la fotosíntesis tiene una "firma espectral" determinada. Cuando está muerta o no hace la fotosíntesis tiene otra diferente. Esto se debe a que cuando están haciendo la fotosíntesis son capaces de absorber ciertas bandas del espectro electromagnético (concretamente el rojo). Teniendo en cuenta esto es posible construir índices que cuantifican cómo de intensa es la fotosíntesis en un lugar determinado y en un tiempo concreto. En esta práctica aplicaremos uno de los índices más comunmente utilizados, el NDVI: [Normalized difference vegetation index.](https://en.wikipedia.org/wiki/Normalized_difference_vegetation_index) En concreto en esta ocasión usaremos datos suministrados por un satélite llamado Landsat 7, que pasa por cada punto de la Tierra cada 16 días. Los sensores que tiene este satélite permiten calcular el NDVI en cada pasada. [Landsat 7](https://landsat.gsfc.nasa.gov/landsat-7/ ) se lanzó en 1999 y sigue enviando información en la actualidad. La resolución espacial de esta información es de 30 metros. 

De manera más concreta, durante esta sesión haremos lo siguiente:

+ Generar una gráfica que muestre los cambios del NDVI (y por tanto de la actividad fotosintética) a lo largo del tiempo (desde 1999 a 2018) en cada píxel de 30 m de lado.
+ Cuantificar la tendencia de la serie de NDVI observada la zona de estudio. Analizaremos si cada punto de 30x30 m ha experimentado en el periodo analizado, un aumento de NDVI, un descenso o si se ha mantenido estable. 
+ Obtener un mapa que muestre el NDVI promedio de cada píxel en la zona de estudio. Relacionaremos este valor promedio de NDVI con los datos de densidad del bosque medidos en campo.



[Esta](https://github.com/aprendiendo-cosas/P_NDVI_UCO_ecologia_II/raw/main/presentaciones/teledeteccion.ppt) presentación describe con más detalle los conceptos teóricos que sustentan esta práctica. Y la siguiente figura muestra el resumen de las tareas a abordar.



![resumen](https://github.com/aprendiendo-cosas/P_NDVI_UCO_ecologia_II/raw/main/imagenes/resumen.png)





## Secuencia de acciones a realizar

Para caracterizar la serie temporal de NDVI y para calcular el promedio de los máximos de NDVI daremos los pasos descritos en las siguientes secciones. Pero antes, es importante descargar la información de partida:
  + [Imágenes de NDVI anuales (NDVI_maximo_anual.zip)](https://github.com/aprendiendo-cosas/P_NDVI_UCO_ecologia_II/raw/main/geoinfo/NDVI_maximo_anual.zip). Es un archivo zip. Descomprímelo en la carpeta en la que vayas a trabajar.
  + [Delimitación del Patriarca (patriarca.zip)](https://github.com/aprendiendo-cosas/P_NDVI_UCO_ecologia_II/raw/main/geoinfo/patriarca.zip). Es un fichero de formas poligonal que delimita la finca del Patriarca. Ponlo en la misma carpeta en la que has puesto el resto del material.

### Caracterización de la serie temporal de NDVI

- (0) Este flujo de trabajo está también explicado en [este](https://youtu.be/22dlKcNa_SI) vídeo.
- Ve copiando y pegando el código que aparece abajo en un archivo de R. Para crear dicho archivo haz lo siguiente:
  - Abre Rstudio
  - Dale al botón archivo y crear nuevo archivo de R.
  - Guarda el archivo de R en tu directorio de trabajo.
  - Ve copiando lo que va apareciendo a continuación.
- (1) Primero establecemos el directorio de trabajo. Sustituye lo que hay entre comillas por tu ruta. Para acceder a la ruta, usa tu explorador de archivos, ponte sobre la barra de navegación, botón derecho y copiar ruta en modo texto. 

```{r setup, include=FALSE}
## Definimos directorio de trabajo y cargamos los paquetes necesarios
setwd("/Users/fjbonet_trabajo/Downloads/ndvi")

#Instalar y cargar los paquetes necesarios.
install.packages("Kendall")
install.packages("rgdal")
install.packages("raster")

library(raster)
library(rgdal)
library(Kendall)

```


- (2) Crea una *pila* de archivos que contiene todos los archivos con extensión *.tiff* que estén en tu carpeta de trabajo. Create***** a stack containing all _.tiff_ files created by GEE.

     - Primero creamos una lista con los nombres de todos los archivos con extensión *tif* que hay en tu carpeta de trabajo. Ten cuidado porque si has cargado antes los archivos .tif en QGIS es posible que se hayan creado otros archivos con extensión *.tif.xml*. Estos archivos también serán seleccionados por la función *list.files* que se describe más abajo. Borra o mueve todos los archivos con tiff en el nombre que no sean los que corresponden a las imágenes de NDVI máximo anual. 
     - Luego usamos la función *slack* para crear una pila de archivos con los tif anteriores. Se crea un tipo de objeto llamado [*RasterStack*](https://www.rdocumentation.org/packages/raster/versions/3.0-12/topics/stack). Es una colección de capas raster que tienen la misma extensión y resolución espacial. 
     - Después, usamos la función  _Brick_. Un [Brick](https://www.rdocumentation.org/packages/raster/versions/2.9-23/topics/brick) es una capa multibanda. Es similar al *stack* anterior, pero se procesa más rápidamente en la memoria. 
     - La función *plot* permite representar gráficamente cada una de las bandas contenidas en el objeto creado anteriormente. 
     - Finalmente exportamos el archivo resultante a una imagen *.tif*. Usaremos esta imagen multibanda para crear gráficas de las series temporales de NDVI de cada punto en QGIS. 

 

 ```r
## Empaquetamos todas las imagenes tiff generadas por GEE en una unica imagen multibanda
lista_imagenes <- list.files(pattern='*.tif', full.names=TRUE)
ndvis <- brick(stack(lista_imagenes))
plot(ndvis)


# Exportamos la imagen a tif
writeRaster(ndvis, filename="ndvi_1999_2018.tif", format="GTiff", overwrite=TRUE)

 ```

- (3) Ejecutamos un test estadístico llamado [Mann Kendall](https://www.statisticshowto.datasciencecentral.com/mann-kendall-trend-test/) sobre todas las bandas del objeto multicapa creado anteriormente. Este test permite analizar la evolución temporal de una serie de datos identificando si la tendencia es ascentente o descendente. Es un test no paramétrico, así que puede usarse en todas las distribuciones de datos.  

   - "Encapsulamos" el test estadístico  [Mann Kendall](https://www.rdocumentation.org/packages/Kendall/versions/2.2/topics/MannKendall) en una funciónde R _fun_k_.
   - Luego creamos un nuevo objeto llamado  _kendal_result_ que contiene el resultado de aplicar la función Kendall al conjunto de datos (*ndvis*).
   - El resultado es otro objeto espacial que contiene cinco bandas. Solo prestaremos atención a las siguientes:
     - _tau_= Es el estadístico *tau* del test de Kendall. Contiene la tendencia que el test ha identificado en cada elemento de la serie. Los valores negativos indican que la tendencia es descentente y ascendente si son positivos. Es decir, valores positivos indican que hay una tendencia hacia más NDVI en el pixel en cuestión. 
     - _sl_= Es el p-valor del test. Muesta el valor de significación del test en cada píxel.  
   - Finalmente exportamos la banda *tau* a una imagen llamada *tau.tif*.

 ```r
## Calculamos la serie temporal de todos los pixeles

fun_k <-function(x){return(unlist(MannKendall(x)))}
kendal_result <-calc(ndvis, fun_k)

# Exportamos la tendencia (tau) a un tif
writeRaster(kendal_result$tau, filename="tau.tif", format="GTiff", overwrite=TRUE)
 ```

- (4) Cargamos toda la información en QGIS. Para visualizar la información que hemos generado, procedemos de la siguiente manera.
  - Abrimos un proyecto de QGIS nuevo.
  - En el menú capa seleccionamos la opción de cargar capa raster. Navegamos a la carpeta donde esté la información y seleccionamos las siguientes capas:
    - **ndvi_1999_2018.tif**: Contiene una banda por año. Y cada banda muestra el valor máximo de NDVI de ese año. Usaremos esta capa para construir automáticamente gráficas con las series temporales de cada píxel.
    - **tau.tif**: Contiene los valores de tendencias de NDVI para cada píxel. Una vez cargada hacemos doble click sobre la misma y la representamos usando el método de *singleband pseudocolor* y la paleta *spectral*. Ajusta el valor máximo a 0.99 y haz click en "elimina valores fuera de rango". Por último, le asignamos un grado de transparencia del 50%.
    - **ortofoto reciente**: Cargamos o creamos (Según lo tengas creado o no) un servicio WMS con la ortofotografía más reciente. Si tienes que crearlo, la URL de este servicio es: http://www.ign.es/wms-inspire/pnoa-ma

+ (5) Vamos a construir un gráfico que muestra la tendencia de NDVI para cualquier píxel de la zona de estudio. Sigue estos pasos para ello:

  + Instala un plugin llamado  "_Temporal/Spectral profile tool_". Menu _plugins_->_Manage and install plugins_. La instalación creará un nuevo botón que representa un gráfico rojo. 
  + Selecciona la capa "_ndvi_1999_2020_" en QGIS.
  + Haz click en el botón del plugin que acabas de instalar.
  + Haz click en la pestaña _settings_ que sale abajo y selecciona la opción "Time" del desplegable que hay bajo "X-axis steps". Vamos a hacer que en el eje X de la gráfica aparezcan los años. Pon 1999 en el año de inicio (Time frame start). Luego cambia en el desplegable el "time size frame" y selecciona "year".
  + Haz click en cualquier punto del mapa para que se muestre una imagen como la que ves a continuación. 
  + 



### Cálculo del NDVI promedio.

Esta parte de la práctica tiene una componente experimental. Planteamos la hipótesis de que el valor promedio de los máximos anuales de NDVI es un buen subrogado de la densidad de la vegetación. Se dice que una variable es subrogada de otra cuando la primera explica bien la segunda. Es decir, están correlacionadas. Por ejemplo, cuando subimos una montaña suele bajar la temperatura. Por eso se dice que la altitud es un buen subrogado de la temperatura. Como es más fácil medir la altitud que la temperatura, a veces se usa la segunda para caracterizar la distribución espacial de la primera. En nuestro caso queremos comprobar si el NDVI es un buen subrogado de la densidad del bosque.

Para contrastar nuestra hipótesis nos valdremos de los datos de densidad real tomados en el Patriarca durante la salida de campo. En dicha salida tomamos datos de densidad de varios puntos. En esos puntos tenemos también datos de NDVI, dado que esta información ocupa todo el territorio. Por tanto podemos comparar los valores de densidad real y NDVI de cada punto de muestreo de campo. Y veremos si hay una correlación matemática. Si la hay, podremos decir que, en efecto, el NDVI es un buen subrogado de la densidad. 

Con objeto de testar esta hipótesis haremos lo siguiente:

- (1) Cargamos todas las imágenes con el NDVI máximo anual en QGIS. Para cargar las imágenes, abrimos un proyecto nuevo. Luego, desde el explorador de archivos arrastramos todas las imágenes con extensión *.tif* a la tabla de contenidos de QGIS. Esto hará que aparezcan listadas toas las capas. No necesitamos que se vean con colores 




+ Cálculo del NDVI promedio. Calculadora raster de QGIS.
  + Cargamos todas las imágenes .tif en QGIS.
  + Calculamos el promedio con la calculadora Raster.
  + Creamos una imagen llamada promedio.tif
+ Cálculo de la tendencia. R.





```

## Analisis de la serie temporal de NDVI del norte de Cordoba

## Definimos directorio de trabajo y cargamos los paquetes necesarios
setwd("/Users/fjbonet_trabajo/Google_Drive/4_docencia/eco_II_bio_uco/actos_docentes/P_NDVI_UCO_ecologia_II/preparacion")

install.packages("Kendall")
install.packages("rgdal")
install.packages("raster")

library(raster)
library(rgdal)
library(Kendall)


## Empaquetamos todas las imagenes tiff generadas por GEE en una unica imagen multibanda
lista_imagenes <- list.files(pattern='*.tif', full.names=TRUE)

ndvis <- brick(stack(lista_imagenes))

plot(ndvis)


# Exportamos la imagen a tif
writeRaster(ndvis, filename="ndvi_1999_2018.tif", format="GTiff", overwrite=TRUE)


## Calculamos la serie temporal de todos los pixeles

fun_k <-function(x){return(unlist(MannKendall(x)))}

kendal_result <-calc(ndvis, fun_k)

# Exportamos la tendencia (tau) a un tif

writeRaster(kendal_result$tau, filename="tau.tif", format="GTiff", overwrite=TRUE)





```







 



 

 