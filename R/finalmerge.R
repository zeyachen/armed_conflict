## -------------------------------------------------------------------------------------------------------
library(tidyverse)
library(here)
here()
covariates <- read_csv(here("original","covariates.csv"))


## -------------------------------------------------------------------------------------------------------
source(here("R", "matmordata.R"))
source(here("R", "disasterdata.R"))
source(here("R", "conflict.R"))


## -------------------------------------------------------------------------------------------------------
worldbank <- worldbank[!is.na(worldbank$ISO),]
final <- merge(worldbank,ndf,by= c("ISO","year"),all.x = T)


## -------------------------------------------------------------------------------------------------------
final <- merge(final,disasters,by= c("ISO","year"),all.x = T)
final <- merge(final,covariates[,-1],by= c("ISO","year"),all.y = T)


## -------------------------------------------------------------------------------------------------------
all(table(final$ISO)==20) #check if its 20 for all countries


## -------------------------------------------------------------------------------------------------------
library(here)
write_csv(final,here("data","final.csv"))

