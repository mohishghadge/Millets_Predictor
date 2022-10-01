library(plotly)
library(readxl)

library(gganimate)
 library(ggplot2)
library(ggthemes)
baj

cleaned_data <- read_excel("C:/Users/ADMIN/Desktop/millets/cleaned_data.xlsx")
Export_Country_Year <- read_excel("C:/Users/ADMIN/Desktop/millets/Export_Country_Year.xlsx")
COC <- read_excel("D:/Users/COC_18 (1).xlsx")
Bajra_MSP <- read_excel("C:/Users/ADMIN/Desktop/millets/Bajra_MSP.xlsx")
MilletsExport <- read_excel("C:/Users/ADMIN/Desktop/millets/MilletsExport.xlsx")
year_AP <- read_excel("D:/Users/year_AP.xlsx")
piechart_country_export <- read_excel("D:/Users/piechart_country_export.xlsx")
state_prod <- read_excel("D:/Users/state_prod.xlsx")
bajra_Coc

View(year_area_prod)
fig <-Bajra_MSP %>% 
  plot_ly(x=~Year,y=~`Pearl Millet (Bajra)`)
fig



p1 = Bajra_MSP %>% 
  plot_ly() %>% 
  add_lines(x=~Year,y=~`Pearl Millet (Bajra)`) %>% 
  layout(title = "Distribution chart Boxplot",
         xaxis = list(title="Maximum Selling Price"))
 



library(plotly)



#MSP-1 PLOTING  METER    Graphics pending DONE
fig <- plot_ly(
  type = "indicator",
  mode = "gauge+number+delta",
  value = 2250,
  title = list(text = "Maximum Selling Price", font = list(size = 30)),
  delta = list(reference =2000 , increasing = list(color = "RebeccaPurple")),
  gauge = list(
    axis = list(range = list(NULL, 3000), tickwidth = 1, tickcolor = "darkblue"),
    bar = list(color = "darkblue"),
    bgcolor = "white",
    borderwidth = 2,
    bordercolor = "gray",
    steps = list(
      list(range = c(0, 1500), color = "cyan"),
      list(range = c(1500,2500), color = "royalblue")),
    threshold = list(
      line = list(color = "red", width = 4),
      thickness = 0.75,
      value = 2250))) 
fig <- fig %>%
  layout(
    margin = list(l=20,r=30),
    paper_bgcolor = "lavender",
    font = list(color = "darkblue", family = "Arial"))

fig
install.packages("timetk")
library(timetk)



#MSP-2PLOTTING YEAR WISE   
p<- Bajra_MSP %>% 
  ggplot(aes(x=Year,y=`Pearl Millet (Bajra)`))+
  geom_line()+
  labs(x="Date",y="Minimum Support Price",title = "Minimum Support Price(MSP) Yearly Trend")+
  transition_reveal(Year)
view_follow(fixed_y = TRUE)
animate(p,nframe=144,fps=1)
animate(p,nframe=144,fps=10,width=800,height=500)
animate(p,nframe=144,fps=20)
anim_save('msp_gif',p)

#Area Production Line Graph   DONE

fig <- plot_ly(year_area_prod, x = ~Year,  mode = 'lines+markers')
fig<- fig %>%add_trace( y = ~Production,name="<b>Production</b>" , type = 'scatter', mode = 'lines+markers')
 fig<- fig %>%add_trace( y = ~Area, name="<b>Area</b> ",type = 'scatter', mode = 'lines+markers')
fig



#Pearl Millet (Bajra) Exports from India  line Graph






library(plotly)

df <- year_AP
fig <- df %>%
 filter( city %in% c("Area", "Production"))
fig <- fig %>% accumulate_by(~Year)


fig <- year_AP %>%
  plot_ly(
    x = ~Year, 
    y = ~median,
    split = ~city,
    frame = ~frame, 
    type = 'scatter',
    mode = 'lines', 
    line = list(simplyfy = F)
  )
fig <- fig %>% layout(
  xaxis = list(
    title = "Date",
    zeroline = F
  ),
  yaxis = list(
    title = "Median",
    zeroline = F
  )
) 
fig <- fig %>% animation_opts(
  frame = 100, 
  transition = 0, 
  redraw = FALSE
)
fig <- fig %>% animation_slider(
  hide = T
)
fig <- fig %>% animation_button(
  x = 1, xanchor = "right", y = 0, yanchor = "bottom"
)

fig








#PIE CHARTS 1 for production State wise
fig <- plot_ly(state_prod, labels = ~States , values = ~Production, type = 'pie',textinfo = 'label+percent')
fig <- fig %>% layout(title = '<b>Production of Bajra All Over India By States (in  Lakh Tonnes) <br>2010-11</br></b>',
                      xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                      yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

fig


#PIE CHARTS 2 for country export
fig <- plot_ly(piechart_country_export, labels = ~Country , values = ~Export, type = 'pie',textinfo = 'label+percent')
fig <- fig %>% layout(title = '<b>Export From India to Other Country in  Lakh Tonnes</b>',
                      xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                      yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

fig


p <- ggplot(
  bajra_Coc, 
  aes(x = Year, y=`Gross Returns`, size =Crop, colour = State)
) +
  geom_point(show.legend = FALSE, alpha = 0.7) +
  scale_color_viridis_d() +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  labs(x = "GDP per capita", y = "Life expectancy")
p
anim_save("bajra_coc.gif")

library(ggplot2)
library(gganimate)
theme_set(theme_bw())
library(gapminder)


p <- ggplot(
  gapminder, 
  aes(x = gdpPercap, y=lifeExp, size = pop, colour = country)
) +
  geom_point(show.legend = FALSE, alpha = 0.7) +
  scale_color_viridis_d() +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  labs(x = "GDP per capita", y = "Life expectancy")

p + transition_time(year) +
  labs(title = "Year: {frame_time}")
ile_renderer(dir = ".", prefix = "gganim_plot", overwrite = FALSE)

###########################################################

graph1 = Export_Country_Year %>%
  ggplot(aes(x=`Pearl Millet (Bajra)`, y=Year, color=Countries)) +
  geom_point(alpha = 0.7, stroke = 0) +
  theme_fivethirtyeight() +
  scale_size(range=c(2,12), guide="none") +
  scale_x_log10() +
  labs(title = "Life Expectancy vs GDP Per Capita by Country",
       x = "Income per person (GDP / capita)",
       y = "Life expectancy (years)",
       color = "Continent",
       caption = "Source: Gapminder") +
  theme(axis.title = element_text(),
        text = element_text(family = "Rubik"),
        legend.text=element_text(size=10)) +
  scale_color_brewer(palette = "Set2")

graph1.animation = graph1 +
  transition_time(Year) +
  labs(subtitle = "Year: {frame_time}") +
  shadow_wake(wake_length = 0.1)

animate(graph1.animation, height = 500, width = 800, fps = 30, duration = 10,
        end_pause = 60, res = 100)
anim_save("gapminder graph.gif")







# Cost of Cultivation of Pearl Millet (Bajra)



p<- plot_ly(
  data=bajra_Coc,
  y=~State,
  x=~`Total Cost`,
  type = "bar",
  name="Total Cost"
) %>% 
  add_trace(x=~`Gross Returns`,name="Gross Returns") %>% 
  layout(title = '<b>Cost of Cultivation By State</b>')


p<- plot_ly(
  data=bajra_Coc,
  x=~Year,
  y=~`Total Cost`,
  type = "bar",
  name="Total Cost"
) %>% 
  add_trace(y=~`Gross Returns`,name="Gross Returns") %>% 
 layout(title = '<b>Cost of Cultivation By Year</b>')










