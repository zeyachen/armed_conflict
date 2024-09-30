## ----------------------------------------------------------------------------------------------------------------------------
library(here)
library(tidyverse)
here()
rdf <- read.csv(here("original","maternalmortality.csv"),header = T)


## ----------------------------------------------------------------------------------------------------------------------------
sdf <- select(rdf,c(Country.Name,X2000:X2019))


## ----------------------------------------------------------------------------------------------------------------------------
names(sdf) <- c("Country.Name",2000:2019)
ldf <- pivot_longer(sdf, cols = c(2:21),names_to = "year",values_to = "MatMor")



## ----------------------------------------------------------------------------------------------------------------------------
prepdf <- function(x,y){
  rdf <- read.csv(here("original",x),header = T)
  sdf <- select(rdf,c(Country.Name,X2000:X2019))
  names(sdf) <- c("Country.Name",2000:2019)
  return(pivot_longer(sdf, cols = c(2:21),names_to = "year",values_to = y))
}


## ----------------------------------------------------------------------------------------------------------------------------
i <- prepdf("infantmortality.csv","InfMor")
n <- prepdf("neonatalmortality.csv","NeoMor")
u <- prepdf("under5mortality.csv","U5Mor")
m <- prepdf("maternalmortality.csv","MatMor")


## ----------------------------------------------------------------------------------------------------------------------------
sum(i$Country.Name==n$Country.Name)
sum(i$year==n$year)
sum(u$Country.Name==n$Country.Name)
sum(u$year==n$year)
sum(u$Country.Name==m$Country.Name)
sum(u$year==m$year)

## ----------------------------------------------------------------------------------------------------------------------------
worldbank <- cbind(m,InfMor=i$InfMor,NeoMor=n$NeoMor,U5Mor=u$U5Mor)


## ----------------------------------------------------------------------------------------------------------------------------
library(countrycode)
worldbank$ISO <- countrycode(worldbank$Country.Name,origin = "country.name",destination = "iso3c")

