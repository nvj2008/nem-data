
# Part 2. Combine and load data

# 2.A | install and load required packages
#install.packages('data.table')
#install.packages('plyr')
library(data.table)
library(plyr)

# clear list
rm(list=ls())

# set output drive based on operating system - Linux or Windows
if (Sys.info()[1]=="Linux"){
  out_dir<-paste('/home/vijay/Dropbox/Code/NemWEB/data_extract/')
} else {
  if (Sys.info()[1]=="Windows"){
    out_dir<-paste('D:/Cloud/Dropbox/Code/NemWEB/data_extract/')
  } else {
    print('OS Unrecognized')
  }
}


#   Inspiration below from http://www.r-bloggers.com/merging-multiple-data-files-into-one-data-frame/
#   multmerge = function(mypath){
#   filenames=list.files(path=mypath, full.names=TRUE)
#   datalist = lapply(filenames, function(x){read.csv(file=x,header=T)})
#   Reduce(function(x,y) {merge(x,y)}, datalist)

# 2.B | Get filenames
filenames = list.files(path=out_dir,pattern="*[A-Z][0-9][0-9][0-9][0-9][0-9][0-9].csv",full.names=TRUE)
datalist = lapply(filenames, function(x){read.csv(file=x,header=T)})

# 2.C | Load data

#   nem<-Reduce(function(x,y) {merge(x,y,all=T)}, datalist)
#   rbind.fill from plyr is faster than rbind. 2.5mins vs 20 seconds. 
#   even faster is mcapply, but it doesn't work on Windows because it relies on 'forking'. workaround: http://www.r-bloggers.com/parallelsugar-an-implementation-of-mclapply-for-windows/

#TIME = Sys.time()
#nem<-do.call(rbind,datalist)
#nem_dt<-as.data.table(nem)
#Sys.time()-TIME # rbind: 2.5 mins

# the following requires plyr to be loaded
TIME = Sys.time()
nem<-do.call(rbind.fill,datalist)
nem_dt<-as.data.table(nem)
Sys.time()-TIME # rbind.fill: 20 seconds

# library(parallel)
# rbind.fill.parallel <- function(list){
#   while(length(list) > 1) {
#     idxlst <- seq(from=1, to=length(list), by=2)
#     
#     list <- mclapply(idxlst, function(i) {
#       #print(i) #uncomment this if you want to see progress
#       if(i==length(list)) { return(list[[i]]) }
#       return(rbind.fill(list[[i]], list[[i+1]]))
#     })
#   }
# }
# TIME = Sys.time()
# nem<-do.call(rbind.fill.parallel,datalist)
# nem_dt<-as.data.table(nem)
# Sys.time()-TIME # rbind.fill.parallel: Didn't work. Got errros. 4.5 mins.


# 2.D | Check Data
class(datalist)
class(nem)
class(nem_dt)

summary(nem_dt)
head(nem_dt)
str(nem_dt)
tables()
#done

# 2.E | Write to file
write.csv(nem_dt,paste(out_dir,'NEMWEB_',format(Sys.time(),format="%Y%m%d_%H%M%S"),'.csv',sep=''))

# Show objects
ls()
objects()

# Finished Running part 2; data loaded.

