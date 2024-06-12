#' Title: Webscraping a single page
#' Purpose: Scrape a single page example
#' Author: Ted Kwartler
#' email: edwardkwartler@fas.harvard.edu
#' Date: June 12, 2024
#'

# libraries
library(rvest)

# webpage to webscrape
pg <- read_html('https://rvest.tidyverse.org/articles/starwars.html')

# Helpful code:
pg %>% html_nodes("*") %>% html_attr("class") %>% unique() #all unique named nodes
pg %>% html_nodes("a") %>% html_attr("href") %>% unique()#all unique Links 

# You can get one section with the explicit xpath code
firstSection <- pg %>% html_nodes(xpath = '//*[@id="main"]/section[1]') %>% html_text()
cat(firstSection)

# If the CSS (cascading style sheet) uses named entities you can get them by name
allSections <- pg %>% html_nodes('section')
allSections #notice the h2 header, lets get those!

# Movie names
movieNames <- allSections %>% html_node('h2') %>% html_text(trim = TRUE)
movieNames

# One release date example using xpath
pg %>% html_nodes(xpath = '//*[@id="main"]/section[1]/p[1]') %>% html_text(trim = TRUE)

# Needed gpt for this :)
# Since every section has a h2 name and the release date is next 
# you have to first search for the h2 header and get the very next node.
releaseDates <- pg %>% html_nodes(xpath = '//h2/following-sibling::p[1]') %>% html_text(trim = TRUE)
releaseDates

# Similarly now to get all the text for each section
# //section is all sections
# //p is all paragraphs
# positions() > 1 means all paragraphs after the first because that's the release date
movieInfo <- pg %>% html_nodes(xpath = '//section//p[position() > 1]') %>% html_text(trim = TRUE)

# Needs some cleanup
length(movieInfo)
length(releaseDates)

# Since each section has "Director" we can reorganize the section text
idx <- cumsum(grepl("Director:", movieInfo)) # Get a running total of the split word
idx #these are now the section groups!
movieInfo <- data.frame(id = idx, text  = movieInfo)
movieInfo[1:2,]
movieInfo <- aggregate(text ~id, movieInfo, paste, collapse = ' ')
movieInfo[1,]

# Final organization
finalDF <- data.frame(name = movieNames, 
                      releaseDate = releaseDates,
                      movieInfo = movieInfo$text)
finalDF[1,]

# Get a table of information
# https://en.wikipedia.org/wiki/List_of_S%26P_500_companies
sp500 <- read_html('https://en.wikipedia.org/wiki/List_of_S%26P_500_companies') %>%
  html_nodes('#constituents') %>% html_table() %>% as.data.frame()
head(sp500)

# End