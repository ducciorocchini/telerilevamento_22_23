# R code for species distribution modelling

library(raster) # predictors
library(sdm)
library(rgdal)

file <- system.file("external/species.shp", package="sdm") 

species <- shapefile(file)

plot(species, pch=19)
plot(species[species$Occurrence == 1,],col='blue',pch=16)

species$Occurrence

occ <- species$Occurrence

plot(species[occ == 1,], col="blue", pch=19)
points(species[occ == 0,], col="red", pch=19)


# predictors: look at the path
path <- system.file("external", package="sdm") 

# list the predictors
lst <- list.files(path=path, pattern='asc', full.names=T)
# full.names is needed in case you want to maintain the whole path in the name of the file

preds <- stack(lst)
cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
plot(preds, col=cl)

# plot of predictors with presences
elev <- preds$elevation
prec <- preds$precipitation
temp <- preds$temperature
vege <- preds$vegetation

plot(elev, col=cl)
points(species[occ == 1,], pch=19)

plot(prec, col=cl)
points(species[occ == 1,], pch=19)

plot(temp, col=cl)
points(species[occ == 1,], pch=19)

plot(vege, col=cl)
points(species[occ == 1,], pch=19)

# model

# data
datasdm <- sdmData(train=species, predictors=preds)

m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=datasdm, methods="glm")

p1 <- predict(m1, newdata=preds)

# output
plot(p1, col=cl)
points(species[occ == 1,], pch=19)

par(mfrow=c(2,3))
plot(p1, col=cl)
plot(elev, col=cl)
plot(prec, col=cl)
plot(temp, col=cl)
plot(vege, col=cl)

# alternative #2
final <- stack(preds, p1)
plot(final, col=cl)




