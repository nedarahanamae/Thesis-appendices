## setting up
#source("https://bioconductor.org/biocLite.R") #installation
#biocLite("DECIPHER") #installation
#install.packages("BiocManager")
#BiocManager::install("DECIPHER")
library(DECIPHER) #start DECIPHER

setwd("E:/0_Master_Thesis/R_test/Final_R/28S_8Provinces/4bp") # setting directory

## loading the 1st region as fasta from directory in Datenbank
print("load East Central Australian Shelf")
Seqs2DB(file.choose("E:/0_Master_Thesis/R_test/Final_R/28S_8Provinces/4bp/East Central Australian Shelf.fasta"),"FASTA","DB.TEMP","East Central Australian Shelf") #File, filetype, name of database, identifier of the Taxonpartition 
BrowseDB("DB.TEMP") # display in Webbrowser

## loading the 2nd region as fasta from directory in Datenbank
print("load Eastern Coral Triangle")
Seqs2DB(file.choose("E:/0_Master_Thesis/R_test/Final_R/28S_8Provinces/4bp/Eastern Coral Triangle.fasta"),"FASTA","DB.TEMP","Eastern Coral Triangle") #File, filetype, name of database, identifier of the Taxonpartition 
BrowseDB("DB.TEMP") # display in Webbrowser

## loading the 3rd fasta region as from directory in Datenbank
#print("load Lord Howe and Norfolk Islands")
#Seqs2DB(file.choose("E:/0_Master_Thesis/R_test/Final_R/28S_8Provinces/4bp/Lord Howe and Norfolk Islands.fasta"),"FASTA","DB.TEMP","Lord Howe and Norfolk Islands") #File, filetype, name of database, identifier of the Taxonpartition 
#BrowseDB("DB.TEMP") # display in Webbrowser

## loading the 4th fasta region as from directory in Datenbank
print("load Northeast Australian Shelf")
Seqs2DB(file.choose("E:/0_Master_Thesis/R_test/Final_R/28S_8Provinces/4bp/Northeast Australian Shelf.fasta"),"FASTA","DB.TEMP","Northeast Australian Shelf") #File, filetype, name of database, identifier of the Taxonpartition 
BrowseDB("DB.TEMP") # display in Webbrowser

## loading the 5th fasta region as from directory in Datenbank
print("load Northwest Australian Shelf")
Seqs2DB(file.choose("E:/0_Master_Thesis/R_test/Final_R/28S_8Provinces/4bp/Northwest Australian Shelf.fasta"),"FASTA","DB.TEMP","Northwest Australian Shelf") #File, filetype, name of database, identifier of the Taxonpartition 
BrowseDB("DB.TEMP") # display in Webbrowser

## loading the 6th fasta region as from directory in Datenbank
print("load Sahul Shelf")
Seqs2DB(file.choose("E:/0_Master_Thesis/R_test/Final_R/28S_8Provinces/4bp/Sahul Shelf.fasta"),"FASTA","DB.TEMP","Sahul Shelf") #File, filetype, name of database, identifier of the Taxonpartition 
BrowseDB("DB.TEMP") # display in Webbrowser

## loading the 7th fasta region as from directory in Datenbank
print("load Southeast Australian Shelf")
Seqs2DB(file.choose("E:/0_Master_Thesis/R_test/Final_R/28S_8Provinces/4bp/Southeast Australian Shelf.fasta"),"FASTA","DB.TEMP","Southeast Australian Shelf") #File, filetype, name of database, identifier of the Taxonpartition 
BrowseDB("DB.TEMP") # display in Webbrowser

## loading the 8th fasta region as from directory in Datenbank
#print("load Southwest Australian Shelf")
#Seqs2DB(file.choose("E:/0_Master_Thesis/R_test/Final_R/28S_8Provinces/4bp/Southwest Australian Shelf.fasta"),"FASTA","DB.TEMP","Southwest Australian Shelf") #File, filetype, name of database, identifier of the Taxonpartition 
#BrowseDB("DB.TEMP") # display in Webbrowser

## loading the 9th fasta region as from directory in Datenbank
print("load Tropical Southwestern Pacific")
Seqs2DB(file.choose("E:/0_Master_Thesis/R_test/Final_R/28S_8Provinces/4bp/Tropical Southwestern Pacific.fasta"),"FASTA","DB.TEMP","Tropical Southwestern Pacific") #File, filetype, name of database, identifier of the Taxonpartition 
BrowseDB("DB.TEMP") # display in Webbrowser

## loading the 10th fasta region as from directory in Datenbank
#print("load West Central Australian Shelf")
#Seqs2DB(file.choose("E:/0_Master_Thesis/R_test/Final_R/28S_8Provinces/4bp/West Central Australian Shelf.fasta"),"FASTA","DB.TEMP","West Central Australian Shelf") #File, filetype, name of database, identifier of the Taxonpartition 
#BrowseDB("DB.TEMP") # display in Webbrowser

## loading the 11th fasta region as from directory in Datenbank
print("load Western Coral Triangle")
Seqs2DB(file.choose("E:/0_Master_Thesis/R_test/Final_R/28S_8Provinces/4bp/Western Coral Triangle.fasta"),"FASTA","DB.TEMP","Western Coral Triangle") #File, filetype, name of database, identifier of the Taxonpartition 
BrowseDB("DB.TEMP") # display in Webbrowser


## Calculation of sequence length (bases) and entry in DB
Seqlengths <- IdLengths("DB.TEMP")
Add2DB(Seqlengths,"DB.TEMP")
BrowseDB("DB.TEMP") # display in Webbrowser


print("continue with 03_IPD_2_Alignment_4bp")
#### continue with 03_IPD_2_Alignment_4bp

