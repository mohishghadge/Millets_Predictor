library(VIM)
library(mice)  #Multivariate Imputation By Chained Equations
library(readxl)
library(tidyverse)
library(ggplot2)
#importing data
Millet <- read_excel("D:/Users/Pearl Millet (Bajra).xlsx")




str(Millet)
Millet$Crop<-as.factor(Millet$Crop)
Millet$State<-as.factor(Millet$State)


#Changing each column exponential or big values with decimal to round off 3 
Millet$`Yield`<-round(Millet$`Yield`,digits = 3)
Millet$`Area` <-round(Millet$`Area`,digits = 3)
Millet$`Production`<-round(Millet$`Production`,digits = 3)

#changing the values which are zero or 0.1 to NA
Millet[Millet==0]<-NA

View(Millet)

#Taking percentage of Missing Data

percent<-function(x){sum(is.na(x))/length(x)*100}
apply(Millet,2,p)

#Lets store a subset of data(for Testing Purpose)
#millets_area_subset <-subset(Millet,is.na(Millet$`Area(Hectares)`))
#millets_yield_subset <-subset(Millet,is.na(Millet$`Yield(Kg/Ha)`))
#millets_production_subset <-subset(Millet,is.na(Millet$`Production(Tonnes)`))
#View(millets_area_subset)
#View(millets_yield_subset)
#View(millets_production_subset)

#Showing Stats of Missing Values 

aggr_plot<-aggr(Millet,col=c('navyblue','red'),
                numbers=TRUE,
                sortVars=TRUE,
                labels=names(Millet),
                cex.axis=.7,
                gap=5,
                ylab=c("Histogram of Missing data","Pattern"))


#Simple Imputation
#Millet$Area[which(is.na(Millet$Area))]<-mean(Millet$Area,na.rm=TRUE)
#Millet$Production[which(is.na(Millet$Production))]<-mean(Millet$Production,na.rm=TRUE)
#Millet$Yield[which(is.na(Millet$Yield))]<-mean(Millet$Yield,na.rm=TRUE)
#Applying Predictive Mean Matching(PMM) i.e 'numerical Categorical Data' Mice Function for Imputation

#millet_dt2=Millet
#impute<- mice(Millet[,2:6],m=5,)


#IMPUTING DATA
imputed_data <-mice(Millet,m=5,method = "cart")
imputed_data$imp
new_data <-complete(imputed_data,1)
View(new_data)



#Exporting cleaned data in excel
library(rio)
library(dplyr)
library(openxlsx)
export(new_data,"new_data_millets.xlsx")
export(Millet,"ms_data_millets.xlsx")

#
#Categorical VALUES :- CROP ,STATE

#Numeric VALUES:-   YEAR AREA PRODUCTION YEILD

#Continuous VALUES :-   STATE,YEAR


#histogram 
#is used for uni variate (numeric continuous values)
#variable to know the variations of a single column


#By Production
Production.agg <- aggregate(Production~Year ,new_data,mean)
Production.agg$Production<-round(Production.agg$Production,2)


ggplot(data=Production.agg ,aes(Year,`Production`,label=`Production`,fill=Year))+
  geom_bar(stat = "identity")+geom_text(size=4,vjust=3,color="Black")+geom_line(size=1)


#By Area
Area.agg <- aggregate(Area~Year ,new_data,mean)
Area.agg$Area<-round(Area.agg$Area,1)

ggplot(data=Area.agg ,aes(Year,`Area`,label=`Area`,fill=Year))+
  geom_bar(stat = "identity")+geom_text(size=4,vjust=3,color="Black")+geom_line(size=1)

Yield.agg <- aggregate(Yield~Year ,new_data,mean)
Yield.agg$Yield<-round(Yield.agg$Yield,1)

yield_agg_yield <- Yield.agg %>% select(Yield)

#barplot 
#is used for categorical data or factor type of values
ggplot(data=new_data,aes(yield_agg_yield,mean))+geom_bar(stat = 'identity')



agg_data2 = aggregate(.~State,new_data,mean)

library(dplyr)

agg_data <- agg_data2 %>% 
  mutate_if(is.numeric,
            round,
            digits=1)



p1 = agg_data %>% 
  plot_ly() %>% 
  add_histogram(x=Area)
  



#Scatter Plot  
#is to find out the relationship between two numeric values 
#independent variable should be on x axis and dependent variable should be on y axis





#Trends

ggplot(data =Production.agg,aes(x=Year,y=`Production`))+geom_line(size=1)

ggplot(data =Area.agg,aes(x=Year,y=`Area`))+geom_line(size=1)



c <- aggregate(Production~State ,new_data,mean)
Production.agg.state$Production<-round(Production.agg.state$Production,2)

#selecting Individually

Prod.agg.state <- Production.agg.state %>% select(State)
prod_agg_year <-Production.agg %>% select(Year)
prod_agg_Product <-Production.agg %>% select(Production)
yield_agg_yield<- Yield.agg %>% select(Yield)

#Pie Chart


pl <- ggplot(data = Production.agg.state, aes(x= '',y = prod_agg_Product, fill = paste0(id,' : ',Prod.agg.state,'(', round(prod_agg_Product/sum(prod_agg_Product)*100),'%)' )))
pl <- pl + geom_bar(width = 1, stat = "identity")
pl <- pl + geom_text(aes(x = 1.4,label = id ), position = position_stack(vjust = 0.5))
pl <- pl + theme_void()
pl <- pl + theme_classic()
pl <- pl + theme(legend.position = "top")
pl  <- pl + coord_polar("y", start=0)
pl <- pl + scale_fill_manual(values = palette)
pl <- pl +   theme(axis.line = element_blank())
pl <- pl +   theme(axis.text = element_blank())
pl <- pl +   theme(axis.ticks = element_blank())
pl <- pl +   labs(x = NULL, y = NULL, fill = NULL)
pl <- pl + labs(title ="Pie chart of Millet")
pl <- pl + labs(subtitle ="Top States")


pl




library(echarts4r) # load echarts4r

new_data %>%  
  e_charts(x =State) %>% 
  e_bar(serie =Area ) %>%
  e_bar(serie =Production ) %>%  
  
  e_tooltip(trigger = "item")


MilletsExport %>% 
  e_charts(x=Category) %>% 
  e_scatter(serie =`Bajra Exports`) %>% 
e_tooltip(trigger = "item") %>% 
e_labels(xlab="Year",ylab="Exports")

p<-ggplot(data=MilletsExport,aes(x = Category,y=`Bajra Exports`))+geom_line()



#By Production
Production.agg <- aggregate(Production~Year ,new_data,mean)
Production.agg$Production<-round(Production.agg$Production,2)



Area.agg <- aggregate(Area~Year ,new_data,mean)
Area.agg$Area<-round(Area.agg$Area,1)

Yield.agg <- aggregate(Yield~Year ,new_data,mean)
Yield.agg$Yield<-round(Yield.agg$Yield,1)


agg_data = new_data %>% 
  select()

agg_data = aggregate(.~State,new_data,sum)

library(readxl)
MilletsExport <- read_excel("D:/Users/MilletsExport.xlsx")
View(MilletsExport)




india_prod = plot_geo(agg_data,
                      locationmode = 'INDIA-states',
                      frame= ~Year) %>% 
  add_trace(location=~State,
            z=~Production,
            color = ~Production)






  
