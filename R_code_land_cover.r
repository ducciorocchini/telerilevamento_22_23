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

tot92 <- 341292

# proportion of classes
prop_forest_92 <- 305213 / tot92

# percent of classes
perc_forest_92 <- 305213 * 100 / tot92

# Exercise: calculate the percentage of agricultural areas in 1992
# method 1
perc_agr_92 <- 100 - perc_forest_92
# method 2
perc_agr_92 <-  36079 * 100 / tot92

# percent_forest_92: 89.4287
# percent_agr_92: 10.5713

freq(l06c$map)
# class 1: 177941 pixels (forest)
# class 2: 164785 pixels (agricultural areas)

# percentages 2006
tot_06 <- 342726 
percent_forest_06 <- 177941 * 100 / tot_06
percent_forest_06
percent_agr_06 <- 100 - percent_forest_06

# percent_forest_06: 51.91932
# percent_agr_06: 48.08068

# FINAL DATA:
# percent_forest_92: 89.4287
# percent_agr_92: 10.5713
# percent_forest_06: 51.91932
# percent_agr_06: 48.08068

# Let's build a dataframe with our data
# Columns (fields)
class <- c("Forest", "Agriculture")
percent_1992 <- c(89.4287, 10.5713)
percent_2006 <- c(51.91932, 48.08068)

multitemporal <- data.frame(class, percent_1992, percent_2006)

# 1992
ggplot(multitemporal, aes(x=class, y=percent_1992, color=class)) +
geom_bar(stat="identity", fill="white")

# Exercise: make the same graph for 2006
ggplot(multitemporal, aes(x=class, y=percent_2006, color=class)) +
geom_bar(stat="identity", fill="white")

# pdf
pdf("percentages_1992.pdf")
ggplot(multitemporal, aes(x=class, y=percent_1992, color=class)) +
geom_bar(stat="identity", fill="white")
dev.off()

pdf("percentages_2006.pdf")
ggplot(multitemporal, aes(x=class, y=percent_2006, color=class)) +
geom_bar(stat="identity", fill="white")
dev.off()






















