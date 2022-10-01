library(readxl)
library(plotly)
library(ggcorrplot) # for correlation plot
library(shinycssloaders) # to add a loader while graph is populating
library(shiny) # shiny features
library(shinydashboard) # shiny dashboard functions
library(ggtext)
library(ggplot2)

my_data <- read_excel("C:/Users/ADMIN/Desktop/millets/Milletsapp/www/new_data_millets.xlsx")
new_data<-
cleaned_data <-read_excel("C:/Users/ADMIN/Desktop/millets/dataset/cleaned_data.xlsx")
Export_Country_Year <- read_excel("C:/Users/ADMIN/Desktop/millets/dataset/Export_Country_Year.xlsx")
COC <-  read_excel("C:/Users/ADMIN/Desktop/millets/dataset/COC_18 (1).xlsx")
Bajra_MSP <- read_excel("C:/Users/ADMIN/Desktop/millets/dataset/Bajra_MSP.xlsx")
MilletsExport <- read_excel("C:/Users/ADMIN/Desktop/millets/dataset/MilletsExport.xlsx")
year_AP <- read_excel("C:/Users/ADMIN/Desktop/millets/dataset/year_AP.xlsx")
piechart_country_export <- read_excel("C:/Users/ADMIN/Desktop/millets/dataset/piechart_country_export.xlsx")
state_prod <- read_excel("C:/Users/ADMIN/Desktop/millets/dataset/state_prod.xlsx")
bajra_Coc <- read_excel("C:/Users/ADMIN/Desktop/millets/dataset/bajra_Coc.xlsx")
pearl_data <- read_excel("C:/Users/ADMIN/Desktop/millets/dataset/pearl_data.xlsx")


library(dplyr)
#agg_data = aggregate(.~State,new_data,sum)

c1 =cleaned_data %>% 
  select(-"State",-"Crop") %>% 
  names()

c2 = cleaned_data %>% 
  select(-"Crop") %>% 
  names()


c3= unique(c(new_data$State))

c4= unique(c(pearl_data$State))
             
           


lm_cleaned_data=readRDS("C:/Users/ADMIN/Desktop/millets/Milletapp2/lm_cleaned_data.rds")

model_lmn=readRDS("C:/Users/ADMIN/Desktop/millets/Milletapp2/model_lmn.rds")
