
library(ggplot2)
library(dplyr)
library(stringr)
library(httr)
library(jsonlite)
library(rvest)

# Mayas menu data processing
menu <- "MAYAS
Street taco ......... 3.99
Crispy taco ........... 6.99
Potato taco .......... 4.99
Veggie burrito ........ 7.49
Regular ............. 13.99
Super ............... 15.99
Chimichanga ......... 14.00
Beans, rice & cheese .... 10.99"

# Process Mayas data
menu_lines <- str_split(menu, "\\n")[[1]][-1]
items <- str_trim(str_extract(menu_lines, "^.*?(?=\\.{2,})"))
prices <- as.numeric(str_extract(menu_lines, "\\d+\\.\\d+"))

menu_df <- data.frame(
  item = items,
  price = prices,
  restaurant = "Mayas"
)

# Taqueria Guadalajaras data
guads <- data.frame(
  item = c("Taco de camaron", "Taco de pescado", "Taco dorado","Veggie burrito", "Regular", "Super", "Super Giant", "Chimichanga", "Beans, rice & cheese"),
  price = c(3.99, 3.99, 4.29, 9.49, 8.99, 10.99, 20.99, 11.99, 5.99),
  restaurant = "Taqueria Guadalajaras"
)

# Combine both datasets
combined_df <- bind_rows(menu_df, guads)
# QUESTION 1
events = c("Fri August-15 in 1969", "Tue Jun-6 in 1944", "Sat Jan-1 in 2000")

# Code Answer:
# Remove weekday and 'in' to simplify parsing
clean_events <- sub("^\\w+\\s", "", events)           # remove weekday
clean_events <- sub("\\sin\\s", " ", clean_events)   # remove 'in'

# Parse into Date objects using as.Date
dates <- as.Date(clean_events, format="%B-%d %Y")

# Narrative Answer:
#' Using standardized date formats (such as ISO 8601: YYYY-MM-DD) 
#' is an excellent practice because it ensures consistency, clarity, 
#' and easier computational handling. Non-standard formats vary greatly 
#' and can cause parsing errors, confusion, and difficulty in analysis. 
#' By standardizing dates, the data becomes universally understandable, 
#' easier to sort, filter, and analyze programmatically, and reduces potential 
#' bugs or misinterpretations across different software and regions.


############
# QUESTION 2 (15 points)
# 2.1. The variable `menu`, defined below, contains a string from a local
# restaurant's online menu. Use string processing to convert this string into a
# data frame with separate columns for 'item' and 'price'. Next, combine your
# data-frame with the data frame 'guads', below. This combined data frame should 
# have a populated column called 'restaurant' so it's clear which row came from 
# Mayas (the original 'menu' data) and which came from Taqueria Guadalajaras ('guads').

# Tip! Print the variable after you instantiate it and before you try to write 
# code to answer the rest of the question. This will help you to form a better 
# strategy for splitting the string. You can also use the Regex validator at 
# https://regex101.com/ to verify that your Regex works correctly before you 
# use it in your R code.

menu = "MAYAS
Street taco ......... 3.99
Crispy taco ........... 6.99
Potato taco .......... 4.99
Veggie burrito ........ 7.49
Regular ............. 13.99
Super ............... 15.99
Chimichanga ......... 14.00
Beans, rice & cheese .... 10.99"


guads = data.frame(
  type = c("Taco de camaron", "Taco de pescado", "Taco dorado","Veggie burrito", "Regular", "Super", "Super Giant", "Chimichanga", "Beans, rice & cheese"),
  price = c(3.99, 3.99, 4.29, 9.49, 8.99, 10.99, 20.99, 11.99, 5.99)
)

# Code Answer:
# Original strings
menu <- "MAYAS
Street taco ......... 3.99
Crispy taco ........... 6.99
Potato taco .......... 4.99
Veggie burrito ........ 7.49
Regular ............. 13.99
Super ............... 15.99
Chimichanga ......... 14.00
Beans, rice & cheese .... 10.99"

# Check the menu structure first:
cat(menu)

# Split menu into individual lines
menu_lines <- str_split(menu, "\\n")[[1]][-1]  # remove first line "MAYAS"

# Extract item and price using Regex
items <- str_trim(str_extract(menu_lines, "^.*?(?=\\.{2,})"))
prices <- as.numeric(str_extract(menu_lines, "\\d+\\.\\d+"))

# Create DataFrame
menu_df <- data.frame(
  item = items,
  price = prices,
  restaurant = "Mayas"
)

# Now process the provided 'guads' DataFrame
guads <- data.frame(
  item = c("Taco de camaron", "Taco de pescado", "Taco dorado","Veggie burrito", "Regular", "Super", "Super Giant", "Chimichanga", "Beans, rice & cheese"),
  price = c(3.99, 3.99, 4.29, 9.49, 8.99, 10.99, 20.99, 11.99, 5.99),
  restaurant = "Taqueria Guadalajaras"
)

# Combine both data frames into one
combined_df <- bind_rows(menu_df, guads)

# View final combined DataFrame
print(combined_df)



# Narrative Answer:
#' We first split the original menu into individual lines and exclude the 
#' header “MAYAS”.
#' Next, we used regular expressions (str_extract) to clearly separate 
#' each menu item from its corresponding price.
#' We created a clear, structured DataFrame (menu_df) for Mayas.
#' The original guads data frame was adjusted slightly to match column 
#' names (item, price, restaurant) for consistency.
#' Lastly, we used dplyr::bind_rows to combine the two datasets, clearly 
#' labeling their respective sources.
 


# 2.2. Write code to generate a single data visualization to show the price by
# item per restaurant. In a few sentences, describe how your data visualization 
# may be easier to use than looking at the online menus when you and your friends 
# are deciding where to go for lunch.

# Code Answer:


# Generate the visualization
p <- ggplot(combined_df, aes(x = reorder(item, price), y = price, fill = restaurant)) +
  geom_bar(stat = "identity", position = position_dodge(width = 0.8)) +
  coord_flip() +
  labs(title = "Price Comparison by Item and Restaurant",
       x = "Menu Item",
       y = "Price (USD)",
       fill = "Restaurant") +
  theme_minimal() +
  theme(text = element_text(size = 12))
print(p)

# Narrative Answer:
#' This visualization is beneficial because it clearly shows side-by-side 
#' pricing differences between Mayas and Taqueria Guadalajaras. 
#' The sorted bar plot quickly highlights which restaurant offers 
#' lower prices for common items. Compared to browsing online menus 
#' separately, this visualization lets you quickly identify budget-friendly 
#' options, simplifying group decision-making.



#############
# QUESTION 3 (15 points)
# Use the Cat Facts API documentation at 
# https://alexwohlbruck.github.io/cat-facts/docs/ to make a request to 
# the Cat Facts "facts" endpoint and retrieve 5 random facts about cats. 

# Note: you must properly construct the URL for your request by adding the 
# "endpoint" for your specific request as documented on the site to the 
# "base URL for all endpoints" which is also documented on the site.  
# All of the information that you need to construct a well-formed URL for your 
# request appears somewhere in the documentation, and you should be able to do 
# this using your knowledge of how URLs are constructed.

# Code Answer:
# Define URL based on the documentation:
base_url <- "https://cat-fact.herokuapp.com"
endpoint <- "/facts/random"
full_url <- paste0(base_url, endpoint)

# Make GET request to retrieve 5 random cat facts
response <- GET(full_url, query = list(amount = 5))

# Check if request was successful (status code 200)
if(status_code(response) == 200) {
  # Parse JSON response
  facts <- fromJSON(content(response, "text"), flatten = TRUE)
  
  # Print just the cat facts clearly
  cat_facts <- facts$text
  print(cat_facts)
} else {
  print("Failed to retrieve cat facts.")
}


#############
# QUESTION 4 (20 points)
# Wikipedia has a table of female Nobel Laureates at: 
# https://en.wikipedia.org/wiki/List_of_female_Nobel_laureates

# Write code that scrapes the page to get a data frame with the 
# year, name, country, and category for each laureate. You DO NOT need to worry
# about cleaning up the text to remove footnotes, parenthetical notes, 
# dual countries, or dual categories for this question.


# Code Answer:
# URL of the Wikipedia page
url <- "https://en.wikipedia.org/wiki/List_of_female_Nobel_laureates"
page <- read_html(url)

# Extract all tables with class "wikitable"
tables <- html_nodes(page, "table.wikitable")

# Manually assign the category for each table based on your provided mapping
categories <- c("Physiology or Medicine", "Physics", "Chemistry", "Literature", "Peace", "Economic Sciences")

# Initialize an empty list to store each table's data
laureates_list <- list()

# Loop through each table corresponding to the six categories
for(i in seq_along(categories)) {
  # Parse the table into a data frame
  df <- html_table(tables[[i]], fill = TRUE)
  
  # Select only the columns we need: Year, Name, and Born (as country)
  # Note: Use colnames(df) to inspect if needed.
  df_subset <- df %>% select(Year, Name, Born)
  
  # Add a new column for the category
  df_subset <- df_subset %>% mutate(category = categories[i])
  
  # Rename the columns as required by the assignment:
  # "year", "name", "country", and "category"
  df_subset <- df_subset %>% rename(
    year = Year,
    name = Name,
    country = Born
  )
  
  # Append the processed data frame to the list
  laureates_list[[i]] <- df_subset
}

# Combine all the tables into a single data frame
final_df <- bind_rows(laureates_list)

# Display the final data frame
print(n = 66, final_df)
######################################
# QUESTION 5 (20 points)
# The file `nobel_laureates_messy.rds` contains a data frame with information about 
# female Nobel Laureates, scraped from Wikipedia. 

# 5.1. This new data frame is terribly messy. One issue is that while each row 
# corresponds to one laureate,  the `Laureate` column sometimes contains a 
# parenthetical note in addition to the laureate's name. Separate the name of 
# each laureate from these notes, so that the name is alone in the `Laureate` 
# column, and the note is stored in a new column called `Note`.

# Make sure there are no parentheses in the text in the `Note` column. For rows
# where there is no note, the value of the note should be `NA` or the empty 
# string `""` (either is acceptable, but don't use a mix of both).  This question 
# will require you to apply various skills that we learned in this course, 
# including manipulating the columns of a data frame and using regular expressions
# to identify substrings within a string.  

# Hint: The question asks you to apply computational operations across all 
# rows/observations in the data frame.  There are several ways to apply the same 
# function to all observations in R.  Before you begin coding, think about 
# how you will accomplish this iteration.  
                                                                                                        

# Code Answer:
df <- readRDS("./nobel_laureates_messy.rds")
# Assume your data frame is called 'df' and has a column 'Laureate'
df <- df %>%
  # Extract the parenthetical note (if present)
  mutate(Note = str_extract(Laureate, "\\(.*?\\)"),
         # Remove the note from the Laureate column
         Laureate = str_trim(str_remove(Laureate, "\\(.*?\\)"))) %>%
  # Remove parentheses from the note and replace NA with an empty string
  mutate(Note = ifelse(is.na(Note), "", str_remove_all(Note, "[()]")))

# Check the result
print(df)

# 5.2. What is something else you noticed about this data frame that should be
# cleaned before it is used in an analysis?
 
# Narrative Answer:
# many of the Laureates are from multiple countries or are in multiple
# categories. This should be standardized in some way before doing any analysis
# in order to get clean results.



##############
# QUESTION 6 (25 points)
# For this question you will need add the carData package to your environment.
# Next, run this code: 
demo <- carData::MplsDemo
str(demo)
# 6.1. In a paragraph, describe what 'demo' is about and define the variables 
# it contains. Include an explanation of how you determined your answers.

# Narrative Answer:
#'The demo dataset from the carData package contains 
#'demographic information for 84 neighborhoods in Minneapolis. 
#'Each row represents a neighborhood, and the dataset includes eight variables:
#'neighborhood: A character variable indicating the name of each neighborhood (e.g., “Cedar Riverside”, “Phillips West”).
#'population: A numeric variable showing the total number of residents in the neighborhood.
#'white: A numeric value (likely expressed as a proportion) representing the percentage of the population identified as white.
#'black: A numeric value indicating the proportion of residents who are Black.
#'foreignBorn: A numeric variable representing the proportion of the neighborhood’s population that was born outside the United States.
#'hhIncome: A numeric variable for the average household income in the neighborhood.
#'poverty: A numeric value showing the proportion of residents living below the poverty line.
#'collegeGrad: A numeric value representing the proportion of residents who are college graduates.

# I found this data and descriptions at 
# https://www.rdocumentation.org/packages/carData/versions/3.0-5/topics/MplsDemo


# 6.2. Investigate this dataset and provide a short answer to the questions below.

# a. How many rows and columns are in the data set?
# Narrative Answer: 

# 84 rows and 8 cols found by str(demo)

# b. What are the names and classes of the columns in the data set?
# Narrative Answer: 

#The columns in the dataset and their corresponding classes are:

#neighborhood: character (the name of the neighborhood)
#population: numeric (the total population in the neighborhood)
#white: numeric (the proportion of residents who are white)
#black: numeric (the proportion of residents who are Black)
#foreignBorn: numeric (the proportion of residents who are foreign born)
#hhIncome: numeric (the average household income)
#poverty: numeric (the proportion of residents living in poverty)
#collegeGrad: numeric (the proportion of residents who are college graduates)

#I determined these by examining the output of str(demo) 
#which shows both the column names and the data types.

# c. How many missing values are in each column?
# Narrative Answer: 
# There are no missing values

# d. How many missing values are in the data set in total?
# Narrative Answer: 
# There are no missing values in the table itself according to documentation:
#'A few stops have been deleted, either because thesu location data was missing,
#' or a few very rare
#'categories were also removed. The data frame MplsDemo contains 2015
#' demongraphic data on Minneapolis neighborhoods, using the same neighborhood
#'  names as this data file. Demographics are
#'available for 84 of Minneaolis’ 87 neighborhoods. The remaining 3 presumably 
#'have no housing.
#'These are public data obtained from <http://opendata.minneapolismn.g

# Code Answer: Add any code here that you wrote to help you answer questions a-d above.
print(sapply(demo, function(x) sum(is.na(x))))
str(demo)
print(demo)

# 6.3. Write code to help you identify any outliers in 'demo'. You can use 
# statistics or plotting to determine your answer. Return the index of any 
# outliers you discover.

# Code Answer
# Identify numeric columns in demo
num_vars <- sapply(demo, is.numeric)

# Initialize list to store outlier indices for each numeric column
outlier_indices <- list()

# Loop over each numeric variable
for (var in names(demo)[num_vars]) {
  # Get the values for the variable
  values <- demo[[var]]
  
  # Use boxplot.stats to calculate outliers (using the IQR method)
  bp_stats <- boxplot.stats(values)$out
  
  # Identify the row indices where these outlier values occur
  if (length(bp_stats) > 0) {
    indices <- which(values %in% bp_stats)
    outlier_indices[[var]] <- indices
  } else {
    outlier_indices[[var]] <- integer(0)  # No outliers for this variable
  }
}

# Display the outlier indices
print(outlier_indices)


# 6.4. Write a question to investigate using this data. Then, write code to 
# generate a data visualization that helps address your question.

# Your research question:

#' Does higher household income correlate with higher college graduation 
#' rates in Minneapolis neighborhoods?
#' 
# Code Answer
# Generate the scatter plot
p2 <- ggplot(demo, aes(x = hhIncome, y = collegeGrad)) +
  geom_point(color = "blue", size = 3, alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Household Income vs. College Graduation Rates in Minneapolis Neighborhoods",
       x = "Household Income",
       y = "College Graduation Rate") +
  theme_minimal()

print(p2)

# Perform a correlation test
cor_test <- cor.test(demo$hhIncome, demo$collegeGrad)

# Extract correlation coefficient and p-value
cor_coef <- cor_test$estimate
p_value <- cor_test$p.value

# Set significance level (alpha)
alpha <- 0.05

# Decide if there is a significant positive correlation
if(cor_coef > 0 & p_value < alpha) {
  print("Yes, higher income correlates to a higher probability of college gradiation")
} else {
  print("No")
}
