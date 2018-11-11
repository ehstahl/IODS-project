
Author: Erik Stahl
Date: November 9, 2018
#The task of the second week. Data wrangling, data analysis and regression.
#Data source: http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt

library(dplyr)

L14 <- read.table(
  "http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt",
  sep="\t",
  header=TRUE)

#After the data has been read in by R, the object has the format data.frame.
# The function "dim" returns the number of rows and columns in the table of the object.

dim.data.frame(L14)

#Outputs 183 rows and 60 columns, which translates to 183 students and 60 variables.

str(L14)

#The structure function pivots the table 90 degrees, so that the variables are the rows.
# It also shows what data types are used for different variables.
# Integer is the most used one, but in the case of gender it is a categorical/factor variable in two-levels: "1" or "2".

deep_q <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
stra_q <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
surf_q <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")

#Combining the thematic questions (q) into thematic columns (c).

deep_c <- select(L14, one_of(deep_q))
stra_c <- select(L14, one_of(stra_q))
surf_c <- select(L14, one_of(surf_q))

#Creating objects for the columns of the new dataset.
#Calculating means of the new combined columns.

gender <- L14$gender
age <- L14$Age
attidude <- L14$Attitude
deep <- rowMeans(deep_c)
stra <- rowMeans(stra_c)
surf <- rowMeans(surf_c)
points <- L14$Points

#Actually create the new dataset and filter out the observations without points.

toinen2014 <- data.frame(gender, age, attitude, deep, stra, surf, points)
toinen2014 <- filter(toinen, points > 0)

str(toinen2014)

#The new dataset outputs 166 observations and 7 columns.

#write.csv creates a new .csv-file of the dataframe toinen2014.

write.csv(toinen2014,
          file="toinen2014.csv",
          quote = TRUE,
          eol = "\n", na = "NA",
          row.names = FALSE,
          fileEncoding = "")

read.csv(file = "toinen2014.csv")
