library(shiny)

# Define UI for random distribution application 
fluidPage(
  
  # Application title
  titlePanel("ReviewRadar"),
  
  # Sidebar with controls to select the random distribution type
  # and number of observations to generate. Note the use of the
  # br() element to introduce extra vertical spacing
  sidebarLayout(
    sidebarPanel(
      radioButtons("dist", "Distribution type:",
                   c("Normal" = "norm",
                     "Uniform" = "unif",
                     "Log-normal" = "lnorm",
                     "Exponential" = "exp")),
      br(),
      
      sliderInput("n", 
                  "Number of observations:", 
                  value = 500,
                  min = 1, 
                  max = 1000)
    ),
    
    # Show a tabset that includes a plot, summary, and table view
    # of the generated distribution
    mainPanel(
      tabsetPanel(type = "tabs", 
                  tabPanel("Sentiment",fluidRow(
                    column(6,plotOutput(outputId="plot", width="300px",height="300px")),  
                    column(6,plotOutput(outputId="plot2", width="300px",height="300px")), plotOutput("plot3")
                  )), 
                  tabPanel("Words", verbatimTextOutput("summary")), 
                  tabPanel("Topics", tableOutput("table"))
      )
    )
  )
)
