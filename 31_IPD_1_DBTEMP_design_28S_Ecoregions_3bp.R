## setting up
#source("https://bioconductor.org/biocLite.R") #installation
#biocLite("DECIPHER") #installation
#install.packages("BiocManager")
#BiocManager::install("DECIPHER")
library(DECIPHER) #start DECIPHER

setwd("E:/0_Master_Thesis/R_test/Final_R/Ecoregions/28S/3bp") # setting directory

## loading the 1st region as fasta from directory in Datenbank
print("load Arnhem Coast to Gulf of Carpenteria")
Seqs2DB(file.choose("E:/0_Master_Thesis/R_test/Final_R/Ecoregions/28S/3bp/Arnhem Coast to Gulf of Carpenteria.fasta"),"FASTA","DB.TEMP","Arnhem Coast to Gulf of Carpenteria") #File, filetype, name of database, identifier of the Taxonpartition 
BrowseDB("DB.TEMP") # display in Webbrowser

## loading the 2nd region as fasta from directory in Datenbank
print("load Bassian")
Seqs2DB(file.choose("E:/0_Master_Thesis/R_test/Final_R/Ecoregions/28S/3bp/Bassian.fasta"),"FASTA","DB.TEMP","Bassian") #File, filetype, name of database, identifier of the Taxonpartition 
BrowseDB("DB.TEMP") # display in Webbrowser

## loading the 3rd fasta region as from directory in Datenbank
print("load Bonaparte Coast")
Seqs2DB(file.choose("E:/0_Master_Thesis/R_test/Final_R/Ecoregions/28S/3bp/Bonaparte Coast.fasta"),"FASTA","DB.TEMP","Bonaparte Coast") #File, filetype, name of database, identifier of the Taxonpartition 
BrowseDB("DB.TEMP") # display in Webbrowser

## loading the 4th fasta region as from directory in Datenbank
print("load Cape Howe")
Seqs2DB(file.choose("E:/0_Master_Thesis/R_test/Final_R/Ecoregions/28S/3bp/Cape Howe.fasta"),"FASTA","DB.TEMP","Cape Howe") #File, filetype, name of database, identifier of the Taxonpartition 
BrowseDB("DB.TEMP") # display in Webbrowser

## loading the 5th fasta region as from directory in Datenbank
print("load Coral Sea")
Seqs2DB(file.choose("E:/0_Master_Thesis/R_test/Final_R/Ecoregions/28S/3bp/Coral Sea.fasta"),"FASTA","DB.TEMP","Coral Sea") #File, filetype, name of database, identifier of the Taxonpartition 
BrowseDB("DB.TEMP") # display in Webbrowser

## loading the 6th fasta region as from directory in Datenbank
print("load Exmouth to Broome")
Seqs2DB(file.choose("E:/0_Master_Thesis/R_test/Final_R/Ecoregions/28S/3bp/Exmouth to Broome.fasta"),"FASTA","DB.TEMP","Exmouth to Broome") #File, filetype, name of database, identifier of the Taxonpartition 
BrowseDB("DB.TEMP") # display in Webbrowser

## loading the 7th fasta region as from directory in Datenbank
print("load Manning-Hawkesbury")
Seqs2DB(file.choose("E:/0_Master_Thesis/R_test/Final_R/Ecoregions/28S/3bp/Manning-Hawkesbury.fasta"),"FASTA","DB.TEMP","Manning-Hawkesbury") #File, filetype, name of database, identifier of the Taxonpartition 
BrowseDB("DB.TEMP") # display in Webbrowser

## loading the 8th fasta region as from directory in Datenbank
print("load New Caledonia")
Seqs2DB(file.choose("E:/0_Master_Thesis/R_test/Final_R/Ecoregions/28S/3bp/New Caledonia.fasta"),"FASTA","DB.TEMP","New Caledonia") #File, filetype, name of database, identifier of the Taxonpartition 
BrowseDB("DB.TEMP") # display in Webbrowser

## loading the 9th fasta region as from directory in Datenbank
print("load Solomon Archipelago")
Seqs2DB(file.choose("E:/0_Master_Thesis/R_test/Final_R/Ecoregions/28S/3bp/Solomon Archipelago.fasta"),"FASTA","DB.TEMP","Solomon Archipelago") #File, filetype, name of database, identifier of the Taxonpartition 
BrowseDB("DB.TEMP") # display in Webbrowser

## loading the 10th fasta region as from directory in Datenbank
print("load Southeast Papua New Guinea")
Seqs2DB(file.choose("E:/0_Master_Thesis/R_test/Final_R/Ecoregions/28S/3bp/Southeast Papua New Guinea.fasta"),"FASTA","DB.TEMP","Southeast Papua New Guinea") #File, filetype, name of database, identifier of the Taxonpartition 
BrowseDB("DB.TEMP") # display in Webbrowser

## loading the 11th fasta region as from directory in Datenbank
print("load Torres Strait Northern Great Barrier Reef")
Seqs2DB(file.choose("E:/0_Master_Thesis/R_test/Final_R/Ecoregions/28S/3bp/Torres Strait Northern Great Barrier Reef.fasta"),"FASTA","DB.TEMP","Torres Strait Northern Great Barrier Reef") #File, filetype, name of database, identifier of the Taxonpartition 
BrowseDB("DB.TEMP") # display in Webbrowser

## loading the 12th fasta region as from directory in Datenbank
print("load Tweed-Moreton")
Seqs2DB(file.choose("E:/0_Master_Thesis/R_test/Final_R/Ecoregions/28S/3bp/Tweed-Moreton.fasta"),"FASTA","DB.TEMP","Tweed-Moreton") #File, filetype, name of database, identifier of the Taxonpartition 
BrowseDB("DB.TEMP") # display in Webbrowser

## loading the 13th fasta region as from directory in Datenbank
print("load Western Bassian")
Seqs2DB(file.choose("E:/0_Master_Thesis/R_test/Final_R/Ecoregions/28S/3bp/Western Bassian.fasta"),"FASTA","DB.TEMP","Western Bassian") #File, filetype, name of database, identifier of the Taxonpartition 
BrowseDB("DB.TEMP") # display in Webbrowser


## Calculation of sequence length (bases) and entry in DB
Seqlengths <- IdLengths("DB.TEMP")
Add2DB(Seqlengths,"DB.TEMP")
BrowseDB("DB.TEMP") # display in Webbrowser


print("continue with 03_IPD_2_Alignment_3bp_eco")
#### continue with 03_IPD_2_Alignment_3bp

