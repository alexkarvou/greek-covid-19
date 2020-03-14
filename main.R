library(shiny)
library(shinydashboard)
library(timevis)


data <- data.frame(
  id      = 1:4,
  content = c("Item one", "Item two",
              "Ranged item", "Item four"),
  start   = c("2016-01-10", "2016-01-11",
              "2016-01-20", "2016-02-14 15:00:00"),
  end     = c(NA, NA, "2016-02-24", NA)
)

ui <- dashboardPage(skin='blue',
                    dashboardHeader(title = h3(tags$b('Athen'))),
                    dashboardSidebar(
                      sidebarMenu(
                        menuItem("Annotator",tabName="annotator", icon= icon("pencil")),
                        menuItem("Billboard", tabName = "billboard", icon = icon("calendar")),
                        menuItem("Calculations", tabName = "calculations", icon = icon("connectdevelop"))
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

server <- function(input, output, session) {

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
shinyApp(ui, server)
