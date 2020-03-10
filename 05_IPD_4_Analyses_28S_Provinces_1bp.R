## Biodiversity Analysis

## Initializing

library(RColorBrewer)
library(picante)                          # loads the Biodiversity library
setwd("E:/0_Master_Thesis/R_test/Final_R/28S_8Provinces/1bp") # setting directory

## Check the dataset
class(alldata.df) # checks for resonable names of columns and rows. Should become data.frame
rownames(alldata.df) # checks rownames
head(colnames(alldata.df)) # checks columnnames


## Determine dataset parameters before and after clustering
print(paste("Total number of sequences is",dim(alldata.df)[1])) # checks dimensions of the data object, imported before clustering
number.of.all.genotypes <- length(levels(alldata.df$OTU)) # Find number of genotypes, total
print(paste("Number of all genotypes is",number.of.all.genotypes))
print(paste("Total number of sequences included in the cluster analysis is",dim(Cluster_by_row.df)[1])) # checks length in cluster analysis


##Extraction of the subsets to be compared, unused levels are deleted with drop = TRUE
EastCentralAustralianShelf.only.df <- subset(alldata.df, alldata.df$Region == "East Central Australian Shelf")
EasternCoralTriangle.only.df <- subset(alldata.df, alldata.df$Region == "Eastern Coral Triangle")
##LordHoweandNorfolkIslands.only.df <- subset(alldata.df, alldata.df$Region == "Lord Howe and Norfolk Islands")
NortheastAustralianShelf.only.df <- subset(alldata.df, alldata.df$Region == "Northeast Australian Shelf")
NorthwestAustralianShelf.only.df <- subset(alldata.df, alldata.df$Region == "Northwest Australian Shelf")
SahulShelf.only.df <- subset(alldata.df, alldata.df$Region == "Sahul Shelf")
SoutheastAustralianShelf.only.df <- subset(alldata.df, alldata.df$Region == "Southeast Australian Shelf")
#SouthernNewZealand.only.df <- subset(alldata.df, alldata.df$Region == "Southern New Zealand")
#SouthwestAustralianShelf.only.df <- subset(alldata.df, alldata.df$Region == "Southwest Australian Shelf")
TropicalSouthwesternPacific.only.df <- subset(alldata.df, alldata.df$Region == "Tropical Southwestern Pacific")
#WestCentralAustralianShelf.only.df <- subset(alldata.df, alldata.df$Region == "West Central Australian Shelf")
WesternCoralTriangle.only.df <- subset(alldata.df, alldata.df$Region == "Western Coral Triangle")


## Number of regions and specimens per region
NUMBER.SP.ALL.REGS <- c(dim(EastCentralAustralianShelf.only.df)[1],
                        dim(EasternCoralTriangle.only.df)[1],
                        #dim(LordHoweandNorfolkIslands.only.df)[1],
                        dim(NortheastAustralianShelf.only.df)[1],
                        dim(NorthwestAustralianShelf.only.df)[1],
                        dim(SahulShelf.only.df)[1],
                        dim(SoutheastAustralianShelf.only.df)[1],
                        #dim(SouthernNewZealand.only.df)[1],
                        #dim(SouthwestAustralianShelf.only.df)[1],
                        dim(TropicalSouthwesternPacific.only.df)[1],
                        #dim(WestCentralAustralianShelf.only.df)[1],
                        dim(WesternCoralTriangle.only.df)[1]
                        ) #for later calculations if necessary

NUMBER.REGS<- length(NUMBER.SP.ALL.REGS)
print(paste("There are ",NUMBER.REGS,"regions")) # output for region number
print(paste("Numbers of specimens are         ",
            dim(EastCentralAustralianShelf.only.df)[1],"(EastCentral Australian Shelf)  ",
            dim(EasternCoralTriangle.only.df)[1],"(Eastern Coral Triangle)  ",
            #dim(LordHoweandNorfolkIslands.only.df)[1],"(Lord Howe and Norfolk Islands)  ",
            dim(NortheastAustralianShelf.only.df)[1],"(Northeast Australian Shelf)  ",
            dim(NorthwestAustralianShelf.only.df)[1],"(Northwest Australian Shelf)  ",
            dim(SahulShelf.only.df)[1],"(Sahul Shelf)  ",
            dim(SoutheastAustralianShelf.only.df)[1],"(Southeast Australian Shelf)  ",
            #dim(SouthernNewZealand.only.df)[1],"(Southern New Zealand)  ",
            #dim(SouthwestAustralianShelf.only.df)[1],"(Southwest Australian Shelf)  ",
            dim(TropicalSouthwesternPacific.only.df)[1],"(Tropical Southwestern Pacific)  ",
            #dim(WestCentralAustralianShelf.only.df)[1],"(West Central Australian Shelf)  ",
            dim(WesternCoralTriangle.only.df)[1],"(Western Coral Triangle)  "
            )) # output

## Creation of two factors that only the OTUs of the respective regions have
OTUS.EastCentralAustralianShelf <- EastCentralAustralianShelf.only.df$OTU[drop=TRUE]
OTUS.EasternCoralTriangle <- EasternCoralTriangle.only.df$OTU[drop=TRUE]
#OTUS.LordHoweandNorfolkIslands <- LordHoweandNorfolkIslands.only.df$OTU[drop=TRUE]
OTUS.NortheastAustralianShelf <- NortheastAustralianShelf.only.df$OTU[drop=TRUE]
OTUS.NorthwestAustralianShelf <- NorthwestAustralianShelf.only.df$OTU[drop=TRUE]
OTUS.SahulShelf <- SahulShelf.only.df$OTU[drop=TRUE]
OTUS.SoutheastAustralianShelf <- SoutheastAustralianShelf.only.df$OTU[drop=TRUE]
#OTUS.SouthernNewZealand <- SouthernNewZealand.only.df$OTU[drop=TRUE]
#OTUS.SouthwestAustralianShelf <- SouthwestAustralianShelf.only.df$OTU[drop=TRUE]
OTUS.TropicalSouthwesternPacific <- TropicalSouthwesternPacific.only.df$OTU[drop=TRUE]
#OTUS.WestCentralAustralianShelf <- WestCentralAustralianShelf.only.df$OTU[drop=TRUE]
OTUS.WesternCoralTriangle <- WesternCoralTriangle.only.df$OTU[drop=TRUE]



## Analysis of how many sequences have not been clustered
EastCentralAustralianShelf.only.no.NA<-length(which(is.na(OTUS.EastCentralAustralianShelf)==FALSE))
EasternCoralTriangle.only.no.NA<-length(which(is.na(OTUS.EasternCoralTriangle)==FALSE))
#LordHoweandNorfolkIslands.only.no.NA<-length(which(is.na(OTUS.LordHoweandNorfolkIslands)==FALSE))
NortheastAustralianShelf.only.no.NA<-length(which(is.na(OTUS.NortheastAustralianShelf)==FALSE))
NorthwestAustralianShelf.only.no.NA<-length(which(is.na(OTUS.NorthwestAustralianShelf)==FALSE))
SahulShelf.only.no.NA<-length(which(is.na(OTUS.SahulShelf)==FALSE))
SoutheastAustralianShelf.only.no.NA<-length(which(is.na(OTUS.SoutheastAustralianShelf)==FALSE))
#SouthernNewZealand.only.no.NA<-length(which(is.na(OTUS.SouthernNewZealand)==FALSE))
#SouthwestAustralianShelf.only.no.NA<-length(which(is.na(OTUS.SouthwestAustralianShelf)==FALSE))
TropicalSouthwesternPacific.only.no.NA<-length(which(is.na(OTUS.TropicalSouthwesternPacific)==FALSE))
#WestCentralAustralianShelf.only.no.NA<-length(which(is.na(OTUS.WestCentralAustralianShelf)==FALSE))
WesternCoralTriangle.only.no.NA<-length(which(is.na(OTUS.WesternCoralTriangle)==FALSE))


print(paste("Numbers of clustered specimens are ",
            EastCentralAustralianShelf.only.no.NA,"(EastCentral Australian Shelf)  ",
            EasternCoralTriangle.only.no.NA,"(Eastern Coral Triangle)  ",
            #LordHoweandNorfolkIslands.only.no.NA,"(Lord Howe and Norfolk Islands)  ",
            NortheastAustralianShelf.only.no.NA,"(Northeast Australian Shelf)  ",
            NorthwestAustralianShelf.only.no.NA,"(Northwest Australian Shelf)  ",
            SahulShelf.only.no.NA,"(Sahul Shelf)  ",
            SoutheastAustralianShelf.only.no.NA,"(Southeast Australian Shelf)  ",
            #SouthernNewZealand.only.no.NA,"(Southern New Zealand)  ",
            #SouthwestAustralianShelf.only.no.NA,"(Southwest Australian Shelf)  ",
            TropicalSouthwesternPacific.only.no.NA,"(Tropical Southwestern Pacific)  ",
            #WestCentralAustralianShelf.only.no.NA,"(West Central Australian Shelf)  ",
            WesternCoralTriangle.only.no.NA,"(Western Coral Triangle)  "
            )) # output



## Creation of a level list of the regions
LEVELS.OTUS.EastCentralAustralianShelf <- levels(OTUS.EastCentralAustralianShelf)
LEVELS.OTUS.EasternCoralTriangle <- levels(OTUS.EasternCoralTriangle)
#LEVELS.OTUS.LordHoweandNorfolkIslands <- levels(OTUS.LordHoweandNorfolkIslands)
LEVELS.OTUS.NortheastAustralianShelf <- levels(OTUS.NortheastAustralianShelf)
LEVELS.OTUS.NorthwestAustralianShelf <- levels(OTUS.NorthwestAustralianShelf)
LEVELS.OTUS.SahulShelf <- levels(OTUS.SahulShelf)
LEVELS.OTUS.SoutheastAustralianShelf <- levels(OTUS.SoutheastAustralianShelf)
#LEVELS.OTUS.SouthernNewZealand <- levels(OTUS.SouthernNewZealand)
#LEVELS.OTUS.SouthwestAustralianShelf <- levels(OTUS.SouthwestAustralianShelf)
LEVELS.OTUS.TropicalSouthwesternPacific <- levels(OTUS.TropicalSouthwesternPacific)
#LEVELS.OTUS.WestCentralAustralianShelf <- levels(OTUS.WestCentralAustralianShelf)
LEVELS.OTUS.WesternCoralTriangle <- levels(OTUS.WesternCoralTriangle)


print(paste("Numbers of OTUs are                 ",
            length(LEVELS.OTUS.EastCentralAustralianShelf),"(EastCentral Australian Shelf)  ",
            length(LEVELS.OTUS.EasternCoralTriangle),"(Eastern Coral Triangle)  ",
            #length(LEVELS.OTUS.LordHoweandNorfolkIslands),"(Lord Howe and Norfolk Islands)  ",
            length(LEVELS.OTUS.NortheastAustralianShelf),"(Northeast Australian Shelf)  ",
            length(LEVELS.OTUS.NorthwestAustralianShelf),"(Northwest Australian Shelf)  ",
            length(LEVELS.OTUS.SahulShelf),"(Sahul Shelf)  ",
            length(LEVELS.OTUS.SoutheastAustralianShelf),"(Southeast Australian Shelf)  ",
            #length(LEVELS.OTUS.SouthernNewZealand),"(Southern New Zealand)  ",
            #length(LEVELS.OTUS.SouthwestAustralianShelf),"(Southwest Australian Shelf)  ",
            length(LEVELS.OTUS.TropicalSouthwesternPacific),"(Tropical Southwestern Pacific)  ",
            #length(LEVELS.OTUS.WestCentralAustralianShelf),"(West Central Australian Shelf)  ",
            length(LEVELS.OTUS.WesternCoralTriangle),"(Western Coral Triangle)  "
            ))


## Creation of a table for the regions with only genotypes and number.
EasternCoralTriangle.Specimens.pro.OTU <-table(OTUS.EasternCoralTriangle)
EasternCoralTriangle.Specimens.pro.OTU.mat <- matrix(EasternCoralTriangle.Specimens.pro.OTU)
rownames(EasternCoralTriangle.Specimens.pro.OTU.mat) <- LEVELS.OTUS.EasternCoralTriangle
colnames(EasternCoralTriangle.Specimens.pro.OTU.mat) <- "Number"

EastCentralAustralianShelf.Specimens.pro.OTU <-table(OTUS.EastCentralAustralianShelf)
EastCentralAustralianShelf.Specimens.pro.OTU.mat <- matrix(EastCentralAustralianShelf.Specimens.pro.OTU)
rownames(EastCentralAustralianShelf.Specimens.pro.OTU.mat) <- LEVELS.OTUS.EastCentralAustralianShelf
colnames(EastCentralAustralianShelf.Specimens.pro.OTU.mat) <- "Number"

#LordHoweandNorfolkIslands.Specimens.pro.OTU <-table(OTUS.LordHoweandNorfolkIslands)
#LordHoweandNorfolkIslands.Specimens.pro.OTU.mat <- matrix(LordHoweandNorfolkIslands.Specimens.pro.OTU)
#rownames(LordHoweandNorfolkIslands.Specimens.pro.OTU.mat) <- LEVELS.OTUS.LordHoweandNorfolkIslands
#colnames(LordHoweandNorfolkIslands.Specimens.pro.OTU.mat) <- "Number"

NortheastAustralianShelf.Specimens.pro.OTU <-table(OTUS.NortheastAustralianShelf)
NortheastAustralianShelf.Specimens.pro.OTU.mat <- matrix(NortheastAustralianShelf.Specimens.pro.OTU)
rownames(NortheastAustralianShelf.Specimens.pro.OTU.mat) <- LEVELS.OTUS.NortheastAustralianShelf
colnames(NortheastAustralianShelf.Specimens.pro.OTU.mat) <- "Number"

NorthwestAustralianShelf.Specimens.pro.OTU <-table(OTUS.NorthwestAustralianShelf)
NorthwestAustralianShelf.Specimens.pro.OTU.mat <- matrix(NorthwestAustralianShelf.Specimens.pro.OTU)
rownames(NorthwestAustralianShelf.Specimens.pro.OTU.mat) <- LEVELS.OTUS.NorthwestAustralianShelf
colnames(NorthwestAustralianShelf.Specimens.pro.OTU.mat) <- "Number"

SahulShelf.Specimens.pro.OTU <-table(OTUS.SahulShelf)
SahulShelf.Specimens.pro.OTU.mat <- matrix(SahulShelf.Specimens.pro.OTU)
rownames(SahulShelf.Specimens.pro.OTU.mat) <- LEVELS.OTUS.SahulShelf
colnames(SahulShelf.Specimens.pro.OTU.mat) <- "Number"

SoutheastAustralianShelf.Specimens.pro.OTU <-table(OTUS.SoutheastAustralianShelf)
SoutheastAustralianShelf.Specimens.pro.OTU.mat <- matrix(SoutheastAustralianShelf.Specimens.pro.OTU)
rownames(SoutheastAustralianShelf.Specimens.pro.OTU.mat) <- LEVELS.OTUS.SoutheastAustralianShelf
colnames(SoutheastAustralianShelf.Specimens.pro.OTU.mat) <- "Number"

#SouthernNewZealand.Specimens.pro.OTU <-table(OTUS.SouthernNewZealand)
#SouthernNewZealand.Specimens.pro.OTU.mat <- matrix(SouthernNewZealand.Specimens.pro.OTU)
#rownames(SouthernNewZealand.Specimens.pro.OTU.mat) <- LEVELS.OTUS.SouthernNewZealand
#colnames(SouthernNewZealand.Specimens.pro.OTU.mat) <- "Number"

#SouthwestAustralianShelf.Specimens.pro.OTU <-table(OTUS.SouthwestAustralianShelf)
#SouthwestAustralianShelf.Specimens.pro.OTU.mat <- matrix(SouthwestAustralianShelf.Specimens.pro.OTU)
#rownames(SouthwestAustralianShelf.Specimens.pro.OTU.mat) <- LEVELS.OTUS.SouthwestAustralianShelf
#colnames(SouthwestAustralianShelf.Specimens.pro.OTU.mat) <- "Number"

TropicalSouthwesternPacific.Specimens.pro.OTU <-table(OTUS.TropicalSouthwesternPacific)
TropicalSouthwesternPacific.Specimens.pro.OTU.mat <- matrix(TropicalSouthwesternPacific.Specimens.pro.OTU)
rownames(TropicalSouthwesternPacific.Specimens.pro.OTU.mat) <- LEVELS.OTUS.TropicalSouthwesternPacific
colnames(TropicalSouthwesternPacific.Specimens.pro.OTU.mat) <- "Number"

#WestCentralAustralianShelf.Specimens.pro.OTU <-table(OTUS.WestCentralAustralianShelf)
#WestCentralAustralianShelf.Specimens.pro.OTU.mat <- matrix(WestCentralAustralianShelf.Specimens.pro.OTU)
#rownames(WestCentralAustralianShelf.Specimens.pro.OTU.mat) <- LEVELS.OTUS.WestCentralAustralianShelf
#colnames(WestCentralAustralianShelf.Specimens.pro.OTU.mat) <- "Number"

WesternCoralTriangle.Specimens.pro.OTU <-table(OTUS.WesternCoralTriangle)
WesternCoralTriangle.Specimens.pro.OTU.mat <- matrix(WesternCoralTriangle.Specimens.pro.OTU)
rownames(WesternCoralTriangle.Specimens.pro.OTU.mat) <- LEVELS.OTUS.WesternCoralTriangle
colnames(WesternCoralTriangle.Specimens.pro.OTU.mat) <- "Number"


## Creation of a table "REGS.OTU.FRQ" with regions on Y and OTUS in X
EasternCoralTriangle.OTU.FRQ <- table(EasternCoralTriangle.only.df$OTU[drop=FALSE]) # First region in table read
EasternCoralTriangle.OTU.FRQ.mat <- matrix(EasternCoralTriangle.OTU.FRQ,nrow = 1,ncol=(length(EasternCoralTriangle.OTU.FRQ))) #Shape the table as a matrix
colnames(EasternCoralTriangle.OTU.FRQ.mat) <- levels(EasternCoralTriangle.only.df$OTU) # Adapt columnames to OTU names
rownames(EasternCoralTriangle.OTU.FRQ.mat) <- "EasternCoralTriangle.OTU.FRQ" # Customize row names

EastCentralAustralianShelf.OTU.FRQ <- table(EastCentralAustralianShelf.only.df$OTU[drop=FALSE]) # Read the second region as a table
REGS.OTU.FRQ.mat <- rbind(EasternCoralTriangle.OTU.FRQ.mat, EastCentralAustralianShelf.OTU.FRQ) # Combine the second region in the table of the first to "REGS.OTU.FRQ"

NortheastAustralianShelf.OTU.FRQ <- table(NortheastAustralianShelf.only.df$OTU[drop=FALSE]) # Read the following region as a table
REGS.OTU.FRQ.mat <- rbind(REGS.OTU.FRQ.mat, NortheastAustralianShelf.OTU.FRQ) # merge the following region in the table of the first to "REGS.OTU.FRQ"

#LordHoweandNorfolkIslands.OTU.FRQ <- table(LordHoweandNorfolkIslands.only.df$OTU[drop=FALSE]) # Read the following region as a table
#REGS.OTU.FRQ.mat <- rbind(REGS.OTU.FRQ.mat, LordHoweandNorfolkIslands.OTU.FRQ) # merge the following region in the table of the first to "REGS.OTU.FRQ"

NorthwestAustralianShelf.OTU.FRQ <- table(NorthwestAustralianShelf.only.df$OTU[drop=FALSE]) # Read the following region as a table
REGS.OTU.FRQ.mat <- rbind(REGS.OTU.FRQ.mat, NorthwestAustralianShelf.OTU.FRQ) # merge the following region in the table of the first to "REGS.OTU.FRQ"

SahulShelf.OTU.FRQ <- table(SahulShelf.only.df$OTU[drop=FALSE]) # Read the following region as a table
REGS.OTU.FRQ.mat <- rbind(REGS.OTU.FRQ.mat, SahulShelf.OTU.FRQ) # merge the following region in the table of the first to "REGS.OTU.FRQ"

SoutheastAustralianShelf.OTU.FRQ <- table(SoutheastAustralianShelf.only.df$OTU[drop=FALSE]) # Read the following region as a table
REGS.OTU.FRQ.mat <- rbind(REGS.OTU.FRQ.mat, SoutheastAustralianShelf.OTU.FRQ) # merge the following region in the table of the first to "REGS.OTU.FRQ"

#SouthernNewZealand.OTU.FRQ <- table(SouthernNewZealand.only.df$OTU[drop=FALSE]) # Read the following region as a table
#REGS.OTU.FRQ.mat <- rbind(REGS.OTU.FRQ.mat, SouthernNewZealand.OTU.FRQ) # merge the following region in the table of the first to "REGS.OTU.FRQ"

#SouthwestAustralianShelf.OTU.FRQ <- table(SouthwestAustralianShelf.only.df$OTU[drop=FALSE]) # Read the following region as a table
#REGS.OTU.FRQ.mat <- rbind(REGS.OTU.FRQ.mat, SouthwestAustralianShelf.OTU.FRQ) # merge the following region in the table of the first to "REGS.OTU.FRQ"

TropicalSouthwesternPacific.OTU.FRQ <- table(TropicalSouthwesternPacific.only.df$OTU[drop=FALSE]) # Read the following region as a table
REGS.OTU.FRQ.mat <- rbind(REGS.OTU.FRQ.mat, TropicalSouthwesternPacific.OTU.FRQ) # merge the following region in the table of the first to "REGS.OTU.FRQ"

#WestCentralAustralianShelf.OTU.FRQ <- table(WestCentralAustralianShelf.only.df$OTU[drop=FALSE]) # Read the following region as a table
#REGS.OTU.FRQ.mat <- rbind(REGS.OTU.FRQ.mat, WestCentralAustralianShelf.OTU.FRQ) # merge the following region in the table of the first to "REGS.OTU.FRQ"

WesternCoralTriangle.OTU.FRQ <- table(WesternCoralTriangle.only.df$OTU[drop=FALSE]) # Read the following region as a table
REGS.OTU.FRQ.mat <- rbind(REGS.OTU.FRQ.mat, WesternCoralTriangle.OTU.FRQ) # merge the following region in the table of the first to "REGS.OTU.FRQ"

REGS.OTU.FRQ.df <- as.data.frame(REGS.OTU.FRQ.mat) #macht ein data frame daraus (turns it into a data frame)

write.xlsx(REGS.OTU.FRQ.df, col.names=TRUE, "E:/0_Master_Thesis/R_test/Final_R/28S_8Provinces/1bp/REGS.OTU.FRQ.df_1bp.xlsx")

print(paste("Dataframe contains",length(rownames(REGS.OTU.FRQ.df)),"regions with",
            length(colnames(REGS.OTU.FRQ.df)),"OTUs")) #Overview of output for the entire matrix

#################################

### Extrapolation unshared OTUS per region

## Preparation of the data set
tREGS.OTU.FRQ.mat<-t(REGS.OTU.FRQ.mat) #transposes matrix with location in columns
tREGS.OTU.FRQ.mat[tREGS.OTU.FRQ.mat>0]<-1 #replaces all values greater than 0 with 1 and makes absence presence matrix
RowSum<-rowSums(tREGS.OTU.FRQ.mat) #creates a vector with the sums of the rows. Everything that is 1 here only occurs in one region
cbind(tREGS.OTU.FRQ.mat,RowSum) #attaches this factor to the matrix as another column
tREGS.OTU.FRQ.df<-as.data.frame(tREGS.OTU.FRQ.mat) # converts the MAtrix to df

## Calculation of the combinations and calculation of the percentage
OTUS.with.1.REG.only<-which(RowSum==1) #pulls out all OTUs that only occur in one location
OTUS.of.SoutheastAustralianShelf<-which(tREGS.OTU.FRQ.df$"SoutheastAustralianShelf.OTU.FRQ"==1) #pulls out all OTUs that only occur in the location
Number.OTUS.of.SoutheastAustralianShelf.only<-length(intersect(OTUS.with.1.REG.only,OTUS.of.SoutheastAustralianShelf)) #calculates the number of OTUs in the region that only occur once
ENDEMIC.OTUS.SoutheastAustralianShelf<-round(((Number.OTUS.of.SoutheastAustralianShelf.only/sum(tREGS.OTU.FRQ.df$"SoutheastAustralianShelf.OTU.FRQ"))*100), digits = 1) # calculates percentage and rounds to the first decimal place

OTUS.with.1.REG.only<-which(RowSum==1) #pulls out all OTUs that only occur in one location
OTUS.of.EastCentralAustralianShelf<-which(tREGS.OTU.FRQ.df$"EastCentralAustralianShelf.OTU.FRQ"==1) #pulls out all OTUs that only occur in the location
Number.OTUS.of.EastCentralAustralianShelf.only<-length(intersect(OTUS.with.1.REG.only,OTUS.of.EastCentralAustralianShelf)) #calculates the number of OTUs in the region that only occur once
ENDEMIC.OTUS.EastCentralAustralianShelf<-round(((Number.OTUS.of.EastCentralAustralianShelf.only/sum(tREGS.OTU.FRQ.df$"EastCentralAustralianShelf.OTU.FRQ"))*100), digits = 1) # calculates percentage and rounds to the first decimal place

#OTUS.with.1.REG.only<-which(RowSum==1) #pulls out all OTUs that only occur in one location
#OTUS.of.SouthernNewZealand<-which(tREGS.OTU.FRQ.df$"SouthernNewZealand.OTU.FRQ"==1) #pulls out all OTUs that only occur in the location
#Number.OTUS.of.SouthernNewZealand.only<-length(intersect(OTUS.with.1.REG.only,OTUS.of.SouthernNewZealand)) #calculates the number of OTUs in the region that only occur once
#ENDEMIC.OTUS.SouthernNewZealand<-round(((Number.OTUS.of.SouthernNewZealand.only/sum(tREGS.OTU.FRQ.df$"SouthernNewZealand.OTU.FRQ"))*100), digits = 1) # calculates percentage and rounds to the first decimal place

OTUS.with.1.REG.only<-which(RowSum==1) #pulls out all OTUs that only occur in one location
OTUS.of.NortheastAustralianShelf<-which(tREGS.OTU.FRQ.df$"NortheastAustralianShelf.OTU.FRQ"==1) #pulls out all OTUs that only occur in the location
Number.OTUS.of.NortheastAustralianShelf.only<-length(intersect(OTUS.with.1.REG.only,OTUS.of.NortheastAustralianShelf)) #calculates the number of OTUs in the region that only occur once
ENDEMIC.OTUS.NortheastAustralianShelf<-round(((Number.OTUS.of.NortheastAustralianShelf.only/sum(tREGS.OTU.FRQ.df$"NortheastAustralianShelf.OTU.FRQ"))*100), digits = 1) # calculates percentage and rounds to the first decimal place

#OTUS.with.1.REG.only<-which(RowSum==1) #pulls out all OTUs that only occur in one location
#OTUS.of.LordHoweandNorfolkIslands<-which(tREGS.OTU.FRQ.df$"LordHoweandNorfolkIslands.OTU.FRQ"==1) #pulls out all OTUs that only occur in the location
#Number.OTUS.of.LordHoweandNorfolkIslands.only<-length(intersect(OTUS.with.1.REG.only,OTUS.of.LordHoweandNorfolkIslands)) #calculates the number of OTUs in the region that only occur once
#ENDEMIC.OTUS.LordHoweandNorfolkIslands<-round(((Number.OTUS.of.LordHoweandNorfolkIslands.only/sum(tREGS.OTU.FRQ.df$"LordHoweandNorfolkIslands.OTU.FRQ"))*100), digits = 1) # calculates percentage and rounds to the first decimal place

#OTUS.with.1.REG.only<-which(RowSum==1) #pulls out all OTUs that only occur in one location
#OTUS.of.WestCentralAustralianShelf<-which(tREGS.OTU.FRQ.df$"WestCentralAustralianShelf.OTU.FRQ"==1) #pulls out all OTUs that only occur in the location
#Number.OTUS.of.WestCentralAustralianShelf.only<-length(intersect(OTUS.with.1.REG.only,OTUS.of.WestCentralAustralianShelf)) #calculates the number of OTUs in the region that only occur once
#ENDEMIC.OTUS.WestCentralAustralianShelf<-round(((Number.OTUS.of.WestCentralAustralianShelf.only/sum(tREGS.OTU.FRQ.df$"WestCentralAustralianShelf.OTU.FRQ"))*100), digits = 1) # calculates percentage and rounds to the first decimal place

#OTUS.with.1.REG.only<-which(RowSum==1) #pulls out all OTUs that only occur in one location
#OTUS.of.SouthwestAustralianShelf<-which(tREGS.OTU.FRQ.df$"SouthwestAustralianShelf.OTU.FRQ"==1) #pulls out all OTUs that only occur in the location
#Number.OTUS.of.SouthwestAustralianShelf.only<-length(intersect(OTUS.with.1.REG.only,OTUS.of.SouthwestAustralianShelf)) #calculates the number of OTUs in the region that only occur once
#ENDEMIC.OTUS.SouthwestAustralianShelf<-round(((Number.OTUS.of.SouthwestAustralianShelf.only/sum(tREGS.OTU.FRQ.df$"SouthwestAustralianShelf.OTU.FRQ"))*100), digits = 1) # calculates percentage and rounds to the first decimal place

OTUS.with.1.REG.only<-which(RowSum==1) #pulls out all OTUs that only occur in one location
OTUS.of.TropicalSouthwesternPacific<-which(tREGS.OTU.FRQ.df$"TropicalSouthwesternPacific.OTU.FRQ"==1) #pulls out all OTUs that only occur in the location
Number.OTUS.of.TropicalSouthwesternPacific.only<-length(intersect(OTUS.with.1.REG.only,OTUS.of.TropicalSouthwesternPacific)) #calculates the number of OTUs in the region that only occur once
ENDEMIC.OTUS.TropicalSouthwesternPacific<-round(((Number.OTUS.of.TropicalSouthwesternPacific.only/sum(tREGS.OTU.FRQ.df$"TropicalSouthwesternPacific.OTU.FRQ"))*100), digits = 1) # calculates percentage and rounds to the first decimal place

OTUS.with.1.REG.only<-which(RowSum==1) #pulls out all OTUs that only occur in one location
OTUS.of.EasternCoralTriangle<-which(tREGS.OTU.FRQ.df$"EasternCoralTriangle.OTU.FRQ"==1) #pulls out all OTUs that only occur in the location
Number.OTUS.of.EasternCoralTriangle.only<-length(intersect(OTUS.with.1.REG.only,OTUS.of.EasternCoralTriangle)) #calculates the number of OTUs in the region that only occur once
ENDEMIC.OTUS.EasternCoralTriangle<-round(((Number.OTUS.of.EasternCoralTriangle.only/sum(tREGS.OTU.FRQ.df$"EasternCoralTriangle.OTU.FRQ"))*100), digits = 1) # calculates percentage and rounds to the first decimal place

OTUS.with.1.REG.only<-which(RowSum==1) #pulls out all OTUs that only occur in one location
OTUS.of.NorthwestAustralianShelf<-which(tREGS.OTU.FRQ.df$"NorthwestAustralianShelf.OTU.FRQ"==1) #pulls out all OTUs that only occur in the location
Number.OTUS.of.NorthwestAustralianShelf.only<-length(intersect(OTUS.with.1.REG.only,OTUS.of.NorthwestAustralianShelf)) #calculates the number of OTUs in the region that only occur once
ENDEMIC.OTUS.NorthwestAustralianShelf<-round(((Number.OTUS.of.NorthwestAustralianShelf.only/sum(tREGS.OTU.FRQ.df$"NorthwestAustralianShelf.OTU.FRQ"))*100), digits = 1) # calculates percentage and rounds to the first decimal place

OTUS.with.1.REG.only<-which(RowSum==1) #pulls out all OTUs that only occur in one location
OTUS.of.WesternCoralTriangle<-which(tREGS.OTU.FRQ.df$"WesternCoralTriangle.OTU.FRQ"==1) #pulls out all OTUs that only occur in the location
Number.OTUS.of.WesternCoralTriangle.only<-length(intersect(OTUS.with.1.REG.only,OTUS.of.WesternCoralTriangle)) #calculates the number of OTUs in the region that only occur once
ENDEMIC.OTUS.WesternCoralTriangle<-round(((Number.OTUS.of.WesternCoralTriangle.only/sum(tREGS.OTU.FRQ.df$"WesternCoralTriangle.OTU.FRQ"))*100), digits = 1) # calculates percentage and rounds to the first decimal place

OTUS.with.1.REG.only<-which(RowSum==1) #pulls out all OTUs that only occur in one location
OTUS.of.SahulShelf<-which(tREGS.OTU.FRQ.df$"SahulShelf.OTU.FRQ"==1) #pulls out all OTUs that only occur in the location
Number.OTUS.of.SahulShelf.only<-length(intersect(OTUS.with.1.REG.only,OTUS.of.SahulShelf)) #calculates the number of OTUs in the region that only occur once
ENDEMIC.OTUS.SahulShelf<-round(((Number.OTUS.of.SahulShelf.only/sum(tREGS.OTU.FRQ.df$"SahulShelf.OTU.FRQ"))*100), digits = 1) # calculates percentage and rounds to the first decimal place

write.xlsx(tREGS.OTU.FRQ.df, col.names=TRUE, "E:/0_Master_Thesis/R_test/Final_R/28S_8Provinces/1bp/tREGS.OTU.FRQ.df_1bp.xlsx")

print(paste("Percentage of unshared OTUs is    ",ENDEMIC.OTUS.EastCentralAustralianShelf,"(EastCentral Australian Shelf)",
            ENDEMIC.OTUS.EasternCoralTriangle,"(Eastern Coral Triangle)  ",
            #ENDEMIC.OTUS.LordHoweandNorfolkIslands,"(Lord Howe and Norfolk Islands)  ",
            ENDEMIC.OTUS.NortheastAustralianShelf,"(Northeast Australian Shelf)  ",
            ENDEMIC.OTUS.NorthwestAustralianShelf,"(Northwest Australian Shelf)  ",
            ENDEMIC.OTUS.SahulShelf,"(Sahul Shelf)  ",
            ENDEMIC.OTUS.SoutheastAustralianShelf,"(Southeast Australian Shelf)  ",
            #ENDEMIC.OTUS.SouthernNewZealand,"(Southern New Zealand)  ",
            #ENDEMIC.OTUS.SouthwestAustralianShelf,"(Southwest Australian Shelf)  ",
            ENDEMIC.OTUS.TropicalSouthwesternPacific,"(Tropical Southwestern Pacific)  ",
            #ENDEMIC.OTUS.WestCentralAustralianShelf,"(West Central Australian Shelf)  ", 
            ENDEMIC.OTUS.WesternCoralTriangle,"(Western Coral Triangle)  "
            ))


############################### adapted to IPD up to here

### Biodiversity analyzes
print(cat("Biodiversity fata for:\t\t\t",rownames(REGS.OTU.FRQ.df)," ",sep="\t")) #Display the order of the regions

## calculating Shannons index for each region
SHANNON.REGS <- round(diversity(REGS.OTU.FRQ.df, index = "shannon"),digits = 2) #Calculation and rounding to 2 decimal places 
print(cat("Shannon index is:\t\t",SHANNON.REGS," ",sep="\t\t")) #output to screen


#######################################
###Ordination (Distance measures)

## Sorensons index
REGS.SO<-vegdist(REGS.OTU.FRQ.df, method="bray", binary=TRUE) #TRUE would give the result for presence-absence (Sorensons index)
print("Sorensons index is:") #output to screen
print(REGS.SO) #output to screen
heatmap(as.matrix(REGS.SO)) 
REGS.SO.MAT<-(as.matrix(REGS.SO)) # change to matrix for heatmap
my_palette <- colorRampPalette(brewer.pal(7, "YlGn"))(256)# gives the colour spectrum
heatmap(REGS.SO.MAT,revC = TRUE, symm=TRUE, col=my_palette, margins = c(8,8), 
        distfun=dist) #displays the heatmap, indicates symmetry and that the dendrogtam of rows should be morrored to match the column-dendogram

my_palette <- colorRampPalette(brewer.pal(7, "YlGn"))(299)
heatmap.2(REGS.SO.MAT, scale="none", 
          trace="none",
          Rowv = T,
          Colv= "Rowv",
          distfun = dist,
          hclustfun = hclust,
          dendrogram="both",
          symm = TRUE,
          breaks=
            c(seq(0,0.89,length=100), # for red
              seq(0.90,0.96,length=100),  # for yellow
              seq(0.97,1,length=100)),# for green
          col=my_palette)

write.xlsx(REGS.SO.MAT, col.names=TRUE, "E:/0_Master_Thesis/R_test/Final_R/28S_8Provinces/1bp/REGS.SO.MAT.xlsx")


## Jaccard index
REGS.JA<-vegdist(REGS.OTU.FRQ.df, method="jaccard", binary=TRUE) #Jaccard index
print("Jaccard index is:") #output to screen
print(REGS.JA) #output to screen
REGS.JA.MAT<-(as.matrix(REGS.JA)) # change to matrix for heatmap
my_palette <- colorRampPalette(brewer.pal(7, "YlGn"))(256) # gives the colour spectrum
heatmap(REGS.JA.MAT,revC = TRUE, symm=TRUE, col=my_palette, margins = c(8,8)) #displays the heatmap, indicates symmetry and that the dendrogtam of rows should be morrored to match the column-dendogram

library(xlsx)
write.xlsx(REGS.JA.MAT, col.names=TRUE, "E:/0_Master_Thesis/R_test/Final_R/28S_8Provinces/1bp/REGS.JA.MAT.xlsx")

library(gplots)

my_palette <- colorRampPalette(brewer.pal(7, "YlGn"))(299)
heatmap.2(REGS.JA.MAT, scale="none", 
          trace="none",
          Rowv = T,
          Colv= "Rowv",
          distfun = dist,
          hclustfun = hclust,
          dendrogram="both",
          symm = TRUE,
          breaks=
            c(seq(0,0.89,length=100), # for red
              seq(0.90,0.96,length=100),  # for yellow
              seq(0.97,1,length=100)),# for green
          col=my_palette)


########################################################
######## Further Analyses

## Comparison of the level lists. (would have been easier with intersect (EasternCoralTriangle.only.df $ OTU, EastCentralAustralianShelf.only.df $ OTU) ...)

#NortheastAustralianShelf & NorthwestAustralianShelf
#sharedOTUs1 <- intersect(LEVELS.OTUS.NortheastAustralianShelf,LEVELS.OTUS.NorthwestAustralianShelf)
#print(paste("The following",length(sharedOTUs1),"genotypes are shared:"))
#print(sharedOTUs1)

#EasternCoralTriangle & NorthwestAustralianShelf
#sharedOTUs2 <- intersect(LEVELS.OTUS.EasternCoralTriangle,LEVELS.OTUS.NorthwestAustralianShelf)
#print(paste("The following",length(sharedOTUs2),"genotypes are shared:"))
#print(sharedOTUs2)

#EasternCoralTriangle & TropicalSouthwesternPacific
#sharedOTUs3 <- intersect(LEVELS.OTUS.EasternCoralTriangle,LEVELS.OTUS.TropicalSouthwesternPacific)
#print(paste("The following",length(sharedOTUs3),"genotypes are shared:"))
#print(sharedOTUs3)

#EastCentralAustralianShelf & WesternCoralTriangle
#sharedOTUs4 <- intersect(LEVELS.OTUS.EastCentralAustralianShelf,LEVELS.OTUS.WesternCoralTriangle)
#print(paste("The following",length(sharedOTUs4),"genotypes are shared:"))
#print(sharedOTUs4)

#SahulShelf & SoutheastAustralianShelf
#sharedOTUs5 <- intersect(LEVELS.OTUS.SahulShelf,LEVELS.OTUS.SoutheastAustralianShelf)
#print(paste("The following",length(sharedOTUs5),"genotypes are shared:"))
#print(sharedOTUs5)
