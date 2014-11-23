THis is the codebook that will document all the transformations that I did to the data to product the clean_data.txt

1. The raw data itself comes from here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. A 
detailed account of the data can be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

2. The run_analysis.r script transforms the data in the following way:
   - import the train and test tables into the working directory
   - merge each of the train and test tables to create three joined tabeles
   - import the factors text file into the working directory
   - rename factors variables "index" and "name"
   - find the rows that contain information on either the mean or standard deiveation in the factors table, and create a vector 
   of thoses rows
   -subset the join.set table by the factors vector created in the last step
   - clean the variable and data names in the join.set table to make them constent and easy to read
   -import the activites_lables.txt file
   -remame activites varables "index" and "activity"
   -merge the activites table with the join.lables table
   -merge the join.lables, join.subject, and join.set tables to create the clean_data table
   -melt the clean_data table by the subject and activites variables
   -use dcast to create the tidy.data table containg the means of the reapective variables
   
