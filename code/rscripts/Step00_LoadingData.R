library(dplyr)
library(dlookr)
library(nycflights13)

getwd()


flight_2013 <- flights

# 336,776 rows, 19 columns
dim(flight_2013)

#data.frame
class(flight_2013)

saveRDS(flight_2013 , "data/produced_data/flight_2013.Rds")
