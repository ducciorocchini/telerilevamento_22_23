
install.packages("colorist")
library(colorist)
library(ggplot2)

# Data
data("fiespa_occ")

met1<-metrics_pull(fiespa_occ) 
pal<- palette_timecycle(fiespa_occ)

map_multiples(met1, pal, ncol=3, labels=names(fiespa_occ))

map_single(met1, pal, layer=6)

p1custom <- palette_timecycle(12, start_hue=60)

map_multiples(met1, p1custom, ncol=3, labels=names(fiespa_occ))

met1_distill<-metrics_distill(fiespa_occ) # we can distill the information

map_single(met1_distill,pal) #We then display 
map_single(met1_distill,p1custom) #We then display 

# single individual
data("fisher_ud")   
m2 <- metrics_pull(fisher_ud)

pal2 <- palette_timeline(fisher_ud)
head(pal2)

map_multiples(m2,ncol = 3, pal2)

map_multiples(m2,ncol = 3, pal2, lambda_i = -12)

m2_distill<-metrics_distill(fisher_ud)
map_single(m2_distill,pal2,lambda_i = -10)

legend_timeline(pal2,time_labels = c("2 aprile", "11 aprile"))

######## Esempio 3 saltato:



#EXAMPLE 3: MAPPING THE DISTRIBUTIONS OF MULTIPLE INDIVIDUALS DURING THE SAME TIME PERIOD

# In the previous examples, we explored the distributions of a single species and a single individual over multiple time periods.
#colorist can also be used to explore the distribution of multiple species or individuals in a single period of time.

#Here, we use GPS tracking data collected from African elephants (Loxodonta africana) in Etosha National Park (Namibia) during 2011 to explore how two individuals used the landscape over the course of a year.


#Load the data

data("elephant_ud")
elephant_ud
#class      : RasterBrick 
#dimensions : 208, 193, 40144, 2  (nrow, ncol, ncell, nlayers)
#resolution : 500, 500  (x, y)
#extent     : -58642.18, 37857.82, -2376938, -2272938  (xmin, xmax, ymin, ymax)
#crs        : +proj=moll +lon_0=15.8231920275931 +x_0=0 +y_0=0 +ellps=WGS84 +units=m +no_defs 
#source     : memory
#names      :      LA11,      LA14 
#min values :         0,         0 
#max values : 0.8525854, 1.0000000 


#Extract the data from the Rasterstack

met3<-metrics_pull(elephant_ud)


#Here we encounter another function, palette_set ()
#We use this function when we have an unordered set (they don't fit into linear or cyclic sequences)

pal3<-palette_set(elephant_ud)


#We can Create the multiple maps and then we will see the two samples, we use "labels" to extract the names present in the Rasterstack

map_multiples(met3, pal3, ncol = 2,lambda_i = -5,labels = names(elephant_ud))



#The usage distributions for LA11 and LA14 look remarkably similar at first glance, which is not surprising given that the two elephants belong to the same herd.
#However, we can more clearly understand the similarities and differences in how they used space in 2011 by “distilling” the distributional information from the two raster layers with metrics_distill () and visualizing the resulting metrics with map_single ().

#WE SHOULD RE-CALIBRATE OUR UNDERSTANDING OF THE MEANING OF SPECIFICITY

#We stand in contrast to the Field Sparrow and Fisher examples, where specificity indicated the degree to which intensity values were inconsistent (or consistent) over time.
#HERE WE CAN DEFINE IT AS A DIFFERENTIAL LANDSCAPE MEASURE.
#THEREFORE LOW SPECIFICITY IS EQUAL TO COMMON USE OF THE LANDSCAPE, HIGH SPECIFICITY INDICATES A DIFFERENTIAL USE OF THE LANDSCAPE

met3_distt<-metrics_distill(elephant_ud)
map_single(met3_distt,pal2,lambda_i = -5)

#Here we will use a different legend once again.
#We will use legend_set and not legend_timeline or legend_timecycle 

legend_set(pal3, group_labels = names(elephant_ud))





