## ----------------------------------------------------------------------------------------------------------------------------
library(here)
library(tidyverse)
rdf <- read.csv(here("original","disaster.csv"),header = T)


## ----------------------------------------------------------------------------------------------------------------------------
ddf <- rdf[rdf$Year >= 2000 & rdf$Year <= 2019 & (rdf$Disaster.Type=="Earthquake"|rdf$Disaster.Type=="Drought"),]


## ----------------------------------------------------------------------------------------------------------------------------
sdf <- ddf[,c("Year","ISO","Disaster.Type")]
names(sdf)[1]<-"year"


## ----------------------------------------------------------------------------------------------------------------------------
disaster_grouped <- dplyr::group_by(sdf, year, ISO)
disaster_mutated <- dplyr::mutate(disaster_grouped, 
                                  drought0 = ifelse(Disaster.Type == "Drought", 1, 0),
                                  earthquake0 = ifelse(Disaster.Type == "Earthquake", 1, 0))

disasters_summarized <- dplyr::summarize(disaster_mutated, 
                                         drought = max(drought0),
                                         earthquake = max(earthquake0))

disasters <- dplyr::ungroup(disasters_summarized)


## ----------------------------------------------------------------------------------------------------------------------------
write_csv(disasters,here("data","disastor.csv"))

