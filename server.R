library(shiny)
library(ggplot2)
library(shinydashboard)
library(timevis)


function(input, output, session) {

  #annotator things
  vars<-reactiveValues(local_image_index=1,local_folder_length=0,current_list=NULL)


  observeEvent(input$nextButton,{
    if (vars$local_image_index<vars$local_folder_length){
      vars$local_image_index<-vars$local_image_index +1}
  })


  output$mymap <- renderLeaflet({
    leaflet() %>%
    addTiles() %>%  # use the default base map which is OpenStreetMap tiles
    addMarkers(lng=23.7275, lat=37.9838,
               popup="Greek Covid-19 incidents")
  })


  }
