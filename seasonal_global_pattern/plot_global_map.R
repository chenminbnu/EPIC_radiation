#Using GGPLOT, plot the Base World Map
library(tidyverse)
mapWorld <- borders("world", colour="gray50", fill="gray50") # create a layer of borders
mp <- ggplot() +   mapWorld

#Now Layer the cities on top
#mp <- mp+ geom_point(aes(x=visit.x, y=visit.y) ,color="blue", size=3) 
mp

library(ggplot2)
library(dplyr)

WorldData <- map_data('world') %>% filter(region != "Antarctica") %>% fortify

df <- data.frame(region=c('Hungary','Lithuania','Argentina'), 
                 value=c(4,10,11), 
                 stringsAsFactors=FALSE)

p <- ggplot() +
  geom_map(data = WorldData, map = WorldData,
           aes(x = long, y = lat, group = group, map_id=region),
           fill = "white", colour = "#7f7f7f", size=0.5) + 
  geom_map(data = df, map=WorldData,
           aes(fill=value, map_id=region),
           colour="#7f7f7f", size=0.5) +
  coord_map("rectangular", lat0=0, xlim=c(-180,180), ylim=c(-60, 90)) +
  scale_fill_continuous(low="thistle2", high="darkred", guide="colorbar") +
  scale_y_continuous(breaks=c()) +
  scale_x_continuous(breaks=c()) +
  labs(fill="legend", title="Title", x="", y="") +
  theme_bw()
p 