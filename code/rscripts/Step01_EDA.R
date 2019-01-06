library(dplyr)
library(dlookr)

getwd()

#load Data
flight_2013 <- readRDS("data/produced_data/flight_2013.Rds")


#General diagnosis of all variables
diagnose(flight_2013)

Profile <- flight_2013 %>%
           diagnose()

NumericVariableProfile <- flight_2013 %>%
           diagnose_numeric()

CategoricalVariableProfile <- flight_2013 %>%
              diagnose_category()

Outliers <- flight_2013 %>%
             diagnose_outlier()

#plotting outliers
flight_2013 %>%
  plot_outlier(diagnose_outlier(.) %>%
               filter(outliers_ratio >= 0.5) %>%
                 select(variables) %>%
                 unlist())
 
flight_describe <- describe(flight_2013)   
flight_normality <- normality(flight_2013, -year)
plot_normality(flight_2013, -year)

flight_2013 %>%
  diagnose_report(output_format="html", output_file="C:/Users/amitb/R/EDA_Flights_R/report/flight_2013_diagnose.html")

flight_2013 %>%
  eda_report(target=arr_delay,output_format="html", output_file="eda.html")

flight_2013 %>%
  transformation_report(target=arr_delay,output_format="html", output_file="transformation.html")

# Experimental calculate skewness
numeric_summary <- flight_2013 %>%
  select_if(is.numeric) %>%
  summarize_all(funs(mean(.,na.rm=TRUE),
                     skew1 =(sum(((!is.na(.))-mean(.,na.rm=TRUE))^3)/length(.))/(sum(((!is.na(.))-mean(.,na.rm=TRUE))^2)/length(.))^(3/2)     
                     
  ))

