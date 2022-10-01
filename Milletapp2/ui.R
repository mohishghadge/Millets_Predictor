library(shiny)
library(shinydashboard)
library(shinythemes)


dashboardPage(title = 'Millet App',skin = "purple",
 dashboardHeader(title="BAJRA MILLETS",
                  titleWidth = 230,
                 tags$li(class="dropdown",tags$a(href="https://www.linkedin.com/in/mohish-ghadge-82a124216" ,icon("linkedin"), "My Profile", target="_blank")),
                 tags$li(class="dropdown",tags$a(href="https://github.com/mohishghadge", icon("github"), "Source Code", target="_blank"))
                 ),
 dashboardSidebar(
   sidebarMenu(id = "sidebar",
               menuItem("Dataset", tabName = "data", icon = icon("database")),
               menuItem("Visualization", tabName = "viz", icon=icon("chart-line")),
               # Conditional Panel for conditional widget appearance
               # Filter should appear only for the visualization menu and selected tabs within it
               #conditionalPanel("input.sidebar == 'viz' && input.t2 == 'ap_line'", selectInput(inputId = "var1" , label ="Select the Variable" , choices = c1)),
               # conditionalPanel("input.sidebar == 'viz' && input.t2 == 'trends' ", selectInput(inputId = "var2" , label ="Select the Arrest type" , choices = c2)),
               # conditionalPanel("input.sidebar == 'viz' && input.t2 == 'relation' ", selectInput(inputId = "var3" , label ="Select the X variable" , choices = c1, selected = "Rape")),
               # conditionalPanel("input.sidebar == 'viz' && input.t2 == 'relation' ", selectInput(inputId = "var4" , label ="Select the Y variable" , choices = c1, selected = "Assault")),
               
               menuItem("Prediction", tabName = "predict", icon=icon("glyphicon glyphicon-grain", lib = "glyphicon"))
               
   )
 ),
 
 
 dashboardBody(
   tags$head(
     tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")),
   tabItems(
     ## First tab item
     tabItem(tabName = "data", 
             tabBox(id="t1", width = 12, 
                    tabPanel("About", icon=icon("address-card"),
                             fluidPage(theme = shinytheme("united"),
                             fluidRow(
                               column(width= 12 ,tags$img(src="landing_page.jpg", width =1600 , height = 885),
                                      
                                      )
                       
                             )
                             )
                             
                             
                    ), 
                    tabPanel("Data", dataTableOutput("dataT"), icon = icon("table")), 
                    tabPanel("Structure", verbatimTextOutput("structure"), icon=icon("uncharted")),
                    tabPanel("Summary Stats", verbatimTextOutput("summary"), icon=icon("chart-pie"))
             )
             
     ),  
     
     
     # Second Tab Item
     tabItem(tabName = "viz", 
             tabBox(id="t2",  width=12, 
                    
                    
                    
                    tabPanel("Area/Production", value="ap_line",
                             withSpinner(plotlyOutput("ap_line")),
                             fluidRow(
                               column(width = 4, tags$br() ,
                                      tags$p(tags$b(tags$h3("Pearl Millet (Bajra) Production in India"),
                                                    "Pearl Millet (Bajra) production stood at 92.09 lakh metric tonnes from 
                                                    the cultivated area of 74.81 Lakh hectares in the year 2017-18."))
                               )
                             )),
                  

                    
                    tabPanel("Cost Of Cultivation", value="coc", 
                             
                             fluidRow(
                               tabBox(
                                 tabPanel(box
                                          (title = "Cost of Cultivation By State ",status = "primary",solidHeader = TRUE,collapsed = TRUE,width=500),
                                          withSpinner(plotlyOutput("coc_state")),
                                          fluidRow(
                                            column(width = 4, tags$br() ,
                                                   tags$p(tags$b(tags$h3("The Total Cost incurred in One Acer Peral Millet Cultivation"),
                                                                 "In the cultivation of one acre pearl millet crop farmer need to spend around",tags$br(
                                                                 "Rs.11,308 on various aspects of farming.")))    
                                            )
                                          )),
                                 
                                 tabPanel(
                                   box
                                   (title = "Cost of Cultivation By Year",status = "primary",solidHeader = TRUE,collapsed = TRUE,width=500),
                                          withSpinner(plotlyOutput("coc_year")),
                                          fluidRow(
                                            
                                            column(width = 4, tags$br() ,
                                                   tags$p(tags$b(tags$h3("The Total Cost incurred in One Acer Peral Millet Cultivation"),
                                                                 "In the cultivation of one acre pearl millet crop farmer need to spend around ",tags$br(
                                                                 "Rs.11,308 on various aspects of farming.")))    
                                                   ))
                             ),
                             
                             
                            
                             tabPanel(
                               
                               box(
                                 title = "Cost of Cultivation By Net Returns",status = "primary",solidHeader = TRUE,collapsed = TRUE,width=500),
                               withSpinner(plotlyOutput("coc_ngt_bar")),
                               fluidRow(
                                 
                                 column(width = 4, tags$br() ,
                                        tags$p(tags$b(tags$h3("The total Bajra cultivation income from 1-acre plantation"),
                                                      "The minimum support price for Pearl millet for the year 2018-19 is Rs.2250. 
                                                      The average yield in one acre is 14 quintals. 
                                                      Then total gross income is Rs.28,000.Net profit involved in pearl millet 
                                                      cultivation in 1 acre land is 28,000 - 11,308 = ",tags$u("Rs.16,692")))  
                                 ))
                             ), tabPanel(
                               box
                               (title = "Another Cost of Cultivation By Net/Gross Returns ",status = "primary",solidHeader = TRUE,collapsed = TRUE,width=500),
                               withSpinner(plotlyOutput("coc_ngt_line")),
                               fluidRow(
                                 
                                 column(width = 4, tags$br() ,
                                        tags$p(tags$b(tags$h3("The total Bajra cultivation income from 1-acre plantation"),
                                                      "The minimum support price for Pearl millet for the year 2018-19 is Rs.2250. 
                                                      The average yield in one acre is 14 quintals. 
                                                      Then total gross income is Rs.28,000.Net profit involved in pearl millet 
                                                      cultivation in 1 acre land is 28,000 - 11,308 = ",tags$u("Rs.16,692")))
                                 ))
                             ),
                             width = 200,height = 500,))
                             ), 
                            
                    
                    
                    tabPanel("Exports", id="exp_pie",
                             
                             fluidRow(
                               tabBox(
                                 tabPanel(box(title = "Export from India ",status = "primary",solidHeader = TRUE,collapsed = TRUE,width=500),
                                          withSpinner(plotlyOutput("export_pie")),
                                          fluidRow(
                                            column(width = 4, tags$br() ,
                                                   tags$p(tags$b(tags$h3("Pearl Millet (Bajra) Exports from India"),
                                                                 "India exported 59.85 Lakh Tonnes of Pearl Millet (Bajra) in the year 2019-20."))
                                            )
                                          )),
                                 
                                 tabPanel(box(title = "Export Trend",status = "primary",solidHeader = TRUE,collapsed = TRUE,width=500),
                                          withSpinner(plotlyOutput("export_line")),
                                          fluidRow(
                                            column(width = 4, tags$br() ,
                                                   tags$p(tags$b(tags$h3("Pearl Millet (Bajra) Exports from India"),
                                                                 "India exported 59.85 Lakh Tonnes of Pearl Millet (Bajra) in the year 2019-20."))
                                            )
                                          )),width = 200,height = 500,
                                 
                               )
                             )),
                             
                    
                    tabPanel("MSP", id="meter",  
                             fluidRow(
                              tabBox(
                                 tabPanel(box(title = "Minimum Support Price Meter",status = "primary",solidHeader = TRUE,collapsed = TRUE,width=500),
                                          withSpinner(plotlyOutput("MSP_meter")),
                                          fluidRow(
                                            column(width = 4, tags$br() ,
                                                   tags$p(tags$b(tags$h3("Minimum Support Price in India 2022-2023"),
                                                                 "The minimum support price (MSP) of bajra has been fixed at Rs 2,350 per quintal"))
                                            )
                                          )),
                                 
                               tabPanel(box(title = "Minimum Support Price Trend",status = "primary",solidHeader = TRUE,collapsed = TRUE,width=500), withSpinner(plotlyOutput("msp_line")),
                                   fluidRow(
                                     column(width = 4, tags$br() ,
                                            tags$p(tags$b(tags$h3("Minimum Support Price in India 2022-2023"),
                                                          "The minimum support price (MSP) of bajra has been fixed at Rs 2,350 per quintal"))
                                     )
                                   )),width = 200,height = 500,
                             
                           )
                            )),
                    
                    
                    tabPanel("Production-Top States", value="relation",
                             withSpinner(plotlyOutput("prod_top_state")),
                             fluidRow(
                               column(width = 4, tags$br() ,
                                      tags$p(tags$b(tags$h3("Leading States in Pearl Millet (Bajra) Production in India"),
                                              "Rajasthan accounts for 44% of Pearl Millet (Bajra)            
                                             produced in India. UP, Haryana, Maharashtra, & Gujarat are the next major producers
                                             contributing 15%. 11.4%, 10.8%, & 10.5% respectively."))
                               )
                             )),
                    side = "left"
             ),#tabbox end
             
     ),#tabitem end
     
     
     # Third Tab Item
     tabItem(tabName = "predict",
     fluidPage(theme = shinytheme("united"),
       fluidRow(column(width = 12 ,
                       tabBox(id="t3",  width=12,
                              tabPanel("Production Prediction",value="relation",

                                       sidebarPanel(width = 12,
                                         #HTML("<h3>Input parameters</h3>"),
                                         tags$label(h3('Input parameters')),
                                         numericInput("Year",
                                                      label = "Year",
                                                      value = 2023),

                                         selectInput("State" ,
                                                     label ="Select the State" ,
                                                     choices = c3),

                                         numericInput("Area",
                                                      label = "Area (in Lakh Hectares)",
                                                      value = 10000),


                                         actionButton("submitbutton", "Submit",
                                                      class = "btn btn-primary")

                                       ),

                                       mainPanel(width = 12,
                                         tags$label(h3('Status/Output')), # Status/Output Text Box
                                         verbatimTextOutput('contents'),
                                         tableOutput('tabledata') # Prediction results table


                                       )

                              ),#tabpanel1
                              
                              tabPanel("Net Returns Prediction",value="relation",
                                       sidebarPanel(width = 12,
                                                    #HTML("<h3>Input parameters</h3>"),
                                                    tags$label(h3('Input parameters')),
                                                    # numericInput("Year",
                                                    #              label = "Year",
                                                    #              value = 2023),

                                                    # selectInput("State",
                                                    #             label ="Select the State",
                                                    #             choices = c4),

                                                    numericInput("TotalCost",
                                                                 label = "Total Cost(in Rs)",
                                                                 value = 10000),
                                                    numericInput("GrossReturns",
                                                                 label = "Gross Returns of last year(in Rs) ",
                                                                 value = 10000),

                                                    numericInput("MSP",
                                                                 label = " Current Minimum Support Price is:[Note: MSP should be equal to or more than 2250]",
                                                                 value = 2250),

                                                    actionButton("submitbutton1", "Submit",
                                                                 class = "btn btn-primary")

                                       ),

                                       mainPanel(width = 12,
                                                 tags$label(h3('Status/Output')), # Status/Output Text Box
                                                 verbatimTextOutput('contentslmn'),
                                                 tableOutput('tabledatalmn') ,# Prediction results table
                                                # verbatimTextOutput('quest')
                                                  )
                                      ),
                              



                              ),#end of Tabbox
                       )
         
                 
       ),
       
      
     
     ))
     
     )
     
     
     )
   )
 
