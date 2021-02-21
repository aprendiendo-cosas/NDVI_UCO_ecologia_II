## Analisis de la serie temporal de NDVI del norte de Cordoba

## Definimos directorio de trabajo y cargamos los paquetes necesarios
setwd("~/Google Drive/4_docencia/uco/2017_2018/ecologia_aplicada/practicas/remote_sensing/landsat7_GEE")

install.packages("Kendall")
library(raster)
library(rgdal)
library(Kendall)


## Empaquetamos todas las imagenes tiff generadas por GEE en una unica imagen multibanda
lista_imagenes <- list.files(pattern='*.tif', full.names=TRUE)

ndvis <- brick(stack(lista_imagenes))

plot(ndvis)


# Exportamos la imagen a tif
writeRaster(ndvis, filename="ndvi_1999_2017.tif", format="GTiff", overwrite=TRUE)


## Calculamos la serie temporal de todos los pixeles

fun_k <-function(x){return(unlist(MannKendall(x)))}

kendal_result <-calc(ndvis, fun_k)

# Exportamos la tendencia (tau) a un tif

writeRaster(kendal_result$tau, filename="tau.tif", format="GTiff", overwrite=TRUE)

# Reclasificamos para ver mejor los sitios con tendencia muy positiva y muy negativa

m <- c(-1, -0.25, -1, -0.25, 0.5, 0, 0.5, 1, 1)
rclmat <- matrix(m, ncol=3, byrow=TRUE)
rc_tau <- reclassify(kendal_result$tau, rclmat)
writeRaster(rc_tau, filename="rc_tau.tif", format="GTiff", overwrite=TRUE)

# Ahora ponemos el foco en la finca del patriarca. Recortamos la imagen anterior por los limites de la finca

patriarca <- readOGR("patriarca.shp")
tau_patriarca<-crop(kendal_result$tau, patriarca)
tau_patriarca_f <-mask(tau_patriarca, patriarca)

writeRaster(tau_patriarca_f, filename="tau_patriarca.tif", format="GTiff", overwrite=TRUE)

# Reclasificamos la zona del patriarca.

m_pa <- c(-1, -0.25, -1, -0.25, 0.5, 0, 0.5, 1, 1)
rclmat_pa <- matrix(m_pa, ncol=3, byrow=TRUE)
rc_tau_patriarca <- reclassify(tau_patriarca_f, rclmat_pa)
writeRaster(rc_tau_patriarca, filename="rc_tau_patriarca.tif", format="GTiff", overwrite=TRUE)







