## Getting ingest data from AWS S3 in R ##


#1) downloading required packages: aws.s3, RAmazonS3, rjson and RJSONIO 

install.packages("devtools")
library(devtools)
install_github("duncantl/RAmazonS3")
library(RAmazonS3) 
install.packages("aws.s3", repos = c("cloudyr" = "http://cloudyr.github.io/drat")) # both of these packages are used to retrieve data from S3 buckets
library("aws.s3")
install.packages("rjson") #package used to read JSON arrays in R
library(rjson)
install.packages("RJSONIO")
library(RJSONIO)

#2) listing objects in the bucket 

get_bucket("safecastdata-us-west-2", prefix="ingest/prd/s3raw/", region="us-west-2") #shows a list of objects within the bucket

#3) getting object, e.g. from 2017-10-13/23/22 

object_exists("s3://safecastdata-us-west-2/ingest/prd/s3raw/2017-10-13/23/22", region="us-west-2") #checking if the object exists: TRUE
##need to specify the region (us-west-2) - default region is us-west-1, if not specified R might try to use us-west-1 endpoints to hit a us-west-2 bucket 
solarc20171013_2322 <- get_object("s3://safecastdata-us-west-2/ingest/prd/s3raw/2017-10-13/23/22", region="us-west-2")
mode(solarc20171013_2322) #raw
solarc20171013_2322 #data first appear in ascii format

#if there is no content type infor, or if R automatically reads the object using "unknown" (ASCII) encoding:
library(stringr)
solarc20171013_2322 <- rawToChar(solarc20171013_2322) #convert from raw to vector
solarc20171013_2322 # data now appear as JSON lines

# reading the JSON format in R
solarc20171013_2322 <- fromJSON(solarc20171013_2322)



