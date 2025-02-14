
# 1.  "The distance from a point to a mean is called a deviation" 
# from unit 7  Data Forensics
################################################################################



# 2.  The Standard Deviation is the square root of the average squared distance 
#to the mean. You can think of this as approximately the average distance
#from a data point to the mean.As a rule of thumb, most of the data will 
#be within 3 standard deviations of the mean.
# from unit 7  Data Forensics
################################################################################



#"****************************************************************************"#
#
#       """The first four questions are narrative only, 
#           meaning you can just write an answer and do not
#           need to write computer code."""
#
#   Clearly this is not the case... so why state it multiple times?...
#"****************************************************************************"#



cat("3\n####################################################################\n")
# 3.
cl <- read.csv("../cl_rentals.csv")
#
#   A.
cat("row, col = ", dim(cl))
# Theres 2987 rows and 20 columns in the cl data. dim() returns both nrow and 
# ncol in a vector. Not much to comprehend here.
cat("\n----------------------------------------------------\n")

#   B.
# colnames(): "Retrieve or set the row or column names of a matrix-like object."
print(colnames(cl))
# The column names are: title, text, latitude, longitude, city, date_posted,
# date_updated, price, deleted, sqft, bedrooms, bathrooms, pets, 
# laundry, parking, craigslist, shp_place, shp_city, shp_state, shp_county.
cat("----------------------------------------------------\n")
#   C.
# str(): "Compactly displays the internal structure of an R object, 
# a diagnostic function and an alternative to summary 
# (and to some extent, dput). 
# Ideally, only one line for each ‘basic’ structure is displayed. 
# It is especially well suited to compactly display the 
# (abbreviated) contents of (possibly nested) lists. 
# The idea is to give reasonable output for any R object. 
# It calls args for (non-primitive) function objects."
str(cl)
cat("----------------------------------------------------\n")
#   D.
# "the summary function computes a detailed statistical summary of an R object.
#  For data frames, the function computes a summary of each column, 
#  guessing an appropriate statistic based on the column’s data type.
print(summary(cl))
cat("4.\n###################################################################\n")



# 4. 
#
#    A. is.na() returns a logical vector, so we can just sum this...
#   I'm looping through all the column names in cl and using them as indices
#   to my cl columns in order to use each column vector as my argument.. 
count_na <- function(x){
  return(sum(is.na(x)))
}
for(col in colnames(cl)) {
  cat(col, "has ", count_na(cl[col]), "NA values\n")
}
cat("----------------------------------------------------\n")

#    B. I can just hard-code for "pets" since you want me to...
#
cat("cl$pets has", count_na(cl["pets"]), "NA values\n")
cat("----------------------------------------------------\n")

#    C. I truly don't know what "Include the result in your answer is asking me 
#    to do here..
print(lapply(cl, count_na))
cat("----------------------------------------------------\n")
#    d. Which columns have 0 missing values? [comprehension]
for(col in colnames(cl)) {
  if(count_na(cl[col]) == 0) {
    cat(col, "\thas no NA values\n")
  }
}
cat("\n5.\n#################################################################\n")



# 5. This csv covers craigslist postings from "2021-01-30"  to "2021-03-04"
#     based on the tip, we can convert the data using the as.Date() function.
print(range(as.Date(cl$date_posted)))
cat("\n6.\n#################################################################\n")



# 6. If we simply check the mean price compared to the pet policy we get
#    strange results, luckily nobody underwrites this way. If we divide the mean
#    price per category by the mean square foot per category or "group"
#    we arrive at a sensical result that reflects the price per square foot
#    by group. The data shows that none<cats<dogs<both... which makes sense.
#
#   Here I am using tapply to split the numerical vectors into groups which
#   are labeled by the second passed vector cl$pets, as shown in unit 7.
#   I am also passing the argument na.rm = TRUE to remove NA results.
ppsqft <- (tapply(cl$price, cl$pets, mean, na.rm = TRUE) / 
             tapply(cl$sqft, cl$pets, mean, na.rm = TRUE))
print(sort(ppsqft))
cat("\n7.\n#################################################################\n")



# 7. In my example vector a is in reverse order (alphabetically), and vector b 
#    is also in reverse order. order(b) will return (4,3,2,1) which will index
#    vector a in sorted order... 
a <- c("d", "c", "b", "a")
b <- c(4, 3, 2, 1)
cat(a[order(b)])
cat("\n\n8.\n###############################################################\n")



# 8. Here I am just storing the sorted cl in a new variable. I'm also sorting by
#    indexing the rows ie. [row, col]...
sorted_cl <- cl[order(cl$sqft),]

#
#     A. Here I am updating / creating my data.frame to be sorted in decreasing
#   order just to make it easier to show the 5 largest. We can subset the
#   first 5 rows with 1:5. I'm also indexing the columns with a vector with the
#   desired names.
cols <- c("city", "sqft", "price")
sorted_cl <- cl[order(cl$sqft, decreasing = TRUE), cols][1:5, ]

print(sorted_cl)
cat("----------------------------------------------------\n")
#     B. Lets take the z score. Based on the results, the largest listing,
#   with a sqft of 88900, is 50 standard deviations from the mean, while the 
#   second largest is 4 standard deviations from the mean. These are both 
#   considered outliers, and the largest is probably a typo considering its low
#   price.
sd_sqft   <- sd(cl$sqft, na.rm = TRUE)
mean_sqft <- mean(cl$sqft, na.rm = TRUE)
for(listing in sorted_cl$sqft) {
  cat(listing, "is", ((listing - mean_sqft) / sd_sqft), 
  "standard deviations away from the mean\n")
}
cat("----------------------------------------------------\n")
#     C. I actually already answered this above by accident. Yes I believe the
#   largest listing is incorrect data, and the second largest might
#   be incorrect as well, based off of the deviation/sqft/price.
