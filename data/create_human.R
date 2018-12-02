Author: "Erik Stahl"
Date: "30.11.2018"
#Script for the data wrangling exercise of week 5
#Data source: http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt

library(dplyr)
library(stringr)

human <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt",
                    sep=",",
                    header=TRUE)

# dim(human)
# str(human)

#The table has 195 observations (countries in this case) and 19 variables.
#The Human development index (HDI) is meant to give a more detailed view of the growth of countries.
#By including factors of human capabilities and quality of life, it can raise questions about how equally wealthy countries (GNI at same level) can differ in terms of quality of life.
#In the data the quality of life factors are made visible in variables such as life expectancy (Life.Exp), maternal mortality rate (Mat.Mor) and share of seats in parliament held by women (Parli.F).
#The last one is maybe not an explicit quality of life factor, but indeed an inequality one. HDI also addresses inequality.

#Next: mutate variable GNI into a numeric.

human$GNI <- str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric()

#Exclude unwanted variables.

keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human <- dplyr::select(human, one_of(keep))

#Get rid of rows with one or more missing values (NA).

human_minusNA <- filter(human, complete.cases(human) == TRUE)

#View the last 10 observations in the new set.

tail(human_minusNA, n=10)

#Remove the last 7 observations, because they are regions and not countries.

reg <- nrow(human_minusNA) - 7
human_minusNA <- human_minusNA[1:reg,]

#Set the names from the countries variable as rownames.

rownames(human_minusNA) <- human_minusNA$Country
human_minusNA$Country <- NULL

dim(human_minusNA)

write.csv(human_minusNA, file="create_human.csv", row.names = TRUE)
