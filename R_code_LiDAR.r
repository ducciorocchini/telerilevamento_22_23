# R code for visualising and analysing LiDAR data

library(raster)
library(ggplot2)
library(viridis)
library(RStoolbox)
# install.packages("lidR")
library(lidR) # to visualize the original point cloud

setwd("~/lab/") # Linux
# setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac 

dsm_2013 <- raster("2013Elevation_DigitalElevationModel-0.5m.tif")
dsm_2013

dtm_2013 <- raster("2013Elevation_DigitalTerrainModel-0.5m.tif")
dtm_2013

plot(dtm_2013)

chm_2013 <- dsm_2013 - dtm_2013
chm_2013

ggplot() + 
  geom_raster(chm_2013, mapping =aes(x=x, y=y, fill=layer)) + 
  scale_fill_viridis() +
  ggtitle("CHM 2013 San Genesio/Jenesien")

# 2004

dsm_2004 <- raster("2004Elevation_DigitalElevationModel-2.5m.tif")

dtm_2004 <- raster("2004Elevation_DigitalTerrainModel-2.5m.tif")

chm_2004 <- dsm_2004 - dtm_2004

ggplot() + 
  geom_raster(chm_2004, mapping =aes(x=x, y=y, fill=layer)) + 
  scale_fill_viridis() +
  ggtitle("CHM 2004 San Genesio/Jenesien")

# Difference in CHM
difference_chm <- chm_2013-chm_2004 # error in the different resolution

# Resampling
chm_2013r <- resample(chm_2013, chm_2004)

difference_chm <- chm_2013r-chm_2004 

ggplot() + 
  geom_raster(difference_chm, mapping =aes(x=x, y=y, fill=layer)) + 
  scale_fill_viridis() +
  ggtitle("CHM difference San Genesio/Jenesien")

# Reading the point cloud
point_cloud <- readLAS("point_cloud.laz")

plot(point_cloud)

