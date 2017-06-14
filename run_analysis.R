run_analysis<- function() {
        #read in all relevant files
        path1<-"UCI HAR Dataset"
        
        path2<-paste(path1,"activity_labels.txt",sep="/")
        activity<-read.table(path2)
        path2<-paste(path1,"features.txt",sep="/")
        features<-read.table(path2)
        
        path2<-paste(path1,"test","subject_test.txt",sep="/")
        subtest<-read.table(path2)
        path2<-paste(path1,"test","y_test.txt",sep="/")
        ytest<-read.table(path2)
        path2<-paste(path1,"test","x_test.txt",sep="/")
        xtest<-read.table(path2)
        
        path2<-paste(path1,"train","subject_train.txt",sep="/")
        subtrain<-read.table(path2)
        path2<-paste(path1,"train","y_train.txt",sep="/")
        ytrain<-read.table(path2) 
        path2<-paste(path1,"train","x_train.txt",sep="/")
        xtrain<-read.table(path2)  
        
        #find columns with mean or std, select only those columns
        index1<-grep("mean()",features$V2)
        index2<-grep("std()",features$V2)
        xtest<-select(xtest,sort(c(index1,index2)))
        xtrain<-select(xtrain,sort(c(index1,index2)))
        
        #use features data to rename the columns
        features<-as.character(features[sort(c(index1,index2)),2])
        names(xtest)<-features
        names(xtrain)<-features
        names(subtest)<-"subject"
        names(subtrain)<-"subject"
        names(ytest)<-"activity"
        names(ytrain)<-"activity"
        
        #replace activity numbers with descriptors from activity_label.txt
        for (i in 1:6) {
                ytest$activity<-gsub(i,activity[i,2],ytest$activity)
                ytrain$activity<-gsub(i,activity[i,2],ytrain$activity)
        }
        
        #merge into one data set
        test<-cbind(subtest,ytest,xtest)
        train<-cbind(subtrain,ytrain,xtrain)
        master<-merge(train,test,all=TRUE)
        
        #group by subject and activity and compute the mean for each measurement 
        summarydata<-dcast(master,subject + activity ~ names(master)[3],mean,value.var=names(master)[3])
        for (i in 4:ncol(master)) {
                tmp<-dcast(master,subject + activity ~ names(master)[i],mean,value.var=names(master)[i])
                summarydata<-merge(summarydata,tmp)
        }
        
        #write text file
        path2<-paste(path1,"tidy_data.txt",sep="/")
        write.table(summarydata,path2,row.name=FALSE)
        
}