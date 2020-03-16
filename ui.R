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
                        menuItem("Εισαγωγή συμπτωμάτων", tabName = "entries", icon = icon("clipboard"))

                      )),
                    dashboardBody(
                      tabItems(
                        tabItem(tabName="dashboard",
                        fluidRow(
                              column(width=12,
                                     box(width=NULL,solidHeader = TRUE,
                                       leafletOutput("mymap")),
                                     infoBox("Επιβεβαιωμένα", 0, icon = icon("user-md"),color="purple"),
                                     infoBox("Ενεργα", 0, icon = icon("ambulance"),color='navy'),
                                     infoBox("Ξεπεράστηκαν",0, icon = icon("heartbeat"),color='olive'),
                                     infoBox("Νεκροί", 0 ,color='red')))),
                        tabItem(tabName='entries',
                        fluidRow(
                              column(width=6,
                                     box(width=NULL,solidHeader = TRUE,
                                          tags$head(
                                        tags$style(HTML("

                                        .selectize-input {
                                          height: 50px;
                                          width: 600px;
                                          font-size: 24pt;
                                          padding-top: 5px;
                                        }

                                        "))
                                        )
                                        checkboxGroupInput("symptomsGroup",
                                        h3("Ποιό/α από τα παρακάτω συμπτώματα εμφανίζετε;"),
                                        choices = list("υψηλός η πολύ υψηλός πυρετός για πάνω από 6 ωρες μεταξύ τους απόσταση" = "υψηλός η πολύ υψηλός πυρετός για πάνω από 6 ωρες μεταξύ τους απόσταση",
                                                       "βηχας εντονος" = "βηχας εντονος",
                                                       "πονος στο στηθος" = "πονος στο στηθος",
                                                       "δυσπνοια"="δυσπνοια"),
                                        selected = 0))
                                      ,
                                       actionButton('push_entry','Καταχώρηση',
                                           icon=icon('database'))),
                               column(width=6,
                                      box(width=NULL,solidHeader = TRUE,

                                         checkboxGroupInput("vulnerableGroup",
                                         h3("Ανήκετε σε κάποια ευπαθή ομάδα;"),
                                         choices = list("Μεγαλύτερη/ος από 70 ετών" = "Μεγαλύτερη/ος από 70 ετών",
                                                        "Χρόνια αναπνευστικά νοσήματα" = "Χρόνια αναπνευστικά νοσήματα",
                                                        "Χρόνια καρδιαγγειακά νοσήματα" = "Χρόνια καρδιαγγειακά νοσήματα",
                                                        "Σακχαρώδη διαβήτη"="Σακχαρώδη διαβήτη",
                                                        "χρόνιες καταστάσεις ανοσοκαταστολής"="χρόνιες καταστάσεις ανοσοκαταστολής"),
                                         selected = 0))))),
                        tabItem(tabName='news',h2('Nothing Yet')))))
