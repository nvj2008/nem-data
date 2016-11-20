# Part 1. Getting Data

# 1.A | install and load required packages

#install.packages('bitops')
#install.packages('stringr')
#install.packages('RCurl')
#install.packages('data.table')
#install.packages('plyr')

library('bitops')
library('stringr')
library('RCurl')

# 1.B | Setup variables and directories

# define variables
rm(list=ls())
mth_start=1
yr_start=1998

mth_now=format(Sys.Date(),"%m")
yr_now=format(Sys.Date(),"%Y")


# generate list of URLs
yrs_vector=sort(c(rep(yr_start:yr_now,12)))
mths_vector=c(mth_start,str_pad(rep_len(1:12,length(yrs_vector)-1),pad='0',width=2))
date_vector=as.numeric(paste(yrs_vector,mths_vector,sep=''))

states_list<-c('NSW','SA','QLD','VIC','TAS','SNOWY')

# generate log file
log<-c('in_file','out_file','date_downloaded','error')

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
  
# create output directory if it doesn't exist
if (!file.exists(out_dir)) {dir.create(out_dir)}

# create progress bar
pb = txtProgressBar(min = 0, max = length(states_list)*length(date_vector), initial = 0, style=3) 

# loop through each value in date vector and state vector to generate URLs and get files
    # I can either load everything into RAM, and create a final output file on harddrive. Should be faster but ram internsive. 
    # Or save subfiles into harddrive. Might be useful to have the files there, do checking etc. 
    # help("for"), help("if")

# 1.C | Grab files if they aren't already downloaded.
TIME=Sys.time()

for (i in 1:length(states_list)) {
  for (j in 1:length(date_vector)) {

    state='NSW'
    date = 199812
    #state<-states_list[1]
    #date<-date_vector[1]
    state<-states_list[i]
    date<-date_vector[j]
    
    in_file<-paste('http://www.nemweb.com.au/mms.GRAPHS/data/DATA',date,'_',state,'1.csv',sep='')
    out_file<-paste(out_dir,state,date,'.csv',sep='')

    if (url.exists(in_file)) {
      if(!file.exists(out_file)) {
      download.file(in_file,out_file)
      log<-rbind(log,c(in_file,out_file,date(),"N"))
      # data<-rbind(data,in_file)
      } else {log<-rbind(log,c(in_file,out_file,date(),"file exists"))}
    } else {log<-rbind(log,c(in_file,out_file,date(),"Y"))}

    # This is one way to do a progress bar, but its a workaround and will actually use Sys.sleep(n) as n seconds of 'visible' time. if removed, then you dont see a progress bar. if included it sleeps this much each iteration - slows down the program. 
    #cat(paste0((i-1)*length(date_vector)+j," out of ",length(states_list)*length(date_vector)," | ",round(((i-1)*length(date_vector)+j) / (length(states_list)*length(date_vector)) * 100,2), '% completed'))
    # Sys.sleep(0.5)
    #if ((i-1)*length(date_vector)+j == length(states_list)*length(date_vector)) cat(': Done')
    #else cat('\014')
    
    setTxtProgressBar(pb,(i-1)*length(date_vector)+j)
    # below is a less useful progress bar. actually prints every time. 
    # print(paste((i-1)*length(date_vector)+j," out of ",length(states_list)*length(date_vector)))
  }
} 

Sys.time() - TIME

# 1.D | Write log file
write.csv(log,paste(out_dir,'NEMWEB_log_',format(Sys.time(),format="%Y%m%d_%H%M%S"),'.csv',sep=''))

# Finished Running part 1; files grabbed.
