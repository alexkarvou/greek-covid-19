library(shiny)
library(ggplot2)
library(shinydashboard)
library(leaflet)
library(sf)
library(here)
library(dplyr)

function(input, output, session) {

  vars<-reactiveValues(current_list=NULL)

  poleis<-st_read(here("shapefiles/poleis.shp"))
  poleis<-st_transform(poleis, 4326)
  poleis$NAME<-as.character(poleis$NAME)
  covid_data<-read.csv(here("data/greece.csv"))
  covid_data$NAME<-as.character(covid_data$NAME)
  df<-merge(poleis,covid_data,by='NAME')
  plot_df<-filter(df,INCIDENTS>0)
  hospitals<-read.csv(here("data/hospitals_of_interest.csv"))
  hospital_icon1 <- makeAwesomeIcon(icon = 'h-square', library = "fa", markerColor = "gray")
  hospital_icon2 <- makeAwesomeIcon(icon = 'h-square', library = "fa", markerColor = "white")

  output$mymap <- renderLeaflet({
    leaflet(plot_df) %>%
      addProviderTiles(providers$Esri.WorldGrayCanvas)%>%
      addCircleMarkers(radius = ~sqrt(INCIDENTS)*5 , popup = paste("Νομός", plot_df$DEPARTMENT, "<br>",
                                                                  "Περιστατικά:", plot_df$INCIDENTS, "<br>",
                                                                  "Θάνατοι:", plot_df$DEAD),
                                                    opacity=.9,group="Περιστατικα")%>%
      addAwesomeMarkers(data=filter(hospitals,TYPE=='Βασικό'),
                    lng=~LONG,
                    lat = ~LAT,
                    popup=~NAME,
                    icon=hospital_icon1,group='Βασικά Νοσοκομεία Αναφοράς')%>%
      addAwesomeMarkers(data=filter(hospitals,TYPE=='Αναπληρωματικό'),
                    lng=~LONG,
                    lat = ~LAT,
                    popup=~NAME,
                    icon=hospital_icon2,group='Αναπληρωματικά Νοσοκομεία Αναφοράς')%>%
      addLayersControl(
                overlayGroups = c("Περιστατικα",
                              "Βασικά Νοσοκομεία Αναφοράς",
                              "Αναπληρωματικά Νοσοκομεία Αναφοράς"))              



  })


  }
