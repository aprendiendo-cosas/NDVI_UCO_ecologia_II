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
  + Proyecto de QGIS con conexiones a servicios web de ortofotos.

 

 

+ hilo argumental
  + actividad fotosintética como subrogado del funcionamiento ecosistémico. Y también como subrogado de la densidad de productores primarios.
  + Vamos a trabajar con estos dos conceptos.
  + Generalidades de teledetección.
  + Definición de NDVI.
  + Zona de estudio.
  + construcción de una gráfica con la serie temporal de ndvi usando o bien la app de GEE o bien el plugin de QGIS.
  + Analizamos ecológicamente esa gráfica. Y vemos dos componentes.
    + NDVI promedio por píxel: ¿buen estimador de la densidad del bosque?
    + Tendencia de NDVI. indicador de hacia dónde se desarrollará el bosque.
  + cálculo del ndvi promedio en toda la serie temporal: calculadora de mapas.
  + Cálculo de la tendencia NDVI: Man Kendall en R
  + Análisis de resultados:
    + Zonas con alta biomasa y tendencia hacia menos NDVI. Decaimiento forestal
    + Tendencias muy negativas o muy positivas: comparar con ortofotos. Relación estructura- funcionamiento.
  + ejercicios:
    + el que ya hay: busca dos puntos e interpreta su evolución.
    + relaciona el NDVI promedio de la serie con la densidad calculada en campo. Recta de regresióin.



 

 

El flujo de trabajo que aplicaremos consta de los siguientes pasos:



\3.   Importaremos las imágenes anteriores con RStudio y generaremos el primer producto de esta práctica: una imagen en formato tif con 18 bandas cada una de las cuales corresponde a un año de la serie temporal analizada. Esta imagen será visualizada con Quantum GIS y con un complemento especial que nos permitirá obtener una gráfica con la serie temporal de NDVI para cada punto de la imagen. Esto se puede ver en [este](https://www.youtube.com/watch?v=22dlKcNa_SI&feature=youtu.be) video.

\4.   A partir de las imágenes anteriores se realizará un análisis de la tendencia de la serie temporal en cada píxel. Para ellos se aplicará la técnica de MannKendall utilizando RStudio. La técnica de MannKendall permite estimar la tendencia de una serie temporal, obteniéndose en este caso una nueva capa con el valor de dicha tendencia. Los valores cercanos a 1 indicarán tendencias positivas (más NDVI) y los cercanos a -1 tendencias negativas (menos NDVI). Para saber más de Man-Kendall puedes mirar [esta](https://cran.r-project.org/web/packages/Kendall/Kendall.pdf) web.

\5.   Los resultados obtenidos (gráficas con la serie temporal de cada punto más mapa de tendencias generado por RStudio) nos permitirán conocer un poco mejor cómo ha evolucionado la actividad fotosintética de la vegetación en la zona de estudio. 

\6.   Para visualizar la tendencia en el NDVI usaremos lo siguiente:

·    El mapa de tendencias descrito anteriormente mostrará en una gama de colores las tendencias más positivas y más negativas en el NDVI.

·    Además, mediante un complemento de QGIS podremos ver una gráfica con los valores de NDVI de cada punto de la zona de estudio. El complemento se llama "Temporal/Spectral Profile Tool Plugin"

 

 

## Material a entregar

 

·    Encontrar un punto en la zona de estudio amplia (Patriarca + Sierra) en la que haya una tendencia negativa o positiva en el funcionamiento de la vegetación y que dicho comportamiento pueda interpretarse fácilmente a través de cambios en la estructura de la vegetación. Es decir, que la tendencia de NDVI se corresponda con alteraciones estructurales en el ecosistema que puedas identificar mediante las distintas ortofotos. Ej. Tendencia de NDVI negativa en lugares donde en alguna ortofoto se vean síntomas de un incendio forestal.

·    ¿Qué tienes que entregar? Pegar en un Word un pantallazo de dicha zona que contenga:

o  Tendencia según Mann Kendall (vista en QGIS)

o  Ortofoto reciente (Para ello deberás de poner la capa anterior con cierta transparencia)

o  Gráfica con la serie temporal de NDVI (según el complemento 

o  Breve texto (un párrafo) explicativo.

 

 