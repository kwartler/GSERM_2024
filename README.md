# GSERM_2024
GSERM St Gallen 2024 June

## Software requirements

This course requires [R](https://cran.r-project.org/), [R-studio](https://posit.co/download/rstudio-desktop/) both freely available.

Additionally on day 4, we will explore programmatic requests to "local LLMs". This requires [LM-Studio](https://lmstudio.ai/). However students with Intel Macs cannot use this software. Only Mac M1,2,3, Windows and Linux machines are supported. Students with this issue should install [Ollama](https://ollama.com/download) as an alternative. **If you use Ollama instead of lm-studio, you will have to adjust our class code based on the example below and possibly install a user interface such as [webui](https://github.com/open-webui/open-webui)**

*Students with older computers, old GPUs or a small amount of RAM, may not be able to execute this portion of the lesson*

For students needing Ollama (less preferred), download it then perform the tasks at the end of this readme.

### Packages for R

R is customized for specific functions using libraries or packages.  In this class we will use the following packages.  Once you have R and R studio installed run the following command in your console.  Don't worry if you struggle, on day 1 we will set aside time to help though we aren't performing technical support.

```
# Install library pacman
install.packages('pacman')

# Use pacman to install other libraries)
pacman::p_load(ggplot2, ggthemes, stringi, stringr, tm, qdapRegex, dplyr, tidyverse, igraph, networkD3, wordcloud, RColorBrewer, ggwordcloud, wordcloud2, echarts4r, plotrix, gplots, tidytext, radarchart, textdata, tidyr, lubridate, tm # displays the emojis correctly, emoji # Get the emoji lexicon or load one manually, emojifont # another emoji  to explore, textclean #another one!, mgsub #used for substitutions, qdap #emoticons functions, sentimentr, lexicon #lexicon::available_data, SentimentAnalysis, httr, jsonlite, vtreat, ModelMetrics, MLmetrics, pROC, text2vec, caret, glmnet, lsa, yardstick, cluster, factoextra, clue, kmed, skmeans, irlba, lexicon, plyr, sylcount)

```

# Libraries to adjust too

`library(textstem)`
