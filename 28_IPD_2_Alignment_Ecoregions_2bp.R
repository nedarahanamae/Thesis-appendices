#### ALIGNMENT WITH MSA
##Upgrade BiocManager to latest version in order to run "msa"
#if (!requireNamespace("BiocManager", quietly = TRUE))
#  install.packages("BiocManager")
#BiocManager::install(version = "3.10")


##Installation Bioconductor
#source("https://bioconductor.org/biocLite.R") #installation
#if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
#BiocManager::install("muscle")

## Installation msa
#if (!requireNamespace("BiocManager", quietly=TRUE))
#   install.packages("BiocManager")
#BiocManager::install("msa", dependencies=TRUE)

##
##source("https://bioconductor.org/biocLite.R")
#biocLite("msa")
#BiocManager::install("biocLite")
#install.packages("msa")
##

library(muscle)
library(msa) # start msa
library(ape) # start ape
library(DECIPHER) # start DECIPHER
setwd("E:/0_Master_Thesis/R_test/Final_R/Ecoregions/28S/2bp") # setting directory
print("!!!!!! adjust bases for each marker !!!!!!!")

## starting timer
start_time <- Sys.time()

##Creation of a first Alignment - taxa will be visualized by "description" therefore alignment can be checked.
ALL.seqs_by_descrip <- SearchDB("DB.TEMP",clause="bases>370",nameBy="description", removeGaps = "all") # creates a XStringSet from the database with the taxonnames. Sequences have minimal lengths as defined by clause.
MSAAlignment_by_description<-msa(ALL.seqs_by_descrip,method = "ClustalW", order = "aligned", verbose = TRUE) #Alignment
MSAAlignment_by_description_String<- as(MSAAlignment_by_description, "DNAStringSet") #Rewriting as Stringset for visualization with BrowseSeqs
BrowseSeqs(MSAAlignment_by_description_String,colors=c("#ffffff", "#32CD32", "#1E90FF", "black", "#EE3300")) # visualization

## Makes final, identical  alignment as above, but with rownames instead of taxonnames.
ALL.sequences_by_row <- SearchDB("DB.TEMP",clause="bases>370", removeGaps = "all") # creates a XStringSet from the database but with rownames. Sequences have minimal lengths as defined by clause.
MSAAlignment_by_row <- msa(ALL.sequences_by_row,method = "ClustalW", order = "aligned",verbose = TRUE) #Alignment
MSAAlignment_by_row_String <- as(MSAAlignment_by_row, "DNAStringSet") #Rewriting as Stringset for visualization with BrowseSeqs

## calculation time
end_time <- Sys.time()
print(end_time - start_time) #provides the time

print("continue with 04_IPD_3_OTUclustering_2bp_eco")
####  continue with 04_IPD_3_OTUclustering_2bp
