#' Examine Top Songs by Year
#' TK
#' June 8, 2024
#' Instructions:
#' 1. Complete the script based on the comments
#' 2. Create THREE slides for your submission in addition to the script
#' 2a. Slide 1: explain the high level process & challenges of NLP including your description of the workflow, the data organization structure, define corpus, stopwords, bigrams and TF-IDF
#' 2b. Slide 2+: add your visuals from the code you created, and add a title that may be an insight gained from the visual or output of your code (may not be that insightful in some cases but try)
#' 2c. Slide 3: Create a slide with bullet points for how these methods may be useful in your research.  If you are not planning on using them, instead add 3 takeaways of topics, concepts you didn't know before the course but found interesting.  If you found nothing interesting, then make them up :)
#' GRADING: Completing these instructions full is acceptable (5), exploring bigrams, and/or tfidf is more complex (5.5), and you could apply an unsupervised or supervised approach to understand topics or make a model to classify a decade's lyrical style (6)

# Libs


# Custom Functions - cleaning and to lower




# Stop words
stops <- c(stopwords('en'))

# Load the data
songs <- read.csv('https://raw.githubusercontent.com/kwartler/GSERM_2024/main/assignment/all_songs_data_processed_assignment.csv')

# Remove the data author's non-ascii characters
songs$Lyrics <- iconv(songs$Lyrics, to = "ASCII", sub = " ")

# Append a decade grouping
songs$decade <- (songs$Year %/% 10) * 10 

# Select one decade - for example 1990s
songs90 <- subset(songs, songs$decade == 1990)

# Select one decade - for example 2010s


# Make a volatile corpus for each


# Preprocess the corpus


# Make a DTM


# Simple Bar Chart Frequency


# Dendrogram for 1990s HINT: removeSparseTerms(some_DTM, .85)


# Association with the term LOVE in either DTM; use a cutoff that has 35 or more values


# Simple Word Cloud


# Commonality Cloud among all songs


# Comparison Cloud between decades


# Pyramid Plot between two decades



# Sentiment for all the songs as a group or by decade
# easiest is probably function analyzeSentiment()


# End