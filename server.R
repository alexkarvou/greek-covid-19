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

  observeEvent(input$previousButton,{
    if (vars$local_image_index>1){
      vars$local_image_index<-vars$local_image_index -1}
  })

  observeEvent(input$loadButton,{
    vars$local_folder_length<-length(list.files(input$LoadFileInput))
  })

  local_image_path<-eventReactive(c(input$loadButton,input$nextButton,input$previousButton),{
    paste(input$LoadFileInput,"/",list.files(input$LoadFileInput)[vars$local_image_index],sep="")
  })




  observeEvent(c(input$loadButton,input$nextButton,input$previousButton),{
    output$ImageRendering<-renderImage({


      filename<-local_image_path()

      width  <- session$clientData$output_ImageRendering_width
      height <- session$clientData$output_ImageRendering_height

      list(src = filename,
           width=width,height=height,
           alt = paste("Couldnt load image"))

    },deleteFile = FALSE)})


  observeEvent(input$loadButton,{
    output$image_Name<-renderText({
      paste(list.files(input$LoadFileInput)[vars$local_image_index],", #",as.character(vars$local_image_index)," of ",
            as.character(vars$local_folder_length)," Images.")
      })
  })

  observeEvent(input$plot_brush,{
    vars$current_list<-c(input$plot_brush$xmin,input$plot_brush$ymin,input$plot_brush$xmax,input$plot_brush$ymax)
  })

  output$box_info<-renderText({paste(names(input$plot_brush))})

  #billboard outputs
  output$billboard <- renderTimevis({
    timevis(data)
  })


  }
