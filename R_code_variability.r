# R code variability

library(raster)
library(RStoolbox) # for image viewing and variability calculation
library(ggplot2) # for ggplot plotting
library(patchwork)

setwd("~/lab/") # Linux
# setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac

# Exercise: import the Similaun image
sen <- brick("sentinel.png")

# Exercise: plot the image by the ggRGB function
ggRGB(sen, 1, 2, 3, stretch="lin") # stretch is done automatically
# hence:
ggRGB(sen, 1, 2, 3)

# NIR on g component
ggRGB(sen, 2, 1, 3)

# Exercise: plot the two graphs one beside the other
g1 <- ggRGB(sen, 1, 2, 3)
g2 <- ggRGB(sen, 2, 1, 3)

# Thanks to patchwork!: 
g1+g2

# calculation of variability over NIR
nir <- sen[[1]]

sd <- focal(nir, matrix(1/9, 3, 3), fun=sd)

