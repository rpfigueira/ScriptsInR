# This R script can be used to clip the Worldclim raster layers using a shapefile polygon that defines a training region for a maxent model


# Load libraries
library(rgdal)
library(raster)

# Set the complete path to the directory that holds WorldClim raster data
setwd("~/Documents/workspace/africa/bioclim2_5/Present")

# Set the subdiretory name where clipped rasters will be writed
subDirName = "clip"
outputFolder <- paste(getwd(),"/",subDirName,sep="")
dir.create(outputFolder)

# Set the complete path to the training region shapefile"
treino <- "/Users/rfigueira/Documents/workspace/africa/ANGOLA/regiaoTreinoAngola.shp"

# Load training region
mask <- readOGR(treino)

#First, clip the altitude layer. Check if you need to run this
raster <- raster("./altitude.asc")
rasterClip <- crop(raster,mask)
rasterMask <- mask(rasterClip,mask)
filename=paste(outputFolder,"/","altitude.asc",sep="")
writeRaster(rasterMask, filename, format="ascii", overwrite=TRUE)
print("Clip of layer altitude completed")

# Clip all 19 Worldclim Bioclim layers
for (i in 1:19){
  rasterName <- paste("./bio", i, ".asc",sep="")
  bio <- raster(rasterName)
  bioClip <- crop(bio,mask)
  bioMask <- mask(bioClip,mask)
  filename=paste(outputFolder,"/",rasterName,sep="")
  writeRaster(bioMask, filename, format="ascii", overwrite=TRUE)
  print(paste("Clip de bio",i," completo.",sep=""))
}
