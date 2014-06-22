#Jorge de la Vega
#Coursera, Data Cleaning, Project
#June 21, 2014

#Tasks to do: 
#You should create one R script called run_analysis.R that does the following. 

#1. Merges the training and the test sets to create one data set. AND
#3. Uses descriptive activity names to name the activities in the data set
setwd("~/Documentos//Coursera/Programa/CleanData/Ass1/UCI HAR Dataset/")
#reading data and remove unnecesary variables (they are LARGE!)
train = cbind(subset = "train", subject = scan("./train/subject_train.txt"), 
              activity = scan("./train/y_train.txt"), read.table("./train/X_train.txt"))
test  = cbind(subset = "test", subject = scan("./test/subject_test.txt"), 
              activity = scan("./test/y_test.txt"), read.table("./test/X_test.txt"))
datos = data.frame(rbind(train,test), 
rm(test,train)

# Read names of variables (features) and assign to columns of data set, assuring that the names are 
# syntactically valid
features = make.names(as.character(read.table("features.txt")[,2]))
colnames(datos) <- c("subset","subject","activity",features)

#write tidy data set to a file.
write.table(datos, file="../tidyDataSet.txt")

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# Using regular expressions, select only those variables that end with mean or std. Note that i decided
# not to include forx example Gravitymean or the meanFreq concepts, since these are features of the original 
# data and not computations on the mean 
datos2 = datos[,c(1:3,3+grep("mean[.]",features),3+grep("std[.]",features))]

#4. Appropriately labels the data set with descriptive variable names. 
# ANS: the variables are already named and the catalog of features has the details of the variables. 

#5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
datos3 = aggregate(datos[,-(1:3)],by = list(subject = datos$subject, activity = datos$activity),mean)
write.table(datos, file="../SummaryTidyDataSet.txt")
