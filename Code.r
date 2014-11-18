setwd("C:/Users/Jeanette/datasciencecoursera/Geting and Cleaning Data/classproject/Data")
library("plyr", lib.loc="~/R/win-library/3.1")

##step one
## read and merge the tables
test.subject <- read.table(".\\test\\subject_test.txt")
train.subject <- read.table(".\\train\\subject_train.txt")
join.subject <- rbind(train.subject, test.subject)

test.set <- read.table(".\\test\\X_test.txt")
train.set <- read.table(".\\train\\X_train.txt")
join.set <- rbind(train.set, test.set)

test.lables <- read.table(".\\test\\y_test.txt")
train.lables <- read.table(".\\train\\y_train.txt")
join.lables <- rbind(train.lables, test.lables)

##step 2

##reading in features
features <- read.table(".\\features.txt")## inporr features
features <-rename(features,replace = c("V1"= "index","V2"="name"))## rename variables
features <- features[grep("mean\\(\\)|std\\(\\)", features$name),]## index by mean and std

##clean features names
features$name <- tolower(features$name)
features$name <- gsub("\\(\\)", "", features$name) ## remove parentheses
features$name <- gsub("\\-", "\\.", features$name) ## replace hyphens with periods
features$name <- gsub("^t", "time\\.", features$name) ## replace t prefix with time
features$name <- gsub("^f", "frequency\\.", features$name) ## replace f prefix with frequency
features$name <- gsub("bodybody", "body", features$name) ## fix double body

##inport and edit activity lables
activity <- read.table("C:/Users/Jeanette/datasciencecoursera/Geting and Cleaning Data/classproject/Data/activity_labels.txt", quote="\"")
activity <-rename(activity,replace = c("V1"= "index","V2"="activity"))

##subset features by mean and std
colindex <- rep("NULL", 561)
colindex[features[, features$index]]

