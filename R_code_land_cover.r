# Code for generating land cover maps from satellite imagery

# install.packages("ggplot2")
# for info: https://ggplot2-book.org/
# install.packages("patchwork")
# for info: https://patchwork.data-imaginist.com/

library(raster)
library(RStoolbox) # for classification
library(ggplot2)
library(patchwork)

setwd("~/lab/") # Linux
# setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac

# NIR 1
# r 2
# g 3

l92 <- brick("defor1_.jpg")
plotRGB(l92, 1, 2, 3, stretch="lin")

# Exercise: import defor2 and plot both in a single window
l06 <- brick("defor2_.jpg")

par(mfrow=c(2,1))
plotRGB(l92, 1, 2, 3, stretch="lin")
plotRGB(l06, 1, 2, 3, stretch="lin")

# making a simple multiframe with ggplot2
ggRGB(l92, 1, 2, 3, stretch="lin")
ggRGB(l06, 1, 2, 3, stretch="lin")

p1 <- ggRGB(l92, 1, 2, 3, stretch="lin")
p2 <- ggRGB(l06, 1, 2, 3, stretch="lin")
p1+p2 # thanks to patchwork!
p1/p2 

# classification
l92c <- unsuperClass(l92, nClasses=2)
l92c
plot(l92c$map)
# class 1: forest
# class 2: agricultural areas (+ water)

# Exercise: classify the Landsat image from 2006
l06c <- unsuperClass(l06, nClasses=2)
l06c
plot(l06c$map)
# class 1: forest
# class 2: agricultural areas (+ water)

# Frequencies
freq(l92c$map)
# class 1: 305213 pixels (forest)
# class 2:  36079 pixels (agricultural areas)

freq(l06c$map)
# class 1: 177941 pixels (forest)
# class 2: 164785 pixels (agricultural areas)


































