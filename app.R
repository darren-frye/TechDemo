library(shiny)

ui <- fluidPage(
  fluidRow(
    column(width = 12,
           align = "center",
           br(),
           h2("WHO WON THE 2019 NCAA MEN'S BASKETBALL NATIONAL CHAMPIONSHIP?"),
           h5("*click image"),
           br())
  ),
  fluidRow(
    column(width = 2),
    column(width = 3,
           imageOutput("TexasTech", height = 350,
                       click = "Texas_click",
                       dblclick = dblclickOpts(
                         id = "Texas_dblclick"
                       ),
                       hover = hoverOpts(
                         id = "Texas_hover"
                       )
           ),
           br()
    ),
    column(width = 2),
    column(width = 3,
           imageOutput("UVA", height = 350,
                       click = "UVA_click",
                       dblclick = dblclickOpts(
                         id = "UVA_dblclick"
                       ),
                       hover = hoverOpts(
                         id = "UVA_hover"
                       )
           ),
           br()
    )
  ),
  fluidRow(
    br(),
    column(width = 12,
           align = "center",
           uiOutput("HelpText"))
  )
)

server <- function(input, output, session) {
  
  values <- reactiveValues(Decision = "Undecided")
  
  observeEvent(input$Texas_click, {
    values$Decision <- "Wrong"
  })
  
  observeEvent(input$UVA_click, {
    values$Decision <- "Right"
  })
  
  output$TexasTech <- renderImage({
    img <- png::readPNG("www/TexasTechLogo.png")
    outfile <- tempfile(fileext = ".png")
    png::writePNG(img, target = outfile)
    
    list(
      src = outfile,
      contentType = "image/png",
      width = 350,
      height = 350,
      alt = "This is alternate text"
    )
  })
  
  output$UVA <- renderImage({
    img <- png::readPNG("www/UVALogo.png")
    outfile <- tempfile(fileext = ".png")
    png::writePNG(img, target = outfile)
    
    list(
      src = outfile,
      contentType = "image/png",
      width = 265,
      height = 350,
      alt = "This is alternate text"
    )
  })
  
  output$HelpText <- renderUI({
    if(values$Decision == "Right"){
      h3("Bennett to Win It")
    } else if(values$Decision == "Wrong"){
      h3("That is wrong. No. Bad. Try Again.")
    } else if(!is.null(input$Texas_hover)){
      h4("Cold. Very Very Cold. Try Again")
    } else if (!is.null(input$UVA_hover)) {
      h4("WARM. HOT. FIYA.")
    } else {
      return(NULL)
    }
  })

  
}

shinyApp(ui, server)