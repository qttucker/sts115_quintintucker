# This file contains homework questions for the lecture on 
# Control Structures and Functions.  Questions appear as comments 
# in the file.  Place your answers as executable code immediately 
# following the relevant question.


# QUESTION 1: Assign the value 3 to a variable "x" and write
# a conditional statement that test whether x is less than 5.  
# if it is, print "Yay!" to screen.

#assigning 3 to x
x <- 3
#comparing x to 5 and printing yay
if (x < 5) {
  cat("Yay!\n")
}


# QUESTION 2:  Create two variables "x" and "y" and assign 
# each a numeric value. Create a conditional statement that 
# tests whether the value of a variable "x" is equivalent 
# to the value of variable "y." If the values are equivalent, 
# print "The variables are equal" to screen. If they are not 
# equivalent, print "The variables are not equal" to screen.

x <- 3
y <- 5
#checking for equality
if (x == y) {
  cat("The variables are equal\n")
} else {
  cat("The variables are not equal\n")
}


# QUESTION 3:  Duplicate the conditional code from above, but 
# change the logic of the conditional so that it tests for 
# conditions in which "x" IS NOT EQUIVALENT" to "y" and print 
# the appropriate message to screen accordingly.

# != means not equal
if (x != y) {
  cat("The variables are not equal\n")
} else {
  cat("The variables are equal\n")
}


# QUESTION 4:  Assign the boolean value TRUE to the variable "x", 
# and then create a conditional statement that tests whether the 
# value of a variable "x" is TRUE or FALSE. If the value is true, 
# print "X is true" to screen. If false print "X is false" to screen.

x <- TRUE
# if TRUE ...
if (x) {
  cat("X is TRUE\n")
} else {
  cat("X is FALSE\n")
}


# QUESTION 5: Write a "for" loop that iterates through the 
# values 1 to 10 and prints the iteration number to screen 
# during each loop.

# I added a space just for formatting
for (i in 1:10) {
  cat(i, " ")
} 
cat("\n")


# Question 6: Assume that you want to create a loop that executes 
# exactly 10 times. Assign the value 1 to "x" and then write a "while" 
# loop that iterates based on a test of the value of "x" and for each 
# loop prints the value of "x" to the screen. 
#
# The printed output should look like:
#
# 1 2 3 4 5 6 7 8 9 10
#
# Note that depending on your browser the numbers may print to the same 
# line or each on a new line.

x <- 1
# while loops have a built in break statement
while (x <= 10) {
  cat(x, " ")
  x <- x + 1
}
cat("\n")


# Question 7: Create a list or vector object that contains 
# the following values:
#
# Tesla, Nissan, Harley, Chevy, Indian, MG. 
# 
# Then write code that loops through each item in the list and
# prints the value to screen

#creating the vector cars
cars <- c("Tesla", "Nissan", "Harley", "Chevy", "Indian", "MG")
#using the vector as a range
for (make in cars) {
  cat(make, " ")
}
cat("\n")


# Question 8: Write code that loops through each item in the list 
# object that you created for Question 3 above and, for each value,
# if the values is "Harley" or "Indian" print, "This is a motorcycle" 
# to screen. Otherwise print, "This is a car" to screen.

#another vectorized for loop, with ||, which is logical OR (inclusive)
for (make in cars) {
  if (make == "Harley" || make == "Indian"){
    cat("This is a motorcycle\n")
  } else {
    cat("This is a car\n")
  }
}


# Question 9: Assign the values 1-10 to a vector.  Then, loop through
# your vector and print each value to screen unless the value is 5.  (The
# final output of your process should be: 1 2 3 4 6 7 8 9 10)

#using a sequence to build the vector temp
temp <- c(1:10)
for (i in temp) {
  if(i != 5) {
    cat(i, " ")
  }
}
cat("\n")


# QUESTION 10: Write a function that performs a simple math equation 
# with a variable. Run the function substituting the variable with 
# at least three different values by calling it in a loop. For 
# instance, if you write a function for a variable "x", Use a loop 
# call the function for at least three numbers as "x".

# R doesnt seem to have an iterative operator like most languages
iter <- function(x) {
  x <- x + 1
}

#R only passes by copy, which means its highly inefficient 
x <- 0
while (x < 10) {
  cat(x <- iter(x), " ")
}

