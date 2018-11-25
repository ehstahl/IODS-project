
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

dim(hd)
dim(gii)

str(hd)
str(gii)

summary(hd)
summary(gii)

hd$HDI <- hd$Human.Development.Index..HDI.
hd$Human.Development.Index..HDI. <- NULL

hd$GNIperCap <- hd$Gross.National.Income..GNI..per.Capita
hd$Gross.National.Income..GNI..per.Capita <- NULL

hd$GNIminusHDIrank <- hd$GNI.per.Capita.Rank.Minus.HDI.Rank
hd$GNI.per.Capita.Rank.Minus.HDI.Rank <- NULL

gii$GII <- gii$Gender.Inequality.Index..GII.
gii$Gender.Inequality.Index..GII. <- NULL

gii$PercentinParliament <- gii$Percent.Representation.in.Parliament
gii$Percent.Representation.in.Parliament <- NULL

gii$SecEdFem <- gii$Population.with.Secondary.Education..Female.
gii$Population.with.Secondary.Education..Female. <- NULL

gii$SecEdMale <- gii$Population.with.Secondary.Education..Male.
gii$Population.with.Secondary.Education..Male. <- NULL

gii$LabParFem <- gii$Labour.Force.Participation.Rate..Female.
gii$Labour.Force.Participation.Rate..Female. <- NULL

gii$LabParMale <- gii$Labour.Force.Participation.Rate..Male.
gii$Labour.Force.Participation.Rate..Male. <- NULL

str(hd)

str(gii)