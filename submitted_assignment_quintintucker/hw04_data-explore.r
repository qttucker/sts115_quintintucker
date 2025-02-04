
# 1.
#
#   a. The extension .py stands for Python.. This means myscript.py is a   
#   Python script ( an executable python program which contains its 
#   own source code. )
#
#   b. The extension .jpg indicates that '/home/arthur/images/selfie.jpg'
#   is a JPEG (Joint Photographic Experts Group) image file.
#
#   c. The extension .csv stand for Comma-Separated values. This indicates that 
#   the file `~/Documents/data.csv` is a text file containing comma separated 
#   data values, typically used for a spreadsheet or database.



# 2.
#
#   The Unix command file will analyze a file's contents and return its type
#   regardless of its extension.



# 3.
#
#   To use setwd in an R script you would need a guarantee that whenever this
#   script was run, the user's system has a file structure consistent with the
#   the original system. This is a much larger assumption than using a relative 
#   path which only assumes a relative path to the file ie within the same folder
#   or in the parent folder etc. Ultimately, using setwd lowers portability
#   and may result in unknown side effects and might break the script.



# 4.
#   
#     a. RDS files
#     Advantage: R specific file-type that saves R objects and date in a binary 
#     file. This means all information is kept and the file will be much smaller.
#
#     Disadvantage: It's R specific and isn't portable to other software such as 
#     Excel or Python.
#
#
#     b. CSV files
#     Advantage: A raw text file that can be read by any software that can
#     process text, so it is highly portable and transparent.
#
#     Disadvantage: By their nature text files are much larger than their binary
#     counterparts and have longer read and write times. csv files also do not 
#     contain R specific data



# 5.
#
#   Assuming that you had the RAM.. this would still most likely cause many
#   namespace collisions which you could find using the conflicts() command,
#   and you could explicitly name each namespace for each call with the ::
#   operator, but this would still clutter your space with thousands or 
#   millions of lines of code, and unnecessarily bog down your systems resources.



# 6.
#
# a. We can explicitly loop through the height column and add up how many values
#   match NA with the built-in is.na() function, or we can take advantage of the
#   fact that is.na() returns a logical vector and we can use the sum() function
#   to add them all up for us, since a logical true is a 1 this will find the
#   answer for us. (the answer is 13)
dogs <- readRDS("../dogs.rds")
num <- 0
for(height in dogs$height) {
  if(is.na(height)) {
    num <- num + 1
  }
}
cat("There are ",num, " NA values in dogs$height\n")
num <- 0
num <- sum(is.na(dogs$height))
cat("There are ",num, " NA values in dogs$height\n")
num <- 0

# b. We can use the same strategy as part a. to add the number of NA values in
#   all columns. We can sum the entire data frame in one line by not specifying
#   the column.
cat("There are ", sum(is.na(dogs)), "NA values in dogs\n")

#
# c. We can use the colSums function to create a vector with the sum of the i'th
#   column at index i. The which.max() function will tell us the index with the 
#   largest sum, and the names() function will return us the header/name of that
#   column.
i <- which.max(colSums(is.na(dogs)))
print(paste0("The column with the most NA values is dogs$", names(dogs[i])))



# 7. We can index which rows match these conditions by simply putting the 
#   comparisons in the row index ie dogs[row,col]. I quickly found that this
#   also included all the rows that had NA values so these had to also be 
#   excluded with !is.na()
print(dogs[!is.na(dogs$kids) & !is.na(dogs$size) & 
             dogs$kids == "high" & dogs$size == "large", c("breed",
                                                           "kids", "size")])


# 8.
#
# a. Here I am indexing dogs the same way as above but only showing two columns
#   just to keep my output clean. I'm checking that the value in the grooming
#   column matches "daily" and is not NA.
print(dogs[dogs$grooming == "daily" & !is.na(dogs$grooming),
                c("breed", "grooming")])
#
# b. I already did this in part a. Let's do it again and run nrows() to count
#   how many breeds need daily grooming. The answer is 23.
print(paste("There are",
  nrow(dogs[dogs$grooming == "daily" & !is.na(dogs$grooming), ]), 
  "breeds in dogs that require daily grooming"))
#
# c. I'm getting the same number, 23, for both counts. This might be because I
#   excluded NA values from my previous count.
print(table(dogs$grooming))

#
# d. Yes I'm still getting the number 23. The function which() takes a logical
#   vector and returns the TRUE values, so it excludes NA and FALSE
#   values for us.
cat(nrow(dogs[which(dogs$grooming == "daily"), ]))



# 9. We can use the table function to create a table comparing dog size and
#   their levels of washing. This table is telling us that the small dogs
#   require more grooming than medium and large dogs, since about
#   16% of large dogs, 21% of medium, and 23% of small dogs require daily
#   grooming. This indicates that there is a relationship between size and 
#   level of grooming.
print(table(dogs$grooming, dogs$size))



# 10. Compute the number of dogs in the `terrier` group in two different ways:
#
#     a. By making a table from the `group` column. 
#       [code completion + comprehension]
#
#     b. By getting a subset of only terriers and counting the rows.
#       [code completion + comprehension]
#
#     c. Computing the table is simpler (in terms of code) and provides more
#        information. In spite of that, when would indexing (approach b) be more
#        useful? [comprehension + interpretation]

# 10.
#
# a.  We can use the table function and simply pass it the $group column and it
#   will print the count for each value for us. There are 28 terriers.
print(table(dogs$group))

# b. Here we do the same as above, index with a conditional in the row index
#   and include the !is.na() conditional to exclude NA values from our count
#   we then simply use nrow() to count the answer. As we saw above we could 
#   also use the which() function to exclude NA values by default.
print(nrow(dogs[!is.na(dogs$group) & dogs$group == "terrier", ]))

# c.  Using a table is great for human analysis, but if we want to know what
#   rows these values are on, or do further computation with the results,
#   returning their subset is a better way of actually working on the data.
#   indexing also allows us to massage the data in more complex and powerful
#   ways than using a standard table.