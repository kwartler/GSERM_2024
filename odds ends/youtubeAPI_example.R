#' Title: Grab Youtube JSON
#' Purpose: Demonstrate f12 in Chrome for API
#' Author: Ted Kwartler
#' email: edwardkwartler@fas.harvard.edu
#' Date: June 12, 2024
#'

# Libraries
library(jsonlite)
library(stringr)
library(plyr)

# Youtube URL
#https://www.youtube.com/watch?v=5F-o2_AC-Wo
youtubeCaption <- 'https://www.youtube.com/api/timedtext?v=5F-o2_AC-Wo&ei=CcZpZsbmOPKI6dsPj8i_2AM&caps=asr&opi=112496729&xoaf=5&hl=en&ip=0.0.0.0&ipbits=0&expire=1718233209&sparams=ip%2Cipbits%2Cexpire%2Cv%2Cei%2Ccaps%2Copi%2Cxoaf&signature=0184B1C991D37F75BA42994B4EA21CD3F928B2D2.06B51552DCFDE6AD8B2A6AC4CD0A3C274010E0FC&key=yt8&kind=asr&lang=en&fmt=json3&xorb=2&xobt=3&xovt=3&cbrand=apple&cbr=Chrome&cbrver=125.0.0.0&c=WEB&cver=2.20240611.01.00&cplayer=UNIPLAYER&cos=Macintosh&cosver=10_15_7&cplatform=DESKTOP'

# Go get the data
dat <- fromJSON(youtubeCaption)

# closed captioning data
dat$events$tStartMs
dat$events$dDurationMs
dat$events$segs

# Get each first column called utf8
rawTxt <- lapply(dat$events$segs, "[", 'utf8') 

# organize just the single column
rawTxt <- do.call(rbind, rawTxt)

# Drop line returns "\n"
rawTxt <- gsub('[\r\n]','',rawTxt[,1])

# Now there are entries that are empty so they need to be dropped
head(rawTxt,10)
rawTxt <- rawTxt[nchar(rawTxt) != "0"]
head(rawTxt,10)

# Get rid of extra spacing on certain words
rawTxt <- str_squish(rawTxt)
head(rawTxt,10)
rawTxt <- paste(rawTxt, collapse = ' ')

# Save as a text file
#writeLines(rawTxt, 'sometext.txt')

# If you want to retain the meta data
timedTxt <- lapply(dat$events$segs, "[", 'utf8')

allTxt <- list()
for (i in 1:length(timedTxt)){
  x <- paste(timedTxt[[i]][,1], collapse ='')
  allTxt[[i]] <- x
}

# Drop line breaks embedded within text and standalone rows
text<-str_replace_all(allTxt, "[\n]" , "")

# Organize
textDF <- data.frame(startTime = dat$events$tStartMs/1000,
                     duration  = dat$events$dDurationMs/1000,
                     text = text)

# 
textDF<-  textDF[nchar(textDF$text) !=0,]

# Examine to make sure format is ok
head(textDF, 10)

# Save
#write.csv(textDF, 'timedText2.csv', row.names = F)
# End
