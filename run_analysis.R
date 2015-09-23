##COURSE PROJECT - GETTING AND CLEANING DATA
##Prepared by LTM - 9/24/15


library("reshape2")

#downloads and unpacks data into local directories
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
d_file <-"CP_ZIP.zip"
setwd("/Users/LTM/Documents/New World Order/Cleaning Data/Course Project/")
download.file(url,d_file,method="libcurl")
unzip(d_file)
setwd("./UCI HAR DATASET/")

##Reads in proper metric names for later assignment to data
features <-read.table("features.txt")

##reads in and extracts just the activity labels
act_labels <- read.table("./activity_labels.txt")

##reads test data into R data frame ; X is metric data ; Y is activity category ; subject is subject ID
x_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
sub_test <- read.table("./test/subject_test.txt")

##gives each column a descriptive name
names(x_test)<-features[,2]
names(sub_test) = "subject"
names(y_test)="activity"

##binds all  test data together
test<-cbind(sub_test,y_test,x_test)

##reads in training data into R data frames
x_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
sub_train <- read.table("./train/subject_train.txt")

##gives each column a descriptive name
names(x_train)<-features[,2]
names(sub_train)="subject"
names(y_train)="activity"

##binds all training data together
train<-cbind(sub_train,y_train,x_train)

#binds the all of the data by rows
merged_dat <- rbind.data.frame(test,train)

##extracts just mean & SD
ext_features <- grepl("mean|std", features[,2])
merged_dat_sub <- merged_dat[,ext_features]

##melts the data based witrh subject and activity still intact
melt_dat = melt(merged_dat_sub, id = c("subject","activity"))

##recasts the melted data to a new df with the mean function applied
out_dat = dcast(melt_dat, subject + activity ~ variable, mean)

##converts the activity numeric ids to descriptive names
##note that I did this at the end in contrast to the prescibed order as it seemed unnecesary before
out_dat$activity <- as.character(out_dat$activity)
for (i in 1:6){
        out_dat$activity[out_dat$activity == i] <- as.character(act_labels[i,2])
}

##Writes out final dataset 
write.table(out_dat, file = "./tidy_dataframe.txt",row.name=FALSE)


##Fin