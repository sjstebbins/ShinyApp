library(dplyr)
library(stringr)

# set source and destination port latitude and longitudes
#read in ihs data
ihs <- read.csv("./Data/ihs.csv")
#fix date format func
ihs$Date <- as.Date(ihs$Date, format = "%m/%d/%Y")
ihs$C3 <- as.numeric(gsub(",", "", as.character(ihs$C3)))
ihs$C4 <- as.numeric(gsub(",", "", as.character(ihs$C4)))
#set volume based on C3 + C4
ihs$volume <- ihs$C3 + ihs$C4
#remove all rows where volume is 0
ihs <- ihs[as.numeric(ihs$volume) != 0, ]
# return((volume / max(volume, na.rm=TRUE)) * 4)
# Cut the volumes up into levels corresponding to the
# 75th, 50th, 25th, percentiles and then all the rest.
colors <- as.numeric(
  cut(ihs$volume,
      breaks=quantile(ihs$volume, probs=c(0,0.20,0.5,0.75,1), na.rm=TRUE),
      include.lowest=TRUE)
)
# Colors for each level
ihs$color <- c("#0055ff","#00aaff","#00ffaa","#aaff00")[colors]

# create variable with colnames as choice
themes <- c('Dark','Terrain')
