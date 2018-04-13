# Load libraries
library(rgdal)
library(raster)

# Set the complete path to the directory that holds WorldClim raster data
setwd("~/Documents/workspace/africa/bioclim2_5/Present")

# Set the subdiretory name where clipped rasters will be writed
subDirName = "clip"
outputFolder <- paste(getwd(),"/",subDirName,sep="")
dir.create(outputFolder)

# Set the patColocar aqui o caminho completo para a shapefile de treino, incluindo o nome do ficheiro"
treino <- "/Users/rfigueira/Documents/workspace/africa/ANGOLA/regiaoTreinoAngola.shp"

mask <- readOGR(treino)

#clip da layer altitude
raster <- raster("./altitude.asc")
rasterClip <- crop(raster,mask)
rasterMask <- mask(rasterClip,mask)
filename=paste(outputFolder,"/","altitude.asc",sep="")
writeRaster(bioClip, filename, format="ascii", overwrite=TRUE)
print("Clip de altitude completo")

for (i in 1:19){
  rasterName <- paste("./bio", i, ".asc",sep="")
  bio <- raster(rasterName)
  bioClip <- crop(bio,mask)
  bioClip <- mask(bioClip,mask)
  filename=paste(outputFolder,"/",rasterName,sep="")
  writeRaster(bioClip, filename, format="ascii", overwrite=TRUE)
  print(paste("Clip de bio",i," completo.",sep=""))
}
