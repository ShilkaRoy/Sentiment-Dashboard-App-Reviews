#Read Reviews
library(cldr)
library(shiny)
library(gridExtra)
library(grid)
Revs <- read.csv('/Users/sroy13/Downloads/Google-Play-Store-Review-Extractor-master/MyO2_reviews_list.csv')[,2:4]
Revs_Go <- read.csv('/Users/sroy13/Downloads/Google-Play-Store-Review-Extractor-master/GO-JEK_reviews_list_go.csv')[,2:4]

num_rev <- nrow(Revs)
Lang_Matrix <- detectLanguage(Revs$Review.Text, isPlainText = TRUE)


###------Dial Gague Plot -------###
gg.gauge <- function(pos,breaks=c(0,30,70,100)) {
  require(ggplot2)
  get.poly <- function(a,b,r1=0.5,r2=1.0) {
    th.start <- pi*(1-a/100)
    th.end   <- pi*(1-b/100)
    th       <- seq(th.start,th.end,length=100)
    x        <- c(r1*cos(th),rev(r2*cos(th)))
    y        <- c(r1*sin(th),rev(r2*sin(th)))
    return(data.frame(x,y))
  }
  ggplot()+ 
  geom_polygon(data=get.poly(breaks[1],breaks[2]),aes(x,y),fill="red")+
    geom_polygon(data=get.poly(breaks[2],breaks[3]),aes(x,y),fill="gold")+
    geom_polygon(data=get.poly(breaks[3],breaks[4]),aes(x,y),fill="forestgreen")+
    geom_polygon(data=get.poly(pos-1,pos+1,0.2),aes(x,y))+
    geom_text(data=as.data.frame(breaks), size=5, fontface="bold", vjust=0,
              aes(x=1.1*cos(pi*(1-breaks/100)),y=1.1*sin(pi*(1-breaks/100)),label=paste0(breaks,"%")))+
    annotate("text",x=0,y=0,label=pos,vjust=0,size=8,fontface="bold")+
    coord_fixed()+
    theme_bw()+
    theme(axis.text=element_blank(),
          axis.title=element_blank(),
          axis.ticks=element_blank(),
          panel.grid=element_blank(),
          panel.border=element_blank()) 
}
# Define server logic for random distribution application
function(input, output) {
  
# functions defined below then all use the value computed from
# this expression
data <- reactive({
dist <- switch(input$dist,
                   norm = rnorm,
                   unif = runif,
                   lnorm = rlnorm,
                   exp = rexp,
                   rnorm)
    
    dist(input$n)
  })
  
  # Generate a plot of the data. Also uses the inputs to build
  # the plot label. Note that the dependencies on both the inputs
  # and the data reactive expression are both tracked, and
  # all expressions are called in the sequence implied by the
  # dependency graph
  output$Plot_Gague <- renderPlot({
    
    barplot(WorldPhones[,input$region]*1000, 
            main=input$region,
            ylab="Number of Reviews",
            xlab="Sentiment")
  })
  output$plot <- renderPlot({
    gg.gauge(52,breaks=c(0,30,70,100))+ labs(title = "Sentiment Quotient") + theme(plot.title = element_text(hjust = 0.5))
  })
  
  output$plot2 <- renderPlot({
    gg.gauge(avg_rating,breaks=c(0,30,70,100))+ labs(title = "Average Rating") + theme(plot.title = element_text(hjust = 0.5))
  })
  
  output$plot3 <- renderPlot({
    barplot(table(rev_results$satisfaction_score), col = c("mistyrose","cornsilk","darkolivegreen3"), xlab ="Sentiment", ylab='# Reviews', axes=TRUE)
  })

}