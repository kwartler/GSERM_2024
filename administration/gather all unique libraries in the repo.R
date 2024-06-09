# Install and load necessary packages
if (!require("fs")) install.packages("fs")
if (!require("readr")) install.packages("readr")

library(fs)
library(readr)

# Function to extract libraries used in R scripts
# Function to extract libraries used in R scripts
get_libraries_from_script <- function(script_path) {
  script_content <- read_lines(script_path)
  libraries <- unique(grep("^library\\(|^require\\(", script_content, value = TRUE))
  libraries <- gsub('[()]', '', libraries)
  libraries <- gsub("library\\(|require\\(", "", libraries)
  libraries <- gsub('\"|\'', '', libraries)
  libraries <- gsub("library", "", libraries)  # Remove "library" prefix
  libraries <- trimws(libraries)  # Trim any leading or trailing spaces
  return(libraries)
}

# Function to search for R scripts and extract libraries
search_and_extract_libraries <- function(parent_dir) {
  script_paths <- dir_ls(path = parent_dir, recurse = TRUE, regexp = "\\.R$")
  unique_libraries <- c()
  
  for (script_path in script_paths) {
    libraries <- get_libraries_from_script(script_path)
    unique_libraries <- union(unique_libraries, libraries)
  }
  
  return(unique_libraries)
}

# Define the parent directory path
parent_dir <- "~/Desktop/GSERM_2024/lessons"

# Search for R scripts and extract unique libraries
unique_libraries <- search_and_extract_libraries(parent_dir)

# Print the unique libraries
paste(unique_libraries, collapse = ', ')
