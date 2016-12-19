

filepath <-"/Users/mohmmadbadran/Downloads/"

xtest<- read.table(file.path(filepath, "UCI HAR Dataset/test/X_test.txt"))
ytest<- read.table(file.path(filepath,"UCI HAR Dataset/test/Y_test.txt"))
subjecttest <-read.table(file.path(filepath,"UCI HAR Dataset/test/subject_test.txt"))
xtrain<- read.table(file.path(filepath,"UCI HAR Dataset/train/X_train.txt"))
ytrain<- read.table(file.path(filepath,"UCI HAR Dataset/train/Y_train.txt"))
subjecttrain <-read.table(file.path(filepath,"UCI HAR Dataset/train/subject_train.txt"))
features<-read.table(file.path(filepath,"UCI HAR Dataset/features.txt"))
activity<-read.table(file.path(filepath,"UCI HAR Dataset/activity_labels.txt"))

#Merges the training and the test sets to create one data set.
x<-rbind(xtest, xtrain)
y<-rbind(ytest, ytrain)
subject<-rbind(subjecttest, subjecttrain)

# Extracts only the measurements on the mean and standard deviation for each measurement.

index<-grep("mean\\(\\)|std\\(\\)", features[,2])
x<-x[,index]

#Uses descriptive activity names to name the activities in the data set

y[,1]<-activity[y[,1],2] 
head(y) 

#Appropriately labels the data set with descriptive variable names.
names<-features[index,2] 

names(x)<-names 
names(subject)<-"SubjectID"
names(y)<-"Activity"

CleanedData<-cbind(subject, y, x)
head(CleanedData[,c(1:4)]) 


#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

CleanedData<-data.table(CleanedData)
TidyData <- CleanedData[, lapply(.SD, mean), by = 'SubjectID,Activity'] 

write.table(TidyData, file = "Tidy.txt", row.names = FALSE)


