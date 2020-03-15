library(shiny)
library(ggplot2)
library(shinydashboard)
library(timevis)
library(leaflet)


dashboardPage(skin='blue',
                    dashboardHeader(title = h3(tags$b('Greek Covid-19'))),
                    dashboardSidebar(
                      sidebarMenu(
                        menuItem("Dashboard", tabName = "dashboard", icon = icon("home")),
                        menuItem("News", tabName = "news", icon = icon("rss")),
                        menuItem("User entry", tabName = "measures", icon = icon("file-medical"))
                      )),
                    dashboardBody(
                      tabItems(
                        tabItem(tabName="dashboard",
                        fluidRow(
                              column(width=12,
                                     box(width=NULL,solidHeader = TRUE,
                                       leafletOutput("mymap")),
                                     infoBox("Επιβεβαιωμένα", 10 * 2, icon = icon("user-md"),color="purple"),
                                     infoBox("Ενεργα", 10 * 2, icon = icon("ambulance"),color='navy'),
                                     infoBox("Ξεπεράστηκαν", 10 * 2, icon = icon("heartbeat"),color='olive'),
                                     infoBox("Νεκροί", 10 * 2 ),color='red'))),
                        tabItem(tabName='news',h2('Nothing Yet'))
                      )))
