setwd("C:/Users/Jeanette/datasciencecoursera/Geting and Cleaning Data/classproject/Data")
library("data.table", lib.loc="~/R/win-library/3.1")
library("reshape2", lib.loc="~/R/win-library/3.1")

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

names(join.subject) <- "subject"

## creading features indix and cleaning names 
features <- read.table(".\\features.txt")## inporr features
features <-rename(features,replace = c("V1"= "index","V2"="name"))## rename variables
mean.std.index <- grep("mean\\(\\)|std\\(\\)", features$name)

join.set<- join.set[,mean.std.index]

names(join.set) <- tolower(features[mean.std.index, 2])
names(join.set) <- gsub("\\(\\)", "", features[mean.std.index, 2]) ## remove parentheses
names(join.set) <- gsub("\\-", "\\.", features[mean.std.index, 2]) ## replace hyphens with periods
names(join.set) <- gsub("^t", "time\\.", features[mean.std.index, 2]) ## replace t prefix with time
names(join.set) <- gsub("^f", "frequency\\.", features[mean.std.index, 2]) ## replace f prefix with frequency
names(join.set) <- gsub("bodybody", "body", features[mean.std.index, 2]) ## fix double body

## reading activitesn in and cleaning up names
activity <- read.table("C:/Users/Jeanette/datasciencecoursera/Geting and Cleaning Data/classproject/Data/activity_labels.txt", quote="\"")
activity <-rename(activity,replace = c("V1"= "index","V2"="activity"))
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))

##creating an activity index
activity.label <- activity[join.lables[, 1], 2]
join.lables[, 1] <- activity.label
names(join.lables) <- "activity"

##merging tables and saving clean data as text file
clean.data <- cbind(join.subject, join.lables, join.set)
write.table(clean.data, file = "clean_data.txt")


##step 5
melt.data <- melt(clean.data, id = c("subject", "activity"))
tidy.data <- dcast(melt.data, subject + activity ~ variable, mean)
return(tidy.data)
write.table(tidy.data, file="tidy.data.txt",row.name=FALSE )
