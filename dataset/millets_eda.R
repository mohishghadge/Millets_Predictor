library(VIM)
library(mice)  #Multivariate Imputation By Chained Equations
library(readxl)
library(tidyverse)
library(ggplot2)
library(DataExplorer)

#importing data
Millet <- read_excel("D:/Users/Pearl Millet (Bajra).xlsx")

str(Millet)
Millet$Crop<-as.factor(Millet$Crop)
Millet$State<-as.factor(Millet$State)


#Changing each column exponential or big values with decimal to round off 3 
Millet$`Yield`<-round(Millet$`Yield`,digits = 3)
Millet$`Area` <-round(Millet$`Area`,digits = 3)
Millet$`Production`<-round(Millet$`Production`,digits = 3)


#Descriptive Analysis

plot_bar(Millet)   #plotting horizontally 
ggplot(data = Millet) + geom_bar(mapping = aes(x=State)) #plotting Vertically 

plot_bar(Millet,by="State")

library(SmartEDA) #for EDA

ExpCatViz(
  Millet %>% 
    select(State,`Area`))


#
#Categorical VALUES :- CROP ,STATE

#Numeric VALUES:-   YEAR AREA PRODUCTION YEILD

#Continuous VALUES :-   STATE,YEAR

#changing the values which are zero or 0.1 to NA
Millet[Millet==0]<-NA

View(Millet)

#Taking percentage of Missing Data

p<-function(x){sum(is.na(x))/length(x)*100}
apply(Millet,2,p)

#Lets store a subset of data(for Testing Purpose)
#millets_area_subset <-subset(Millet,is.na(Millet$`Area(Hectares)`))
#millets_yeild_subset <-subset(Millet,is.na(Millet$`Yield(Kg/Ha)`))
#millets_production_subset <-subset(Millet,is.na(Millet$`Production(Tonnes)`))
#View(millets_area_subset)
#View(millets_yeild_subset)
#View(millets_production_subset)

aggr_plot<-aggr(Millet,col=c('navyblue','red'),
                numbers=TRUE,
                sortVars=TRUE,
                labels=names(Millet),
                cex.axis=.7,
                gap=3,
                ylab=c("Histogram of Missing data","Pattern"))


#Simple Imputation
#Millet$Area[which(is.na(Millet$Area))]<-mean(Millet$Area,na.rm=TRUE)
#Millet$Production[which(is.na(Millet$Production))]<-mean(Millet$Production,na.rm=TRUE)
#Millet$Yield[which(is.na(Millet$Yield))]<-mean(Millet$Yield,na.rm=TRUE)
#Applying Predictive Mean Matching(PMM) i.e 'numerical Catergorical Data' Mice Function for Imputation

#millet_dt2=Millet
#impute<- mice(Millet[,2:6],m=5,)


imputed_data <-mice(Millet,m=5,method = "cart")

imputed_data$imp


new_data <-complete(imputed_data,4)
View(new_data)





