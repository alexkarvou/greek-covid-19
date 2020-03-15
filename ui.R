library(shiny)
library(ggplot2)
library(shinydashboard)
library(timevis)
library(leaflet)


dashboardPage(skin='blue',
                    dashboardHeader(title = h3(tags$b('Greece - Covid-19'))),
                    dashboardSidebar(
                      sidebarMenu(
                        menuItem("Αρχική", tabName = "dashboard", icon = icon("home")),
                        menuItem("Εισαγωγή συμπτωμάτων", tabName = "entries", icon = icon("clipboard")),
                        menuItem("Νέα", tabName = "news", icon = icon("rss"))

                      )),
                    dashboardBody(
                      tabItems(
                        tabItem(tabName="dashboard",
                        fluidRow(
                              column(width=12,
                                     box(width=NULL,solidHeader = TRUE,
                                       leafletOutput("mymap")),
                                     box(
                                     infoBox("Επιβεβαιωμένα", 0, icon = icon("user-md"),color="purple"),
                                     infoBox("Ενεργα", 0, icon = icon("ambulance"),color='navy'),
                                     infoBox("Ξεπεράστηκαν",0, icon = icon("heartbeat"),color='olive'),
                                     infoBox("Νεκροί", 0 ,color='red'))))),
                        tabItem(tabName='entries',
                        fluidRow(
                              column(width=12,
                                     box(width=NULL,solidHeader = TRUE,
                                       selectInput("choice_1",'Τον έχεις:',
                                          choices=c('Ναι','Οχι')),
                                       actionButton('push_entry','Καταχώρηση',
                                           icon=icon('database')))))),
                        tabItem(tabName='news',h2('Nothing Yet')))))
