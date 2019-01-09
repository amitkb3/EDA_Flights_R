# We will try to replicate functions of dlookr package for learning purpose

library(dplyr)
library(tidyr)
#load Data
flight_2013 <- readRDS("data/produced_data/flight_2013.Rds")
x 
# Create dlookr function diagnose () 
# 
# variables : variable name
# types : the data type of the variable
# missing_count : number of missing values
# missing_percent : percentage of missing values
# unique_count : number of unique values
# unique_rate : rate of unique value. unique_count / number of observation

diagnose <- flight_2013 %>%
            summarise_all(funs(
              types = class(.)[1],
              missingcount = sum(as.numeric(is.na(.))),
              missingpercent = round(mean(as.numeric(is.na(.)))*100,digits=1),
              uniquecount = n_distinct(.),
              uniquerate = round((n_distinct(.)/n())*100,digits=1)
            )) %>%
            gather(variable,value) %>%
            separate(variable,c("var","stat"), sep="_(?=[^_]*$)") %>%
            spread(stat,value) %>%
            rename(variables = var) %>%
            select(variables,types,missingcount,missingpercent,uniquecount,uniquerate) %>%
            as.data.frame()
            