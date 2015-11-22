## Code for performing the analysis

## Load packages:  data.table  dplyr

## Read X_train.txt
X_train <- read.table("./train/X_train.txt")
## Read X_test.txt
X_test <- read.table("./test/X_test.txt")
## Read y_train.txt
y_train <- read.table("./train/y_train.txt")
## Read y_test.txt
y_test <- read.table("./test/y_test.txt")
## Read subject_train.txt
subject_train <- read.table("./train/subject_train.txt")
## Read subject_test.txt
subject_test <- read.table("./test/subject_test.txt")


## Merges the training and the test sets to create one data set
HARData_X <- rbind(X_train, X_test)
HARData_y <- rbind(y_train, y_test)
HARData_subject <- rbind(subject_train, subject_test)

## Descriptive variable names
#colnames(HARData_y) <- c("V1")
colnames(HARData_subject) <- c("subject")
labelHARData <- read.table("features.txt")
names(HARData_X) <- labelHARData$V2

## Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table('./features.txt')
mean_sd <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
HARData_X <- HARData_X[, mean_sd]


## Uses descriptive activity names to name the activities in the data set
activity <- read.table('./activity_labels.txt')
activity[, 2] <- tolower(as.character(activity[, 2]))
activity[, 2] <- gsub("_", "", activity[, 2])
HARData_y[, 1] = activity[HARData_y[, 1], 2]

## Data set
DATA <- cbind(HARData_subject,HARData_y,HARData_X)

## Data set as a txt file created with write.table() using row.name=FALSE 
write.table(DATA, file = "TidyData.txt", row.names = FALSE, sep="\t")
## prueba <- read.table("TidyData.txt")