fulltable <- function(rootpath)
{
  setwd(rootpath)
  headerd <- headdf(rootpath)
  
  testdf <- testdata(rootpath, "TEST", headerd)
  traindf <- testdata(rootpath, "TRAIN", headerd)
  
  ftable <- bind_rows(testdf, traindf) #detailed, need to add
  
  ftable %>% group_by(Subject, Activity) %>% summarize_each(funs(mean)) # summary
}  

headdf <-  function(rootpath)
{
  
  features <- read.csv("features.txt", colClasses = "character", header=FALSE)
  rawcolumns <- grep("((-mean)\\(\\))|((-std)\\(\\))",  features[,1],  value=TRUE)
  headerdf  <- data.frame(do.call(rbind, strsplit(rawcolumns, " ")))
  headerdf[,1] <- as.numeric(as.character(headerdf[,1]))
  headerdf
}

testdata <- function(rootpath, type, headf)
{
  if(type == "TEST")
  {
    rawx <- read.table("./test/X_test.txt", header = FALSE)
    subjecttest<-read.csv("./test/subject_test.txt",  header = FALSE)
    activitytest<-read.csv("./test/y_test.txt",  header = FALSE)
  }
  else if(type == "TRAIN")
  {
    rawx  <- read.table("./train/X_train.txt", header = FALSE)
    subjecttest<-read.csv("./train/subject_train.txt",  header = FALSE)
    activitytest<-read.csv("./train/y_train.txt",  header = FALSE)
  }
  tidytable <- rawx[,headf[,1]]
  colnames(tidytable) <- headf[,2]
  
  subjecttest<-tbl_df(subjecttest)
  activitytest<-tbl_df(activitytest)
  subandactivity<-bind_cols(subjecttest,activitytest)
  names(subandactivity)=c("Subject","Activity")
  subandactivity<-subandactivity %>% mutate(Activity=replace(Activity, Activity == 1, "WALKING"))
  subandactivity<-subandactivity %>% mutate(Activity=replace(Activity, Activity == 2, "WALKING_UPSTAIRS"))
  subandactivity<-subandactivity %>% mutate(Activity=replace(Activity, Activity == 3, "WALKING_DOWNSTAIRS"))
  subandactivity<-subandactivity %>% mutate(Activity=replace(Activity, Activity == 4, "SITTING"))
  subandactivity<-subandactivity %>% mutate(Activity=replace(Activity, Activity == 5, "STANDING"))
  subandactivity<-subandactivity %>% mutate(Activity=replace(Activity, Activity == 6, "LAYING"))

  bindfull <- bind_cols(subandactivity, tidytable)
  bindfull
}

