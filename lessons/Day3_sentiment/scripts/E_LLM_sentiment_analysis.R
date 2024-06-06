#' Title: Intro: LLM Based Sentiment
#' Purpose: Sentiment using a local LLM
#' Author: Ted Kwartler
#' Date: May 12, 2024
#' Sources explore: https://www.kaggle.com/datasets/columbine/imdb-dataset-sentiment-analysis-in-csv-format
#'https://www.cs.cornell.edu/people/pabo/movie-review-data/


# Libraries
library(httr)
library(jsonlite)

# Path to files 
pth <- '~/Desktop/GSERM_2024/lessons/Day3_sentiment/data/review_polarity/txt_sentoken'

tmp <- list.files(path = pth, 
                  recursive = T,
                  full.names = T)

# One single review
llmModel <- 'lmstudio-ai/gemma-2b-it-GGUF'

# One Review
oneReview <- paste(readLines(tmp[42]), collapse = '/n')

# Prompt and task
prompt <- paste('Please review this moview review and specify the author\'s sentiment.  Here is an example review :\n',
                oneReview,
                'Your example response would be:\n```Sentiment:Frustration\nPolarity:Neutral```\n\n')

# Organize Request
dataLLM <- list(model = llmModel,
                messages = list(
                  list(role = "system", content = "You are a helpful, smart, kind, and efficient AI assistant. You always fulfill the user's requests to the best of your ability."),
                  list(role = "user", content = prompt)),
                temperature = 0.7,
                max_tokens = 512,
                stream = FALSE)
# Request header
headers <- c(`Content-Type` = "application/json")

# Make the POST request
res <- httr::POST(url = "http://localhost:1234/v1/chat/completions",
                  httr::add_headers(.headers = headers),
                  body = toJSON(dataLLM, auto_unbox = TRUE))

# Extract the response
llmResponse <- httr::content(res)$choices[[1]]$message$content
cat(llmResponse)




# End