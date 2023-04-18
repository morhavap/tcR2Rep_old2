library(writexl)
library(readxl)
library(dplyr)
library(tidyverse)
#library(openxlsx)

# Author - Mor Hava Pereg
# date - 14/12/2022
 
args = commandArgs(trailingOnly=TRUE)

#Set Path and Arg
args = commandArgs(trailingOnly=TRUE)
# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  #exel names
  a="/mnt/project2/projects/Tcells/Batch1/fastq/AL11/AL11_S1_after_clonnig.xlsx"
  b="/mnt/project2/projects/Tcells/Batch1/fastq/AL11/AL11_S1_10_biggest_clone_summery.xlsx"
  #stop("At least one argument must be supplied (input file).tsv", call.=FALSE)
} else if (length(args)>0) {
  # default output file
  #exel names
  a= args[1]#after_clonnig.xlsx"
  b= args[2]#10_biggest_clone_summery.xlsx"
  table_name <- args[3] 
  path = args[4]
  setwd(path)
}

#list of excel df
my_data <- list()
#list of excel sheet
name_sheet<-list()

#create sheets:

#1. all_seq_sheet
df1 <- read_excel(a,sheet = 1)
#for a
sub_data_a<- subset(df1,locus=='TRA')
seq_a_with_dup <-sum(sub_data_a$duplicate_seq)
seq_a_without_dup<-nrow(sub_data_a)
sub_data_a$clone_percent_without_dup <- (sub_data_a$clone_size_without_duplicate_seq/seq_a_without_dup)*100
sub_data_a$clone_percent_with_dup <- (sub_data_a$clone_size_with_duplicate_seq/seq_a_with_dup)*100
#for b
sub_data_b<- subset(df1,locus=='TRB')
seq_b_with_dup <-sum(sub_data_b$duplicate_seq)
seq_b_without_dup<-nrow(sub_data_b)
sub_data_b$clone_percent_without_dup <- (sub_data_b$clone_size_without_duplicate_seq/seq_b_without_dup)*100
sub_data_b$clone_percent_with_dup <- (sub_data_b$clone_size_with_duplicate_seq/seq_b_with_dup)*100
#merge 
df1<- rbind(sub_data_a,sub_data_b)
#add sheet to list of exel file 
my_data[[1]] <- df1
name_sheet[[1]]<- "all_seq" 

#2. 10_TRA_clone_sheet
df2a <- read_excel(b,sheet = 1)
df2a$clone_percent_without_dup <- (df2a$clone_size_without_duplicate_seq/seq_a_without_dup)*100
df2a$clone_percent_with_dup <- (df2a$clone_size_with_duplicate_seq/seq_a_with_dup)*100
my_data[[2]] <- df2a
name_sheet[[2]]<- "10_TRA_clone" 

#3. 10_TRA_summery_sheet
df2a <- read_excel(b,sheet = 2)
df2a$clone_percent_without_dup <- (df2a$clone_size_without_duplicate_seq/seq_a_without_dup)*100
df2a$clone_percent_with_dup <- (df2a$clone_size_with_duplicate_seq/seq_a_with_dup)*100
my_data[[3]] <- df2a
name_sheet[[3]]<- "10_TRA_summery"

#4. 10_TRB_clone_sheet
df2b <- read_excel(b,sheet = 3)
df2b$clone_percent_without_dup <- (df2b$clone_size_without_duplicate_seq/seq_b_without_dup)*100
df2b$clone_percent_with_dup <- (df2b$clone_size_with_duplicate_seq/seq_b_with_dup)*100
my_data[[4]] <- df2b
name_sheet[[4]]<- "10_TRB_clone" 

#5. 10_TRB_summery_sheet
df2b <- read_excel(b,sheet = 4)
df2b$clone_percent_without_dup <- (df2b$clone_size_without_duplicate_seq/seq_b_without_dup)*100
df2b$clone_percent_with_dup <- (df2b$clone_size_with_duplicate_seq/seq_b_with_dup)*100
my_data[[5]] <- df2b
name_sheet[[5]]<- "10_TRB_summery" 

outname <- paste0(table_name,"_clone_summery_Table.xlsx")
write.xlsx(my_data,outname,sheetName=name_sheet )

#create graph:
#for a
