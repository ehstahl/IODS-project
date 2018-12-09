Author: Erik Stahl
Date: 6.12.2018
#Week 6: Analysis of longitudinal data, wrangling.

library(dplyr)
library(tidyr)

#Read in the datasets BPRS and RATS in wide form.
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep=" ", header=TRUE)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep='\t', header=TRUE)

#Print out structures of both datasets.
str(BPRS)
str(RATS)

#BPRS comprises of test persons psychiatric evaluation scores over 9 weeks.
#RATS depict the body weight of rats over a 9 week period.
#Both datasets are in wide form, ergo a high number of columns (because of the weeks).
#Both sets can easily be converted into long form by gathering together the week columns.
#In the BPRS-set the weeks can be grouped into a single column, which only uses a digit to identify said week.
#And the same thing can be done with the rats-set, pool the days (WD) into a single column.

#Before we convert into long form, we factor the categorical variables.

BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

#And now we convert the sets to long form.

BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks, 5, 5)))

RATSL <- RATS %>% gather(key = WD, value = Weight, -ID, -Group) %>% mutate(Time = as.integer(substr(WD, 3, 4)))

glimpse(BPRSL)
glimpse(RATSL)

#As we can see, by converting the sets into long form we've now reduced the number of columns from 11 and 13 to 5 in both cases.
#Simultaneously the number of observations have increased from 40 and 16 to 360 and 176.
#It is important to point out that no data has been lost or discarded thus far in the process, it's only been transformed.
#With the data in this form, it can now be used for another analytical focus. For example using the weeks/days as an explanatory variable and getting a clearer picture of subjects development over time.

