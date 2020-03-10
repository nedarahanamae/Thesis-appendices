## To covert to *.fasta files
#install.packages("BiocManager")
#BiocManager::install("Biostrings")
library(Biostrings)
#install.packages("seqinr")
library(seqinr)
library(xlsx)

setwd("E:/0_Master_Thesis/R_test/Final_R/Loop") # setting directory

Australian_samples<-read.csv("E:/0_Master_Thesis/R_test/Final_R/Loop/Australian_samples.csv", sep=",",  header = TRUE, quote = "")

print("Australian Provinces")
for (i in Australian_samples$PROVINCE){
  if (i == "" || i =="#N/A") {
    next
  }
  
  # first create a variable to store values
  names <- paste(i)
  

  # use the assign() function to assign  values to the variable
  value <- assign(names, subset(Australian_samples, Australian_samples$PROVINCE == names))
  
  # create a file name
  FileName <- paste(names,".xlsx", sep = ",")
  
  # write your variable to a file into the current directory
  write.xlsx(value, col.names=TRUE, FileName)
    
  write.fasta(as.list(value$Sequence), value$museum_code, file=sprintf("E:/0_Master_Thesis/R_test/Final_R/Loop/%s.fasta",gsub("/", "", names, fixed=TRUE)), open = "w", as.string = FALSE)  
  print(names)
  
  #oldname <- i
  #print(oldname)
  
}

