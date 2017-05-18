rev_results <- read.csv("results.csv", stringsAsFactors = FALSE,)

avg_rating = round(mean(rev_results$rating_review)*20, 2)

a<- barplot(table(rev_results$satisfaction_score), col = c("mistyrose","cornsilk","darkolivegreen3"), xlab ="Sentiment", ylab='# Reviews', axes=TRUE)

##---- Topics ---##
table(rev_results$tag)
