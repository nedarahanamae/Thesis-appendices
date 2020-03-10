#### OTU CLUSTERING


##Installation Bioconductor
#source("https://bioconductor.org/biocLite.R") #installation
#if (!requireNamespace("BiocManager", quietly = TRUE))
#  install.packages("BiocManager")
#BiocManager::install("muscle")

## Installation msa
#if (!requireNamespace("BiocManager", quietly=TRUE))
#  install.packages("BiocManager")
#BiocManager::install("msa")
library(xlsx)
library(msa) # start msa
library(ape) # start ape
library(DECIPHER) # start DECIPHER
setwd("E:/0_Master_Thesis/R_test/Final_R/Ecoregions/28S/1bp") # setting directory
print("!!!!!! adjust OTU cutoff for each marker !!!!!!!")

## Creation of matrix und cluster outputfile with Dendrogramm , cutoff can be adjusted
DistMatr_by_descrip<-DistanceMatrix(MSAAlignment_by_description_String, correction="none", verbose=FALSE) #with taxon name
Cluster_by_descrip<-IdClusters(DistMatr_by_descrip, method="UPGMA", cutoff=0.00263, showPlot=TRUE, myXStringSet=dna, verbose=TRUE) #will be displayed with taxon name for checking, but not later used as element
DistMatr_by_row<-DistanceMatrix(MSAAlignment_by_row_String, correction="none", verbose=FALSE)
Cluster_by_row <-IdClusters(DistMatr_by_row, method="UPGMA", cutoff=0.00263, myXStringSet=dna, verbose=TRUE) #will be displayed with row name for checking and later used as element


## writing cluster number to sequences in the database
Cluster_by_row.df <- as.data.frame(Cluster_by_row) #transformation to dataframe
Add2DB(Cluster_by_row.df,"DB.TEMP") #addition to database

## Extracting of description and cluster number from data base and rewriting into factors.
library(DBI)
library(RSQLite)
connection_to_DB = dbConnect(SQLite(), dbname="DB.TEMP") # makes DB connection
descriptions.query<- dbSendQuery(connection_to_DB, "SELECT description FROM Seqs") # makes query for description
descriptions.tbl <- dbFetch(descriptions.query, n= -1) # fetches description from database with query
print(paste("DB has completed?",(dbHasCompleted(descriptions.query)))) # asks if database query is finished, should be TRUE
identifiers.query<- dbSendQuery(connection_to_DB, "SELECT identifier FROM Seqs") # makes query for identifiers
identifiers.tbl <- dbFetch(identifiers.query, n= -1) # fetches identifiers from database with query
print(paste("DB has completed?",(dbHasCompleted(identifiers.query)))) # asks if database query is finished, should be TRUE
cluster.query<- dbSendQuery(connection_to_DB, "SELECT cluster FROM Seqs") # makes query for cluster
cluster.tbl <- dbFetch(cluster.query, n= -1) # fetches cluster from database with query
print(paste("DB has completed?",(dbHasCompleted(cluster.query)))) # asks if database query is finished, should be TRUE
dbDisconnect(connection_to_DB) #closes access to DB

## Rewriting Identifiers, description and cluster.tbl-columns in dataframe 
Rownames<-(descriptions.tbl$description) # defines rownames
Region=identifiers.tbl$identifier # transforms identifiers to regions
alldata.df<-as.data.frame(Region,row.names=Rownames) #makes dataframe of regions with taxonnames as rownames
OTU<-cluster.tbl$cluster # Transforms cluster numbers to vektor OTU
alldata.df$OTU<-as.factor(OTU) # adds cluster numbers to table as column OTU

write.xlsx(alldata.df, col.names=TRUE, "E:/0_Master_Thesis/R_test/Final_R/Ecoregions/28S/1bp/alldata.df.xlsx")


print("continue with  05_IPD_4_Analyses_28S_8Provinces_1bp_eco")
#### continue with  05_IPD_4_Analyses_28S_8Provinces_1bp_eco

