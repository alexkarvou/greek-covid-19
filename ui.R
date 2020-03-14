library(shiny)
library(ggplot2)
library(shinydashboard)
library(timevis)


dashboardPage(skin='blue',
                    dashboardHeader(title = h3(tags$b('Covid-19'))),
                    dashboardSidebar(
                      sidebarMenu(
                        menuItem("Metrics",tabName="annotator", icon= icon("pencil")),
                        menuItem("Map", tabName = "billboard", icon = icon("calendar")),
                        menuItem("Measures Updates", tabName = "calculations", icon = icon("connectdevelop"))
                      )),
                    dashboardBody(
                      tabItems(

                        tabItem(tabName='annotator',fluidRow(
                              column(width=9,
                                     box(width=NULL,solidHeader = TRUE,
                                       imageOutput('ImageRendering',
                                                   click = "plot_click",
                                                   dblclick = "plot_dblclick",
                                                   hover = "plot_hover",
                                                   brush = "plot_brush"),
                                        fluidRow(actionButton('previousButton','previous',
                                                              icon=icon('caret-left')),
                                                 actionButton('nextButton','Next',
                                                              icon=icon('caret-right'))),
                                        verbatimTextOutput('image_Name'),
                                        verbatimTextOutput('box_info'))),
                              column(width=3,
                              box(width=NULL,status='warning',
                              textInput('LoadFileInput','Load Images path'),
                              actionButton('loadButton','Load images'),
                              textInput("dbpath", "DB", value=" "),
                              actionButton('dbButton','Fetch Images'),
                              selectInput("annotationType",'Annotation Type:',
                                  choices=c('Rectangle','Polygon','Point')),
                              selectInput("pushType",'What to save:',
                                          choices=c('Annotations only','Both')),
                              actionButton('pushDB','Push to Database',
                                           icon=icon('database'))

                              )))),
                        tabItem(tabName = 'billboard',
                                timevisOutput("billboard")),
                        tabItem(tabName='calculations',h2('Nothing Yet'))
                      )))
