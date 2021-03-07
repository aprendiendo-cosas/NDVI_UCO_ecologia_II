# Guión de la práctica "caracterización de cambios temporales en el funcionamiento de ecosistemas mediterráneos mediante teledetección"


> + **_Versión_**: v.2019-2020
> + **_Asignatura (grado)_**: Ecología II (Biología)
> + **_Autor_**: Curro Bonet-García (fjbonet@uco.es)
> + **_Duración_**: Dos horas.



## Introducción y objetivos 

 

Los mapas de vegetación nos ayudan a comprender cómo cambia la estructura (vertical y horizontal) de la vegetación. Pero dichos mapas no informan del estado de las funciones ecológicas clave para el mantenimiento de los ecosistemas terrestres. La teledetección es una disciplina que aporta multitud de métodos para cuantificar funciones ecosistémicas.

 

En esta práctica aprenderemos alguna de las técnicas aportadas por la teledetección para cuantificar la producción primaria de los sistemas terrestres. El objetivo general es entrar en contacto con la teledetección y comprobar de manera somera sus potencialidades. Los objetivos específicos son:

 

·    Aprender conceptos generales de teledetección.

·    Conocer el concepto de índice de vegetación y sus implicaciones ecológicas

·    Familiarizarse con herramientas útiles para el manejo de información procedente de satélites: Google Earth Engine, Rstudio

·    Conocer las tendencias de cambio en el funcionamiento de los ecosistemas de la zona de estudio.

 

 

 

***Plan de trabajo y fuentes de datos a utilizar\***

 

Para satisfacer los objetivos anteriores se realizará una sesión práctica de dos horas y media en la sala de ordenadores. 

 

Durante esta sesión evaluaremos cómo ha cambiado la actividad fotosintética de la vegetación en una zona del norte de la ciudad de Córdoba. Para ello utilizaremos un índice de vegetación llamado NDVI (Normalized Differece Vegetation Index) que se puede obtener a partir de imágenes de satélite. En concreto generaremos dos tipos de productos:

·    Gráficas mostrando las series temporales de actividad fotosintética (NDVI) de todos los puntos de la zona de estudio.

·    Análisis de la tendencia existente en la serie temporal anterior. Es decir, evaluaremos si, en cada píxel, hay una tendencia hacia más actividad fotosintética o hacia menos. 

Todo esto se realizará utilizando las imágenes del satélite Landsat 7, que pasa por cada punto de la Tierra cada 16 días. Los sensores que tiene este satélite permiten calcular el NDVI en cada pasada. Landsat 7 se lanzó en 1999 y sigue enviando información en la actualidad. Sin embargo sufrió un problema en su lanzamiento que hace que sus imágenes arrastren un error que produce un "bandeado". Estos problemas no son importantes para los objetivos de esta práctica. Aquí hay más información sobre este producto: https://landsat.gsfc.nasa.gov/landsat-7/ y https://explorer.earthengine.google.com/#detail/LANDSAT%2FLE07%2FC01%2FT1_SR

 

 

El flujo de trabajo que aplicaremos consta de los siguientes pasos:

\1.   Generar una imagen NDVI para cada una de las imágenes de Landsat 7 en nuestra zona de estudio. Esto se realizará con Google Earth Engine (ver [este](https://www.youtube.com/watch?v=QkD8kDF2vkg&feature=youtu.be) video para aprender el procedimiento)

\2.   Calcular una única imagen de NDVI anual que contenga el valor máximo de cada píxel en el año seleccionado. Como trabajaremos con imágenes desde 1999 hasta 2017 obtendremos 18 imágenes en este paso. Esta operación también se realizara con Google Earth Engine (también se puede ver en el video anterior).

\3.   (Aviso para que no cunda el pánico: **De aquí hacia abajo lo hará solo el profesor. Vosotros solo miraréis**). Importaremos las imágenes anteriores con RStudio y generaremos el primer producto de esta práctica: una imagen en formato tif con 18 bandas cada una de las cuales corresponde a un año de la serie temporal analizada. Esta imagen será visualizada con Quantum GIS y con un complemento especial que nos permitirá obtener una gráfica con la serie temporal de NDVI para cada punto de la imagen. Esto se puede ver en [este](https://www.youtube.com/watch?v=22dlKcNa_SI&feature=youtu.be) video.

\4.   A partir de las imágenes anteriores se realizará un análisis de la tendencia de la serie temporal en cada píxel. Para ellos se aplicará la técnica de MannKendall utilizando RStudio. La técnica de MannKendall permite estimar la tendencia de una serie temporal, obteniéndose en este caso una nueva capa con el valor de dicha tendencia. Los valores cercanos a 1 indicarán tendencias positivas (más NDVI) y los cercanos a -1 tendencias negativas (menos NDVI). Para saber más de Man-Kendall puedes mirar [esta](https://cran.r-project.org/web/packages/Kendall/Kendall.pdf) web.

\5.   Los resultados obtenidos (gráficas con la serie temporal de cada punto más mapa de tendencias generado por RStudio) nos permitirán conocer un poco mejor cómo ha evolucionado la actividad fotosintética de la vegetación en la zona de estudio. 

\6.   Para visualizar la tendencia en el NDVI usaremos lo siguiente:

·    El mapa de tendencias descrito anteriormente mostrará en una gama de colores las tendencias más positivas y más negativas en el NDVI.

·    Además, mediante un complemento de QGIS podremos ver una gráfica con los valores de NDVI de cada punto de la zona de estudio. El complemento se llama "Temporal/Spectral Profile Tool Plugin"

 

 

***Material a entregar\***

 

·    Encontrar un punto en la zona de estudio amplia (Patriarca + Sierra) en la que haya una tendencia negativa o positiva en el funcionamiento de la vegetación y que dicho comportamiento pueda interpretarse fácilmente a través de cambios en la estructura de la vegetación. Es decir, que la tendencia de NDVI se corresponda con alteraciones estructurales en el ecosistema que puedas identificar mediante las distintas ortofotos. Ej. Tendencia de NDVI negativa en lugares donde en alguna ortofoto se vean síntomas de un incendio forestal.

·    ¿Qué tienes que entregar? Pegar en un Word un pantallazo de dicha zona que contenga:

o  Tendencia según Mann Kendall (vista en QGIS)

o  Ortofoto reciente (Para ello deberás de poner la capa anterior con cierta transparencia)

o  Gráfica con la serie temporal de NDVI (según el complemento 

o  Breve texto (un párrafo) explicativo.

 

 