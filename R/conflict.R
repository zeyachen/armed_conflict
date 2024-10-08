## -------------------------------------------------------------------------------------------------------
library(here)
library(tidyverse)
rdf <- read.csv(here("original","conflictdata.csv"),header = T)


## -------------------------------------------------------------------------------------------------------
ndf <- rdf %>%
  group_by(ISO, year) %>%
  summarise(total_best = sum(best, na.rm = TRUE)) %>%
  ungroup()

## -------------------------------------------------------------------------------------------------------
ndf$conflict <- 1*(ndf$total_best>=25)
ndf$year <- ndf$year + 1

