#Remove objects
rm(list=ls())

#Set WD
old.dir <- getwd()
setwd('~/Desktop/R Projects/Bivalves_2020')

#Load libraries
library(ggmap)
library(ggplot2)
library(rstudioapi)

#API key
register_google(key = '')


#Load Location Data 
data <- read.csv("~/Desktop/R Projects/Bivalve_2020/Bivalves_data_2.csv")


#Create a map 
portsmouth <- c(left = -70.88, bottom = 43.00, right = -70.71, top = 43.15)

map_portsmouth <- get_stamenmap(
    portsmouth, 
    zoom = 12,
    maptype = 'terrain',
    color = 'bw',
)
  
map <- ggmap(map_portsmouth) +
  
  #Add data and color by site 
  geom_point(data = data, 
             aes(x = Longitude, y = Latitude, color = Site), 
             size = 5, 
             show.legend = TRUE) +
    
  #Delete axis info
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_blank()) +
  
  #Add map title
  labs(title ='Bivalve Collection Sites 2021',
       subtitle = 'Portsmouth, NH') + 
  
  #Adjust size and position of title text
  theme(plot.title = element_text(size = 20, hjust = 0.5 ),
        plot.subtitle = element_text(size = 18, hjust = 0.5)) +
  
  #Adjust legend
  theme(legend.title = element_text(size = 16, face = 'bold', hjust = 0.5), 
        legend.text = element_text(size = 14),
        legend.background = element_rect(fill='lightgrey',
                                         size = 0.5, 
                                         linetype = 'solid'),
        legend.key = element_rect(fill='lightgrey'),
        legend.margin = margin(r=5,l=5,t=5,b=5),
        legend.direction = 'horizontal',
        legend.box = 'horizontal',
        legend.position = c(0.5,0.1)) +

  guides(col = guide_legend('Site Name',
                            title.position = 'top',
                            ncol = 3,
                            ))
#Print map!!
print(map)

#Export PDF
destination = './map_final.pdf'

#open PDF
pdf(file=destination)
plot(map)

dev.off()  
