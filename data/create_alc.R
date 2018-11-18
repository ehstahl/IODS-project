Author: Erik Stahl
Date: November 17, 2018
#Script for the data wrangling exercise of week 2
#Data source: https://archive.ics.uci.edu/ml/machine-learning-databases/00320/

library(dplyr)

#Read in the data from files.
mat <- read.table("student-mat.csv", sep=";", header=TRUE)
por <- read.table("student-por.csv", sep=";", header=TRUE)

dim(mat)
str(mat)
dim(por)
str(por)
#Both data sets have the same amount variables (33) but the por has
#more observations (649) than mat (395).
#Both sets have int and categorical data types in their variables.

#Define the variables to use when joining the two data sets.
id_col <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

mat_por <- inner_join(mat, por, by = id_col)
#Inner_join returns all rows from x (mat) where there are matching values in y (por).
#But it returns all columns from both x and y, so observations should decrease due to matching but columns increase.

str(mat_por)
#Indeed, 382 observations and 53 variables.

#Use the Datacamp solution to combine "duplicated" answers in the joined data.
alc_df <- select(mat_por, one_of(id_col))

id_not <- colnames(mat)[!colnames(mat) %in% id_col]

for(column_name in id_not) {
  two_columns <- select(mat_por, starts_with(column_name))
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc_df[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc_df[column_name] <- first_column
  }
}

glimpse(alc_df)
#Through combining overlapping variables, the variable count is now down from 53 to 33.
#Note though that the mat_por still has 53, all changes have been made to the new dataframe alc_df.

alc_df <- mutate(alc_df, alc_use = (Dalc+Walc) / 2)
alc_df <- mutate(alc_df, high_use = alc_use > 2)
#Two columns added to the dataframe. The first is average alcohol use over weekdays and weekends.
#The second column is logical. Returns true if the alc_use returns a figure above 2.

glimpse(alc_df)
#With the two columns added to the dataframe, the dimensions are now 382 observations (students) and 35 variables.

write.csv(alc_df, file="create_alc.csv", row.names = FALSE)
