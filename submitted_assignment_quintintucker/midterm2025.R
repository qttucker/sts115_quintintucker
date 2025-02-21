################################################################
# This file contains questions for the midterm exam for STS115 #
# Winter Quarter, 2025.                                        #
#                                                              #
# This is exam is designed to provide you with the chance      #
# to demonstrate your understanding of both the concepts       #
# and syntax of the methods deployed by Data Scientists.       #
# As such, even if you are unable to provide working code      #
# for questions that require you to code, we encourage you     #
# to provide pseudo code and/or a textual explanation          #
# of your understanding of how one would approach the          #
# problem computationally, or even how the computer itself     #
# would approach the problem given your knowledge of how       #
# computers and programming languages work.                    #
#                                                              #
# Because problem solving is an essential part of being a      #
# Data Scientist, you are allowed to use any resources at      #
# your disposal to respond to the questions in this exam.      #
# This includes, but is not limited to, resources such as      #
# Google, Stack Overflow, the Course Reader, etc.              #
# The only restriction is that you may not use live chat,      # 
# messaging, email, discourse, Slack, or any other method of   # 
# real-time communication with another member of the course    #
# or any other person to formulate your response.              #
#                                                              #
# Questions appear as comments in this file.  As with the      #
# homework assignments, place your answers to each question    #
# immediately following the question prompt. Some questions    #
# require you to write computer code (R or Shell Script) as    #
# an answer and other questions ask you to provide text only   #
# explanations of computing and Data Science concepts.         #
# The phrase "[Text Answer]" appears immediately following     #
# each question that requires a text only answer. As noted     #
# above, you are encouraged to include text explanation of     #
# your code answers in all cases to increase your chances      #
# of earning partial credit for a question in the event that   #
# your code solution is incorrect.                             #
#                                                              #
# The exam duration is 1.5 hours.                              #                                                             #                                                              #
# Submit your completed exam and generated files via Github    #
# using the same workflow that you have used to submit your    #
# class homework.                                              #
################################################################


# Question 1. What is the command line symbol that provides 
# a shortcut to your "home" directory on your system.  For 
# example, what symbol would you use in place of "x" in the 
# command "cd x" if you wanted to use the cd command to move 
# into your home directory:

# ~ is the shortcut


# Question 2. Write R code to assign the value 7 to a variable "x":

x <- 7


# Question 3. Write R code that subtracts 3 from the variable "x" 
# and assigns the results to a variable "y":

y <- x-3

# Question 4. Assign the values 1, 23, 6, 2, 19, 7 to a vector:

vec <- c(1, 23, 6, 2, 19, 7)


# Question 5. Run the code `“four” < “five”`. Paste the output 
# from R into a comment and explain why you think it provided 
# that result: [Text Answer]

print("four" < "five")
# [1] FALSE 
#It provides that result because the strings four and five are being compared,
#Not their numeric values.. "In R, when you compare strings using relational 
#operators (like <, >, ==, etc.), the comparison is based on the collation 
#order defined by your system’s locale"

# Question 6. Write a for loop that loops through each element in
# the vector you created in your answer to Question 4 and prints
# each value to screen:

for( elmt in vec) {
  print(elmt)
}



# Question 7. Assign the value 3 to a variable "x" and write
# a conditional statement that tests whether x is less than 5.  
# If it is, print "Yay!" to screen:

x <- 3
if(x < 5){
  print("Yay!")
}


# Question 8. Download the "wine_enthusiast_rankings.csv" file from
# the "data" directory in the "Files" area of the course Canvas
# website and then write code to load it into a variable called "wine_revs":

wine_revs <- read.csv("~/Desktop/wine_enthusiast_rankings.csv")


# Question 9.  Write code to determine the class of the "wine_revs"
# data object you created in Question 8 above:

print(class(wine_revs))


# Question 10. Write code that returns the column/variable
# names of the "wine_revs" object:

print(colnames(wine_revs))


# Question 11. Write code to load all observations from the
# "price" column/variable of the "wine_revs" object into
# a vector called "wine_prices":

wine_prices <- wine_revs$price


# Question 12. Subset the "wine_revs" object to create a new 
# data.frame named "wine_revs_truncated" that contains all 
# observations for only the numeric ID, Points, Price, Variety, 
# and Winery columns/variables in "wine_revs": 


trunc <- c("X", "points", "price", "variety", "winery")
wine_revs_truncated <- wine_revs[trunc]

# Question 13. Save the "wine_revs_truncated" that you created 
# in Question 12 to your course working  directory 
# as an RDS file named "wine_revs_truncated.rds":


saveRDS(wine_revs_truncated, "wine_revs_tuncated.rds")

# Question 14. Below is an R function that receives a single 
# argument (an integer) and returns the square root of that
# argument.  Write code (below the function) that calls the 
# function sending it the value 144 as its argument and assigns
# the returned result to a variable "z".  Note:  Be sure to run
# code of the function to load it into your environment before
# you try to call it in your answer or you won't be able to test
# your answer.

getSqrt <- function(argument_1) {
  retval <- sqrt(argument_1) 
  return(retval)
}

z <- getSqrt(144)
print(z)

# Question 15. Write code that you would use to install the "fortunes"
# package onto your local machine and then load it into the working
# R environment:

#'install.packages("fortunes")
#'library(fortunes)


# Question 16. Why doesn't R automatically load every installed package when 
# it starts: [Text Answer]

#' If R loaded every installed package into the working environment upon starting
#' this would bog down resources with code that we do not need. Every loaded 
#' package has to be read into working memory and needs to be loaded into 
#' our working environment. This would tie up working memory and slow computation



# Question 17. What command(s) create a repository and put that
# directory under git control:

# git init

# Question 18. List an advantage and a disadvantage for each of the
# following data file formats: [Text Answer]
#   
#     a. RDS files
#
#     b. CSV files

# a. RDS files
#' Advantage: They preserve the complete R object, including data types, 
#' attributes, and structure, making them ideal for storing complex R objects.
#' 
#' Disadvantage: They are specific to R and stored in a binary format, 
#' which means they are not human-readable and less portable to non-R environments.
#' 
# b. CSV files
#' Advantage: They are plain text, human-readable, and widely supported across 
#' different programming languages and software applications, 
#' making them ideal for data sharing.
#' 
#' Disadvantage: They lack the ability to store metadata and complex data types 
#' (such as factors or dates), which can result in loss of information 
#' when the data is re-imported.


# Question 19. Discuss what statisticians mean when they talk about
# finding the "center" of a data set: [Text Answer]

#' When statisticians refer to the “center” of a data set, they are talking 
#' about a measure of central tendency—a single value that is considered a 
#' typical or representative point for the entire data. This concept helps 
#' summarize the data with a central value that indicates where most data points
#'  are concentrated. Common measures include:
#'Mean: The arithmetic average, which can be sensitive to extreme values 
#'(outliers).
#'Median: The middle value when the data are ordered, providing a robust measure
#' that is less affected by outliers.
#'Mode: The most frequently occurring value, which is useful for 
#'categorical or discrete data.

#'Each measure offers a different perspective on the data’s distribution, 
#'and choosing the appropriate one depends on the data’s nature and the 
#'presence of outliers.






# Question 20.  Explore the "wine_revs" data object that you created in 
# Question 8 above and calculate some summary statistics. Include in your 
# answer the code that you used to generate the statistics and outputs,
# a text explanation of the statistics you generated, and an interpretation
# of what those statistics mean.
#
# [Code Answer]
print(summary(wine_revs))
# Split the points by winery
winery_points <- split(wine_revs$points, wine_revs$winery)

# Calculate the average points for each winery using sapply
winery_avgs <- sapply(winery_points, function(x) mean(x, na.rm = TRUE))

# Sort the averages in decreasing order and extract the top 10 wineries
top10_wineries <- head(sort(winery_avgs, decreasing = TRUE), 10)

# Print the top 10 wineries
print(top10_wineries)

# Compute the price per point for each wine
price_per_point <- wine_revs$price / wine_revs$points

# Split the price per point values by winery
winery_ratios <- split(price_per_point, wine_revs$winery)

# Calculate the average price per point for each winery using sapply
avg_price_per_point <- sapply(winery_ratios, function(x) mean(x, na.rm = TRUE))

# Sort the averages in decreasing order and extract the top 10 wineries
top10_price_per_point <- head(sort(avg_price_per_point, decreasing = TRUE), 10)

# Print the top 10 wineries with their average price per point
print(top10_price_per_point)

# Calculate the overall mean and standard deviation of points across all wines
overall_mean <- mean(wine_revs$points, na.rm = TRUE)
overall_sd <- sd(wine_revs$points, na.rm = TRUE)

# Split the points by winery
winery_points <- split(wine_revs$points, wine_revs$winery)

# Calculate the average points for each winery using sapply
winery_avgs <- sapply(winery_points, function(x) mean(x, na.rm = TRUE))

# Compute the z-score for each winery's average points relative to the overall distribution
# (i.e., how many standard deviations from the overall mean)
winery_z_scores <- (winery_avgs - overall_mean) / overall_sd

# Optionally, sort the results by absolute z-score (largest deviations first)
sorted_winery_z <- sort(abs(winery_z_scores), decreasing = TRUE)


# To view the sorted absolute deviations:
print(head(sorted_winery_z))

# Compute the points per dollar ratio for each wine
# (Handle any division by zero by replacing Inf with NA)
points_per_dollar <- wine_revs$points / wine_revs$price
points_per_dollar[is.infinite(points_per_dollar)] <- NA

# Split the points per dollar ratios by winery
winery_ratios <- split(points_per_dollar, wine_revs$winery)

# Calculate the average points per dollar for each winery using sapply
winery_avg_ratio <- sapply(winery_ratios, function(x) mean(x, na.rm = TRUE))

# Compute the overall mean and standard deviation of these average ratios
overall_mean <- mean(winery_avg_ratio, na.rm = TRUE)
overall_sd <- sd(winery_avg_ratio, na.rm = TRUE)

# Calculate the z-score for each winery's average points per dollar
winery_z_scores <- (winery_avg_ratio - overall_mean) / overall_sd

# Sort the z-scores in decreasing order and extract the top 10 wineries
top10_wineries <- head(sort(winery_z_scores, decreasing = TRUE), 10)

# Print the top 10 wineries with their z-scores
print(top10_wineries)
#
# [Text Answer]


#' I looked at a few metrics, average price for each winery, average points 
#' for each winery, standard deviation for points per winery. Standard deviation 
#' for points per price for each winery. It is interesting to me that the wineries
#' with the highest price average price did not show up in the highest points
#' or in the highest points per price. Some wineries had a really high z score
#' for points to price, and may be due to innacurate information such as 
#' Bandit, Broke Ass, Pam's Cuties, and Terrenal.
#' Araujo was an outlier with a z score of 3 for average points scored for the 
#' winery.

