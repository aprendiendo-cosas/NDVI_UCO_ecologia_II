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



(esto está todavía incompleto)



+ Descarga la siguiente información:
  + [Imágenes de NDVI anuales](https://github.com/aprendiendo-cosas/P_NDVI_UCO_ecologia_II/raw/main/geoinfo/NDVI_maximo_anual.zip). Es un archivo zip. Descomprímelo en la carpeta en la que vayas a trabajar.
  + [Proyecto de QGIS](https://github.com/aprendiendo-cosas/P_NDVI_UCO_ecologia_II/raw/main/geoinfo/ortofotos_wms.qgs.zip) con conexiones a servicios web de ortofotos. Ponlo en la misma carpeta en la que están las otras imágenes.
  + [Delimitación del Patriarca](https://github.com/aprendiendo-cosas/P_NDVI_UCO_ecologia_II/raw/main/geoinfo/patriarca.zip). Es un fichero de formas poligonal que delimita la finca del Patriarca. Ponlo en la misma carpeta en la que has puesto el resto del material.
+ Cálculo del NDVI promedio. Calculadora raster de QGIS.
+ Cálculo de la tendencia. R.

 



 

 