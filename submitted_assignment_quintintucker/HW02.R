my_data <- read.csv("/Users/quintintucker/sts115/hw02_R_intro/my_data.csv")

# 1. Interview 5 people from outside of STS115 and add their data to the 
#     “my_data” data frame from class to create a new data frame called “our_data”.
#     You will use this for the subsequent questions. 

#Here I am crearing a new data frame and appending it to my_data with rrbind
# Im leaving the new frame anonymous since it will only be used in this one line.
our_data <- rbind(my_data, data.frame(
  response    = c("Computer Science", "Psyschology", "Computer Science", "Computer Science", "Economics"),
  major       = c("ECS", "PSY", "ECS", "ECS", "ECN"),
  study       = c("Peets", "Panera", "ARC", "Peets", "Arboretum"),
  location    = c("Peets", "Panera", "Peets", "Village", "Starbucks"),
  pet         = c("Woof", "Woof", "Woof", "Woof", "Woof"),
  distance.mi = c(0.7, 0.2, 0.6, 0.7, 0.4),
  time.min    = c(4, 2, 4, 4, 4)))


# 2. Come up with a yes/no or true/false question you’d have liked the survey to have asked.
#       Make up these data for every subject in the survey, 
#       then create it as a logical vector and add it to the data frame.   

#question: Have you been to the moon?
# we can create a new vector with rep()
# we can use rep to avoid typing false 71 times
# we can directly assign it with a label with my_data$label <- c()
our_data$moon <- rep(FALSE,71)

# 3. Use a single function to return the class of each column in the data frame. 

# Here I will use sapply which takes a list/vector/df and a function,
# and applies the function to each vector in the df.
# the function I am using is class() which returns the class of the vector
# I am then printing the result.
print(sapply(our_data, class))


# 4. Look up how to use the function `max`. Use it to calculate the longest 
#       commute distance and travel time.

#Here Im finding the index of of the max value in the distance column
# I am then using that index to access its corresponding travel time
# in the time.min column, and then printing the result.
print(our_data$time.min[which.max(our_data$distance.mi)])


# 5. Calculate travel speed across subjects as miles per minute. 
#       Assign this to a new vector `mi.per.min` and add it to the data frame. 

#Here I am simply dividing the two columns, which returns a vector
#I am storing this vector in a new column names mi.per.min
our_data$mi.per.min <- (our_data$distance.mi / our_data$time.min)

# 6. Use a function to return the total number of elements in mi.per.min.

#Here Im using the length fuction to check how many elements 
# are in the vector mi.per.min, and then printing the result.
print(length(our_data$mi.per.min))
      
# 7. Index/subset the vector `major` to get 
#     a new vector that contains the 3rd, 1st, and 9th elements (in that order).

#Here im creating a vector of indexes, which is weird,
# but that is how you select multiple elements from a vector
# I am then creating a new vector with those elements in order with c()
print(c(our_data$major[c(3,1,9)]))

# 8. R’s `[` indexing operator accepts several different types of indexes, 
#       not only positive whole numbers. 
#       For example, the operator accepts negative numbers as indexes. 
#       Using the vector `places`, try out three to five different negative indexes. 
#       Based on the results, what do you think the [ operator does with negative indexes?

# Based on these trials, it seems that negative indexes removes that element 
# from the vector
print(our_data$location[-70])
#print(our_data$location[-2])
#print(our_data$location[-3])
#print(our_data$location[-4])

# 9. Consider the R code `c(3, 3.1, “4”, -1, TRUE)`.  
#     a. WITHOUT running the code, what data type you think the result will have and why? 
#     b. Now run the code to check whether your guess was correct. 
#           If it was not correct, explain what the actual data type is and why. 
#           If your guess was correct, write a new, different line of code that yields the same resulting data type.

# a. I believe it will be bool
print(class(c(3, 3.1, "4", -1, TRUE)))
# b Its a character data type, it must require all tpes to be the same,
# and since theyre mixed, its interpreting them as their ASCII codes.
# 
print(class(c("a", 1)))

# 10. Run the code `“four” < “five”`. Paste the output from R into a 
#.    comment and explain why you think it provided that result.

#[1] FALSE
# I believe its comparing ASCII values
print("four" < "five")

# 11. There are several major mistakes in the data entered in class.
#        a. Describe in complete sentences what at least 2 of the errors are. 
#           Make some guesses as to how those errors may have happened, and how they might affect analyses and/or re-use of these data.
#        b. Pretend the data frame was too big for you to view it manually. 
#           List specific function calls you could use in R to help you find these mistakes programmatically.

# a. the errors are in the responses for location, one person responded "no"
#and the other gave a full sentence rather than a place. A third student responded
#with two locations. These errors muddy the data as we do not know which location is 
#actually being referenced in the last two columns.

# b. in the miles column we could use < and is.na to find columns
# that have data which doesnt make sense.