library(shiny)
library(ggplot2)
library(shinydashboard)
library(timevis)
library(leaflet)


dashboardPage(skin='blue',
                    dashboardHeader(title = h3(tags$b('Greek Covid-19'))),
                    dashboardSidebar(
                      sidebarMenu(
                        menuItem("Map", tabName = "map", icon = icon("calendar")),
                        menuItem("Gov measures", tabName = "measures", icon = icon("connectdevelop"))
                      )),
                    dashboardBody(
                      tabItems(
                        tabItem(tabName="map",fluidRow(
                              column(width=9,
                                     box(width=NULL,solidHeader = TRUE,
                                       leafletOutput("mymap")))))h2("CHURN RETENSION NOVEMBER - 2017")
                        tabItem(tabName="map",fluidRow(
                              column(width=9,
                                     box(width=NULL,solidHeader = TRUE,
                                       leafletOutput("mymap"))))),
                        tabItem(tabName='measures',h2('Nothing Yet'))
                      )))
