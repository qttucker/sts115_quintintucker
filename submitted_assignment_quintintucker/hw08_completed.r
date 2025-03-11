########
###Q1###
########

# Load stringr package
library(stringr)

# Example text variable
text <- "The event was held on 23/04/2021 and the next event will be on 05/10/2022."

# Regular expression to match "dd/mm/yyyy"
date_pattern <- "\\b(\\d{2})/(\\d{2})/(\\d{4})\\b"

# Replace dates with "yyyy-mm-dd" format
formatted_text <- str_replace_all(text, date_pattern, "\\3-\\2-\\1")

# Print the modified text
print(formatted_text)

########
###Q2###
########

# \n (newline escape sequence) → Inserts a line break
X <- "I am here.\nAm I alive?\n"

# print() treats strings as raw text (ignores escape sequences)
cat(X)

########
###Q3###
########

# escape sequence \" renders a literal "
y <- "She said, \"Hi!\"\n"

# print() ignores escape sequences and renders raw text
cat(y)

########
###Q4###
########

# Text encoding defines how the system interprets a character from its binary representation.
# Different encoding standards exist, such as ASCII, UTF-8, and ISO-8859-1.
# For example, if the system expects ASCII encoding, it will take the 7 lower bits
# and map that value to a character using the ASCII lookup table (simplified).
# 
# ASCII is a bijection:
# from: 0000 0000 to 0111 1111 (0 to 127 in decimal)
# onto: A-Z, a-z, 0-9, symbols, and control characters.
# 
# Other encodings create similar mappings but are not necessarily bijections
# due to multi-byte representations (such as UTF-8) or ambiguous mappings.

########
###Q5###
########

c <- "He wanted to say hello but was afraid"

# split c into list of words separated by whitespace
c <- str_split(c, "\\s+")

# convert list of words into character vector
c <- unlist(c)

# return a logical vector where hello_idx[i] = (c[i] == "hello")
hello_idx <- str_detect(c, "hello")

cat(hello_idx)

########
###Q6###
########

# Load required libraries
library(tm)
library(tidyverse)
library(ggplot2)

# Read in the DTM file
dtm <- readRDS("./dtm.rds")

#----------------------------------------
# 15.7 Corpus Analytics
#----------------------------------------

# Get information about dimensions and document names
dim(dtm)  # Shows number of documents (rows) and terms (columns)
dtm$dimnames$Docs  # Get document names

# Inspect the DTM to get a high-level view
inspect(dtm)

#----------------------------------------
# Finding frequent terms
#----------------------------------------

# Find terms that appear more than 1,000 times in the corpus
frequent_terms <- findFreqTerms(dtm, 1000)
frequent_terms

#----------------------------------------
# Finding term associations
#----------------------------------------

# Find words associated with "boat"
boat_assoc <- findAssocs(dtm, "boat", .85)
boat_assoc

# Find words associated with "writing"
writing_assoc <- findAssocs(dtm, "writing", .85)
if(length(writing_assoc) > 0) {
  print(writing_assoc[[1]][1:15])  # Get the first 15 associations
}

#----------------------------------------
# 15.7.1 Corpus Term Counts
#----------------------------------------

# Convert DTM to a matrix and then a data frame for analysis
term_counts <- as.matrix(dtm)
term_counts <- data.frame(sort(colSums(term_counts), decreasing = TRUE))
term_counts <- cbind(newColName = rownames(term_counts), term_counts)
colnames(term_counts) <- c("term", "count")

# Plot the top 50 terms in the corpus
ggplot(term_counts[1:50, ]) + 
  aes(x = fct_reorder(term, -count), y = count) +
  geom_bar(stat = "identity") +
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)
  ) +
  labs(
    title = "Top 50 words in 19th-Century Novels",
    x = "Word",
    y = "Count"
  )

#----------------------------------------
# 15.7.2 TF-IDF Analysis
#----------------------------------------

# CORRECTED: Create a TF-IDF weighted document-term matrix
# Method 1: Using the tm package's built-in functionality
dtm_tfidf <- weightTfIdf(dtm)

# Alternative Method 2: Create a new DTM with TF-IDF weighting
# If the above doesn't work, try this:
# dtm_tfidf <- DocumentTermMatrix(
#   Corpus(VectorSource(as.character(sapply(1:nrow(dtm), function(i) dtm[i,]$dimnames$Terms)))),
#   control = list(weighting = weightTfIdf)
# )

# Find associations using TF-IDF values (if applicable terms exist)
if("boat" %in% dtm$dimnames$Terms) {
  boat_tfidf_assoc <- findAssocs(dtm_tfidf, terms = "boat", corlimit = .85)
  print(boat_tfidf_assoc)
}

if("writing" %in% dtm$dimnames$Terms) {
  writing_tfidf_assoc <- findAssocs(dtm_tfidf, terms = "writing", corlimit = .85)
  print(writing_tfidf_assoc)
}

# Create data frame from TF-IDF DTM for further analysis
tfidf_counts <- as.matrix(dtm_tfidf)
tfidf_counts <- data.frame(sort(colSums(tfidf_counts), decreasing = TRUE))
tfidf_counts <- cbind(newColName = rownames(tfidf_counts), tfidf_counts)
colnames(tfidf_counts) <- c("term", "tfidf")

# Plot top terms by TF-IDF score
ggplot(data = tfidf_counts[1:50, ]) +
  aes(x = fct_reorder(term, -tfidf), y = tfidf) +
  geom_bar(stat = "identity") +
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)
  ) +
  labs(
    title = "Words with the 50-highest TF-IDF scores in 19th-Century Novels",
    x = "Word",
    y = "TF-IDF"
  )

#----------------------------------------
# 15.7.3 Unique Terms in Documents
#----------------------------------------

# Create a data frame from TF-IDF DTM with novels as columns
tfidf_df <- as.matrix(dtm_tfidf)
tfidf_df <- as.data.frame(t(tfidf_df))

# Get document names from original DTM
novel_names <- dtm$dimnames$Docs
print("Available novels in the corpus:")
print(novel_names)

# Find unique terms in specific novels
# Using safer approach to handle potential missing novels

# Example for checking Dracula
dracula_idx <- which(novel_names == "Dracula")
if(length(dracula_idx) > 0) {
  ordering <- order(tfidf_df[dracula_idx,], decreasing = TRUE)
  dracula_terms <- colnames(tfidf_df)[ordering[1:50]]
  print("Top 50 unique terms in Dracula:")
  print(dracula_terms)
}

# Example for checking Frankenstein
frankenstein_idx <- which(novel_names == "Frankenstein")
if(length(frankenstein_idx) > 0) {
  ordering <- order(tfidf_df[frankenstein_idx,], decreasing = TRUE)
  frankenstein_terms <- colnames(tfidf_df)[ordering[1:50]]
  print("Top 50 unique terms in Frankenstein:")
  print(frankenstein_terms)
}

# Example for checking Wuthering Heights
wuthering_idx <- which(novel_names == "WutheringHeights")
if(length(wuthering_idx) > 0) {
  ordering <- order(tfidf_df[wuthering_idx,], decreasing = TRUE)
  wuthering_terms <- colnames(tfidf_df)[ordering[1:50]]
  print("Top 50 unique terms in Wuthering Heights:")
  print(wuthering_terms)
}

# Example for checking Sense and Sensibility
sense_idx <- which(novel_names == "SenseandSensibility")
if(length(sense_idx) > 0) {
  ordering <- order(tfidf_df[sense_idx,], decreasing = TRUE)
  sense_terms <- colnames(tfidf_df)[ordering[1:50]]
  print("Top 50 unique terms in Sense and Sensibility:")
  print(sense_terms)
}