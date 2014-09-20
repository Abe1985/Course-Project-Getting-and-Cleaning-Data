## First, I read the readme file 
## Then I read all files in R with the read.table funktion to take a first look, f.e. with head() or tail()
Feat <- read.table("./UCI HAR Dataset/features.txt")
AL <- read.table("./UCI HAR Dataset/activity_labels.txt")
testS <- read.table("./UCI HAR Dataset/test/subject_test.txt")
testY <- read.table("./UCI HAR Dataset/test/y_test.txt")
testX <- read.table("./UCI HAR Dataset/test/x_test.txt")
TrainS <- read.table("./UCI HAR Dataset/train/subject_train.txt")
TrainX <- read.table("./UCI HAR Dataset/train/x_train.txt")
TrainY <- read.table("./UCI HAR Dataset/train/y_train.txt")

## fist we have to combine the test and the training data to complete data sets
## rbind adds the rows of the trainingset after the rows of the testset:

S <- rbind(testS,TrainS) 
Y <- rbind(testY,TrainY)
X <- rbind(testX,TrainX)

## Y contains the labels for the activities, but only as a number
for(i in 1:10299){
    if(Y[i,1]=="1"){Y[i,1] <- c("WALKING")}    
    else if(Y[i,1]=="2"){Y[i,1] <- c("WALKING_UPSTAIRS")}
    else if(Y[i,1]=="3"){Y[i,1] <- c("WALKING_DOWNSTAIRS")}
    else if(Y[i,1]=="4"){Y[i,1] <- c("SITTING")}
    else if(Y[i,1]=="5"){Y[i,1] <- c("STANDING")}
    else if(Y[i,1]=="6"){Y[i,1] <- c("LAYING")}
    else{next}
} ## exchanges the id for the labels in y with the right Activity names


## The Readme further says that : Each feature vector is a row on the text file, so I took the vectors as row names:
nlist <- as.character(Feat[,2]) ##list only the values in column two of Feat
names(X) <- c(nlist)    ##give the columns the right names
## the features.text file has often bodybody, that does not look good, need to change that:

sub("bodybody","body",names(X),) ## exchange bodybody with only body

## The ReadME file explains that the y_files contain the lables and subect_files the subjects 
## from 1 to 30 so I want to add them as columns for the x_file with the observations
## we should only pick the means and standard deviations:

mT <- grep("mean", names(X)) ## only returns the numbers of those columns, that contain the word mean
sT <- grep("std", names(X)) ## only returns the numbers of those columns, that contain the word std
msX <- X[,c(mT,sT)] ## only return the columns that contain std or mean in a seperate table

## The ReadME said, that the y test and train files are the labels of the x files
## so I added them as a column name label in the x file:

## turn x_test dataset into a data frame and get the correct names of the observation out of the Features table
names(Y) <- c("activities")
## names the obervations in Y as labels
LabelX <-cbind(msX,Y)
names(S) <- c("subject")
## names the subjectids "subject" to recognize them better onye i added them to the x data frame
SYX <- cbind(LabelX,S)

library(reshape2)  ##to use the following codes we need to load the reshape2 data package
SYXmelt <- melt(SYX, id=c("subject","activities"))
## now i want 30 different martixes for every subject
SYXs <- split(SYXmelt,SYXmelt[,1]) ## splits the data by subject
SYXclean <- lapply(SYXs, dcast, activities ~variable, mean) ##melts the variables down to their mean by every activity
##for each subject
write.table(SYXclean,file="CourseProjectTextFile.txt", row.name=FALSE) ##writes the cleanData into a text file
