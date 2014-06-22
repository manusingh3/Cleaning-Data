>setwd("C:/Users/SONY/Documents/UCI HAR Dataset")		##sets the working directorr
> traindata1 <-read.table("./train/X_train.txt")		##read x_train into r	
> traindata2 <-read.table("./train/subject_train.txt")		##read subject_train into r
> traindata3 <-read.table("./train/y_train.txt")		##read y_train into r
> combtrain<-cbind(traindata1,traindata2,traindata3)		##combine the columns of the above files into a dataset
 
> testdata1 <-read.table("./test/x_test.txt")			##read x_test into r
> testdata2 <-read.table("./test/subject_test.txt")		##read subject_test into r
> testdata3 <-read.table("./test/y_test.txt")			##read y_test into r
> combtest<-cbind(testdata1,testdata2,testdata3)		##combine the columns of the above files into a dataset

 
>combdata <-rbind(combtest,combtrain)				##combine the two datasets together to create a working major dataset
 
>namtab <-read.table("features.txt")				##read the column names from features file and save it as namtab
>colnames(combdata)<-namtab[,2]					##assign the colnames of major data set by using the 2 column of featues file

 
>name <-names(combdata)						##save the names of the major dataset into a new variable called name-useful while using grep fun

 
>meantable <-combdata[,grep("mean",name)]			##create meantable using grep function to extract only those columns where col name has "mean" in it
>stdtable <-combdata[,grep("std",name)]				##create stdtable using grep function to extract only those columns where col name has "std" in it
>namef <-names(meantable) 					##assign the names of columns of meantable to new variable
>meantable1 <-meantable[,!grepl("Freq",namef)]			##create new variable meantable1 where "meanFreq" have been eliminated	
 
 
>subject <-rbind(traindata2,testdata2)				##assign new variable names to subject data
>activity <-rbind(traindata3,testdata3)				##assign new variable name to avtivity data	
>mergdata <-cbind(meantable1,stdtable,subject,activity)		##combine all the columns of mean table,std table, activities and subjects
>names(mergdata)[67] <- "subject"				##rename the last column from V1 to subject
>names(mergdata)[67] <- "activity"				##rename the last column from V1 to activity	


> for (i in 1:10299){						##looping through all the 10299 rows that are created the script checks the activity number 
 								##for all the rows and accordingly assigns it the necessary activity name.	
 if(mergdata[i,68] == 1) {					
   mergdata[i,68] <- "WALKING"}
 
 if(mergdata[i,68] == 2) {
   mergdata[i,68] <- "WALKING_UPSTAIRS"}
 
 if(mergdata[i,68] == 3) {
   mergdata[i,68] <- "WALKING_DOWNSTAIRS"}
 
 if(mergdata[i,68] == 4) {
   mergdata[i,68] <- "SITTING"}
 
 if(mergdata[i,68] == 5) {
   mergdata[i,68] <- "STANDING"}
 
 if(mergdata[i,68] == 6) {
   mergdata[i,68] <- "LAYING"}
 }
>meltdata <-melt(mergdata, id=c("subject","activity") )		##data is melted using subject and activity as id 
>newdata <-dcast(meltdata,subject+activity~variable,mean)	##data is recast using both subject and id as parameters and mean is calculated for each

>sink("newdata.txt")						##newdata.txt is created to save the output of the file	
> newdata							##newdata is saved to the new file
>sink(NULL)							##output saving to txt file is closed