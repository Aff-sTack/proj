library(shiny)
library(ECharts2Shiny)
library(shinyWidgets)
library(shinyalert)

alert <- fluidPage(
  useShinyalert(),
  actionButton("btn", "Mostrar Numeros")
  
)

seg <- fluidPage(
  column(
    width = 12,
    tags$b("Progresso de Vacincao no Brasil"), br(),
    progressBar("pb1", value = 0),
    sliderInput("up1","Porcentagem de Milhares de Vacinados no Brasil",min = 0,max = 100,value = 50
    )
  )
)

imga <- fluidPage(
  sidebarLayout(
    sidebarPanel(),
    mainPanel(
      tags$img(src="coronav.jpg", height=180, width=230)
    )
  )
)

plot <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      sliderInput("sliderId", "Selecione a quantidade de numeros", min = 100, max = 1000, value = 200)
    ),
    mainPanel(
      plotOutput("graficoHist")
    )
  )
)


ui <- fluidPage(
  
  tags$img(src="coronav.jpg", height=50, width=70),
  
  loadEChartsLibrary(),
  loadEChartsTheme('shine'),
  loadEChartsTheme('vintage'),
  loadEChartsTheme('dark-digerati'),
  loadEChartsTheme('roma'),
  loadEChartsTheme('infographic'),
  loadEChartsTheme('macarons'),
  loadEChartsTheme('caravan'),
  loadEChartsTheme('jazz'),
  loadEChartsTheme('london'),
  
  tags$h1("GRAFICOS DE CASOS DE CORONAVIRUS NA REGIAO DE SUL DE MINAS", style = "text-align:center"),
  tags$br(),
  tags$br(),
  
  
  tags$h3("NUMEROS DE MORTOS NA CIDADES DE SUL DE MINAS", style = "text-align:center"),
  tags$br(),
  tags$br(),
  tags$br(),
  
  fluidRow(
    column(6,
           tags$div(id="test_1", style="width:100%;height:300px;"),
           deliverChart(div_id = "test_1")
    ),
    column(6,
           tags$div(id="test_2", style="width:100%;height:300px;"),
           deliverChart(div_id = "test_2")
    )
  ),
  tags$br(),
  tags$br(),
  tags$h3("BARRA DE PROGRESSO DE VACINADOS NO BRASIL ", style = "text-align:center"),
  tags$br(),
  tags$br(),
  tags$br(),
  seg,
  tags$br(),
  tags$br(),
  tags$h3("NUMERO ATUALIZADO DE VACINADOS NO BRASIL CONTRA CORONAVIRUS ", style = "text-align:center"),
  tags$br(),
  tags$br(),
  tags$br(),
  alert,
  tags$h3("SELECIONE A QUANTIDADE DE NUMEROS PARA VER NO GRAFICO", style = "text-align:center"),
  tags$br(),
  tags$br(),
  tags$br(),
  plot
)

dat_1 <- c(rep("Pouso Alegre - MG", 100),
           rep("Itajuba - MG", 50),
           rep("Alfenas - MG", 25))


dat_2 <- data.frame(c(5, 4, 10, 6),
                    c(10, 15, 20, 5),
                    c(20, 40, 30, 10))

names(dat_2) <- c("Alfenas - MG", "Itajuba - MG", "Pouso Alegre - MG")
row.names(dat_2) <- c("Prim. 3 meses", "Seg. 6 meses", "Terc. 9 meses", "Quart. 12 meses")

server <- function(input, output, session) {
  
  renderPieChart(div_id = "test_1", data = dat_1, theme = "roma", radius = "90%")
  
  renderLineChart(div_id = "test_2", theme = "shine", data = dat_2)
  
  observeEvent(input$up1, {
    updateProgressBar(
      session = session,
      id = "pb1",
      value = input$up1
    )
  })
  observeEvent(input$go, {
    for (i in 1:50) {
      updateProgressBar(
        session = session,
        id = "pb2",
        value = i, total = 50,
        title = paste("Progresso")
      )
      Sys.sleep(0.5)
    }
  })
  
  observeEvent(input$btn, {
    shinyalert(title = "6.422.545 Pessoas") 
  })
  
  output$graficoHist <- renderPlot({hist(sample(input$sliderId))})
  
}

shinyApp(ui, server)
