## Biodiversity Analysis

## Initializing

library(RColorBrewer)
library(picante)                          # loads the Biodiversity library
#if (!require("gplots")) {
#  install.packages("gplots", dependencies = TRUE)
#  library(gplots)
#}
library(gplots)


setwd("E:/0_Master_Thesis/R_test/Final_R/Ecoregions/28S/2bp") # setting directory

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
ArnhemCoasttoGulfofCarpenteria.only.df <- subset(alldata.df, alldata.df$Region == "Arnhem Coast to Gulf of Carpenteria")
Bassian.only.df <- subset(alldata.df, alldata.df$Region == "Bassian")
BonaparteCoast.only.df <- subset(alldata.df, alldata.df$Region == "Bonaparte Coast")
CapeHowe.only.df <- subset(alldata.df, alldata.df$Region == "Cape Howe")
CoralSea.only.df <- subset(alldata.df, alldata.df$Region == "Coral Sea")
ExmouthtoBroome.only.df <- subset(alldata.df, alldata.df$Region == "Exmouth to Broome")
ManningHawkesbury.only.df <- subset(alldata.df, alldata.df$Region == "Manning-Hawkesbury")
NewCaledonia.only.df <- subset(alldata.df, alldata.df$Region == "New Caledonia")
SolomonArchipelago.only.df <- subset(alldata.df, alldata.df$Region == "Solomon Archipelago")
SoutheastPapuaNewGuinea.only.df <- subset(alldata.df, alldata.df$Region == "Southeast Papua New Guinea")
TorresStraitNorthernGreatBarrierReef.only.df <- subset(alldata.df, alldata.df$Region == "Torres Strait Northern Great Barrier Reef")
TweedMoreton.only.df <- subset(alldata.df, alldata.df$Region == "Tweed-Moreton")
WesternBassian.only.df <- subset(alldata.df, alldata.df$Region == "Western Bassian")

## Number of regions and specimens per region
NUMBER.SP.ALL.REGS <- c(dim(ArnhemCoasttoGulfofCarpenteria.only.df)[1],
                        dim(Bassian.only.df)[1],
                        dim(BonaparteCoast.only.df)[1],
                        dim(CapeHowe.only.df)[1],
                        dim(CoralSea.only.df)[1],
                        dim(ExmouthtoBroome.only.df)[1],
                        dim(ManningHawkesbury.only.df)[1],
                        dim(NewCaledonia.only.df)[1],
                        dim(SolomonArchipelago.only.df)[1],
                        dim(SoutheastPapuaNewGuinea.only.df)[1],
                        dim(TorresStraitNorthernGreatBarrierReef.only.df)[1],
                        dim(TweedMoreton.only.df)[1],
                        dim(WesternBassian.only.df)[1]
                        ) #for later calculations if necessary

NUMBER.REGS<- length(NUMBER.SP.ALL.REGS)
print(paste("There are ",NUMBER.REGS,"regions")) # output for region number
print(paste("Numbers of specimens are         ",
            dim(ArnhemCoasttoGulfofCarpenteria.only.df)[1],"(Arnhem Coast to Gulf of Carpenteria)  ",
            dim(Bassian.only.df)[1],"(Bassian)  ",
            dim(BonaparteCoast.only.df)[1],"(Bonaparte Coast)  ",
            dim(CapeHowe.only.df)[1],"(Cape Howe)  ",
            dim(CoralSea.only.df)[1],"(Coral Sea)  ",
            dim(ExmouthtoBroome.only.df)[1],"(Exmouth to Broome)  ",
            dim(ManningHawkesbury.only.df)[1],"(Manning-Hawkesbury)  ",
            dim(NewCaledonia.only.df)[1],"(New Caledonia)  ",
            dim(SolomonArchipelago.only.df)[1],"(Solomon Archipelago)  ",
            dim(SoutheastPapuaNewGuinea.only.df)[1],"(Southeast Papua New Guinea)  ",
            dim(TorresStraitNorthernGreatBarrierReef.only.df)[1],"(Torres Strait Northern Great Barrier Reef)  ",
            dim(TweedMoreton.only.df)[1],"(Tweed-Moreton)  ",
            dim(WesternBassian.only.df)[1],"(Western Bassian)  "
            )) # output

## Creation of two factors that only the OTUs of the respective regions have
OTUS.ArnhemCoasttoGulfofCarpenteria <- ArnhemCoasttoGulfofCarpenteria.only.df$OTU[drop=TRUE]
OTUS.Bassian <- Bassian.only.df$OTU[drop=TRUE]
OTUS.BonaparteCoast <- BonaparteCoast.only.df$OTU[drop=TRUE]
OTUS.CapeHowe <- CapeHowe.only.df$OTU[drop=TRUE]
OTUS.CoralSea <- CoralSea.only.df$OTU[drop=TRUE]
OTUS.ExmouthtoBroome <- ExmouthtoBroome.only.df$OTU[drop=TRUE]
OTUS.ManningHawkesbury <- ManningHawkesbury.only.df$OTU[drop=TRUE]
OTUS.NewCaledonia <- NewCaledonia.only.df$OTU[drop=TRUE]
OTUS.SolomonArchipelago <- SolomonArchipelago.only.df$OTU[drop=TRUE]
OTUS.SoutheastPapuaNewGuinea <- SoutheastPapuaNewGuinea.only.df$OTU[drop=TRUE]
OTUS.TorresStraitNorthernGreatBarrierReef <- TorresStraitNorthernGreatBarrierReef.only.df$OTU[drop=TRUE]
OTUS.TweedMoreton <- TweedMoreton.only.df$OTU[drop=TRUE]
OTUS.WesternBassian <- WesternBassian.only.df$OTU[drop=TRUE]


## Analysis of how many sequences have not been clustered
ArnhemCoasttoGulfofCarpenteria.only.no.NA<-length(which(is.na(OTUS.ArnhemCoasttoGulfofCarpenteria)==FALSE))
Bassian.only.no.NA<-length(which(is.na(OTUS.Bassian)==FALSE))
BonaparteCoast.only.no.NA<-length(which(is.na(OTUS.BonaparteCoast)==FALSE))
CapeHowe.no.NA<-length(which(is.na(OTUS.CapeHowe)==FALSE))
CoralSea.only.no.NA<-length(which(is.na(OTUS.CoralSea)==FALSE))
ExmouthtoBroome.only.no.NA<-length(which(is.na(OTUS.ExmouthtoBroome)==FALSE))
ManningHawkesbury.only.no.NA<-length(which(is.na(OTUS.ManningHawkesbury)==FALSE))
NewCaledonia.only.no.NA<-length(which(is.na(OTUS.NewCaledonia)==FALSE))
SolomonArchipelago.only.no.NA<-length(which(is.na(OTUS.SolomonArchipelago)==FALSE))
SoutheastPapuaNewGuinea.only.no.NA<-length(which(is.na(OTUS.SoutheastPapuaNewGuinea)==FALSE))
TorresStraitNorthernGreatBarrierReef.only.no.NA<-length(which(is.na(OTUS.TorresStraitNorthernGreatBarrierReef)==FALSE))
TweedMoreton.only.no.NA<-length(which(is.na(OTUS.TweedMoreton)==FALSE))
WesternBassian.only.no.NA<-length(which(is.na(OTUS.WesternBassian)==FALSE))


print(paste("Numbers of clustered specimens are ",
            ArnhemCoasttoGulfofCarpenteria.only.no.NA,"(Arnhem Coast to Gulf of Carpenteria)  ",
            Bassian.only.no.NA,"(Bassian)  ",
            BonaparteCoast.only.no.NA,"(Bonaparte Coast)  ",
            CapeHowe.no.NA,"(Cape Howe)  ",
            CoralSea.only.no.NA,"(Coral Sea)  ",
            ExmouthtoBroome.only.no.NA,"(Exmouth to Broome)  ",
            ManningHawkesbury.only.no.NA,"(Manning-Hawkesbury)  ",
            NewCaledonia.only.no.NA,"(New Caledonia)  ",
            SolomonArchipelago.only.no.NA,"(Solomon Archipelago)  ",
            SoutheastPapuaNewGuinea.only.no.NA,"(Southeast Papua New Guinea)  ",
            TorresStraitNorthernGreatBarrierReef.only.no.NA,"(Torres Strait Northern Great Barrier Reef)  ",
            TweedMoreton.only.no.NA,"(Tweed-Moreton)  ",
            WesternBassian.only.no.NA,"(Western Bassian)  "
            )) # output



## Creation of a level list of the regions
LEVELS.OTUS.ArnhemCoasttoGulfofCarpenteria <- levels(OTUS.ArnhemCoasttoGulfofCarpenteria)
LEVELS.OTUS.Bassian <- levels(OTUS.Bassian)
LEVELS.OTUS.BonaparteCoast <- levels(OTUS.BonaparteCoast)
LEVELS.OTUS.CapeHowe <- levels(OTUS.CapeHowe)
LEVELS.OTUS.CoralSea <- levels(OTUS.CoralSea)
LEVELS.OTUS.ExmouthtoBroome <- levels(OTUS.ExmouthtoBroome)
LEVELS.OTUS.ManningHawkesbury <- levels(OTUS.ManningHawkesbury)
LEVELS.OTUS.NewCaledonia <- levels(OTUS.NewCaledonia)
LEVELS.OTUS.SolomonArchipelago <- levels(OTUS.SolomonArchipelago)
LEVELS.OTUS.SoutheastPapuaNewGuinea <- levels(OTUS.SoutheastPapuaNewGuinea)
LEVELS.OTUS.TorresStraitNorthernGreatBarrierReef <- levels(OTUS.TorresStraitNorthernGreatBarrierReef)
LEVELS.OTUS.TweedMoreton <- levels(OTUS.TweedMoreton)
LEVELS.OTUS.WesternBassian <- levels(OTUS.WesternBassian)


print(paste("Numbers of OTUs are                 ",
            length(LEVELS.OTUS.ArnhemCoasttoGulfofCarpenteria),"(Arnhem Coast to Gulf of Carpenteria)  ",
            length(LEVELS.OTUS.Bassian),"(Bassian)  ",
            length(LEVELS.OTUS.BonaparteCoast),"(Bonaparte Coast)  ",
            length(LEVELS.OTUS.CapeHowe),"(Cape Howe)  ",
            length(LEVELS.OTUS.CoralSea),"(Coral Sea)  ",
            length(LEVELS.OTUS.ExmouthtoBroome),"(Exmouth to Broome)  ",
            length(LEVELS.OTUS.ManningHawkesbury),"(Manning-Hawkesbury)  ",
            length(LEVELS.OTUS.NewCaledonia),"(New Caledonia)  ",
            length(LEVELS.OTUS.SolomonArchipelago),"(Solomon Archipelago)  ",
            length(LEVELS.OTUS.SoutheastPapuaNewGuinea),"(Southeast Papua New Guinea)  ",
            length(LEVELS.OTUS.TorresStraitNorthernGreatBarrierReef),"(Torres Strait Northern Great Barrier Reef)  ",
            length(LEVELS.OTUS.TweedMoreton),"(Tweed-Moreton)  ",
            length(LEVELS.OTUS.WesternBassian),"(Western Bassian)  "
            ))


## Creation of a table for the regions with only genotypes and number.
Bassian.Specimens.pro.OTU <-table(OTUS.Bassian)
Bassian.Specimens.pro.OTU.mat <- matrix(Bassian.Specimens.pro.OTU)
rownames(Bassian.Specimens.pro.OTU.mat) <- LEVELS.OTUS.Bassian
colnames(Bassian.Specimens.pro.OTU.mat) <- "Number"

ArnhemCoasttoGulfofCarpenteria.Specimens.pro.OTU <-table(OTUS.ArnhemCoasttoGulfofCarpenteria)
ArnhemCoasttoGulfofCarpenteria.Specimens.pro.OTU.mat <- matrix(ArnhemCoasttoGulfofCarpenteria.Specimens.pro.OTU)
rownames(ArnhemCoasttoGulfofCarpenteria.Specimens.pro.OTU.mat) <- LEVELS.OTUS.ArnhemCoasttoGulfofCarpenteria
colnames(ArnhemCoasttoGulfofCarpenteria.Specimens.pro.OTU.mat) <- "Number"

BonaparteCoast.Specimens.pro.OTU <-table(OTUS.BonaparteCoast)
BonaparteCoast.Specimens.pro.OTU.mat <- matrix(BonaparteCoast.Specimens.pro.OTU)
rownames(BonaparteCoast.Specimens.pro.OTU.mat) <- LEVELS.OTUS.BonaparteCoast
colnames(BonaparteCoast.Specimens.pro.OTU.mat) <- "Number"

CapeHowe.Specimens.pro.OTU <-table(OTUS.CapeHowe)
CapeHowe.Specimens.pro.OTU.mat <- matrix(CapeHowe.Specimens.pro.OTU)
rownames(CapeHowe.Specimens.pro.OTU.mat) <- LEVELS.OTUS.CapeHowe
colnames(CapeHowe.Specimens.pro.OTU.mat) <- "Number"

CoralSea.Specimens.pro.OTU <-table(OTUS.CoralSea)
CoralSea.Specimens.pro.OTU.mat <- matrix(CoralSea.Specimens.pro.OTU)
rownames(CoralSea.Specimens.pro.OTU.mat) <- LEVELS.OTUS.CoralSea
colnames(CoralSea.Specimens.pro.OTU.mat) <- "Number"

ExmouthtoBroome.Specimens.pro.OTU <-table(OTUS.ExmouthtoBroome)
ExmouthtoBroome.Specimens.pro.OTU.mat <- matrix(ExmouthtoBroome.Specimens.pro.OTU)
rownames(ExmouthtoBroome.Specimens.pro.OTU.mat) <- LEVELS.OTUS.ExmouthtoBroome
colnames(ExmouthtoBroome.Specimens.pro.OTU.mat) <- "Number"

ManningHawkesbury.Specimens.pro.OTU <-table(OTUS.ManningHawkesbury)
ManningHawkesbury.Specimens.pro.OTU.mat <- matrix(ManningHawkesbury.Specimens.pro.OTU)
rownames(ManningHawkesbury.Specimens.pro.OTU.mat) <- LEVELS.OTUS.ManningHawkesbury
colnames(ManningHawkesbury.Specimens.pro.OTU.mat) <- "Number"

NewCaledonia.Specimens.pro.OTU <-table(OTUS.NewCaledonia)
NewCaledonia.Specimens.pro.OTU.mat <- matrix(NewCaledonia.Specimens.pro.OTU)
rownames(NewCaledonia.Specimens.pro.OTU.mat) <- LEVELS.OTUS.NewCaledonia
colnames(NewCaledonia.Specimens.pro.OTU.mat) <- "Number"

SolomonArchipelago.Specimens.pro.OTU <-table(OTUS.SolomonArchipelago)
SolomonArchipelago.Specimens.pro.OTU.mat <- matrix(SolomonArchipelago.Specimens.pro.OTU)
rownames(SolomonArchipelago.Specimens.pro.OTU.mat) <- LEVELS.OTUS.SolomonArchipelago
colnames(SolomonArchipelago.Specimens.pro.OTU.mat) <- "Number"

SoutheastPapuaNewGuinea.Specimens.pro.OTU <-table(OTUS.SoutheastPapuaNewGuinea)
SoutheastPapuaNewGuinea.Specimens.pro.OTU.mat <- matrix(SoutheastPapuaNewGuinea.Specimens.pro.OTU)
rownames(SoutheastPapuaNewGuinea.Specimens.pro.OTU.mat) <- LEVELS.OTUS.SoutheastPapuaNewGuinea
colnames(SoutheastPapuaNewGuinea.Specimens.pro.OTU.mat) <- "Number"

TorresStraitNorthernGreatBarrierReef.Specimens.pro.OTU <-table(OTUS.TorresStraitNorthernGreatBarrierReef)
TorresStraitNorthernGreatBarrierReef.Specimens.pro.OTU.mat <- matrix(TorresStraitNorthernGreatBarrierReef.Specimens.pro.OTU)
rownames(TorresStraitNorthernGreatBarrierReef.Specimens.pro.OTU.mat) <- LEVELS.OTUS.TorresStraitNorthernGreatBarrierReef
colnames(TorresStraitNorthernGreatBarrierReef.Specimens.pro.OTU.mat) <- "Number"

TweedMoreton.Specimens.pro.OTU <-table(OTUS.TweedMoreton)
TweedMoreton.Specimens.pro.OTU.mat <- matrix(TweedMoreton.Specimens.pro.OTU)
rownames(TweedMoreton.Specimens.pro.OTU.mat) <- LEVELS.OTUS.TweedMoreton
colnames(TweedMoreton.Specimens.pro.OTU.mat) <- "Number"

WesternBassian.Specimens.pro.OTU <-table(OTUS.WesternBassian)
WesternBassian.Specimens.pro.OTU.mat <- matrix(WesternBassian.Specimens.pro.OTU)
rownames(WesternBassian.Specimens.pro.OTU.mat) <- LEVELS.OTUS.WesternBassian
colnames(WesternBassian.Specimens.pro.OTU.mat) <- "Number"


## Creation of a table "REGS.OTU.FRQ" with regions on Y and OTUS in X
Bassian.OTU.FRQ <- table(Bassian.only.df$OTU[drop=FALSE]) # First region in table read
Bassian.OTU.FRQ.mat <- matrix(Bassian.OTU.FRQ,nrow = 1,ncol=(length(Bassian.OTU.FRQ))) #Shape the table as a matrix
colnames(Bassian.OTU.FRQ.mat) <- levels(Bassian.only.df$OTU) # Adapt columnames to OTU names
rownames(Bassian.OTU.FRQ.mat) <- "Bassian.OTU.FRQ" # Customize row names

ArnhemCoasttoGulfofCarpenteria.OTU.FRQ <- table(ArnhemCoasttoGulfofCarpenteria.only.df$OTU[drop=FALSE]) # Read the second region as a table
REGS.OTU.FRQ.mat <- rbind(Bassian.OTU.FRQ.mat, ArnhemCoasttoGulfofCarpenteria.OTU.FRQ) # Combine the second region in the table of the first to "REGS.OTU.FRQ"

CapeHowe.OTU.FRQ <- table(CapeHowe.only.df$OTU[drop=FALSE]) # Read the following region as a table
REGS.OTU.FRQ.mat <- rbind(REGS.OTU.FRQ.mat, CapeHowe.OTU.FRQ) # merge the following region in the table of the first to "REGS.OTU.FRQ"

BonaparteCoast.OTU.FRQ <- table(BonaparteCoast.only.df$OTU[drop=FALSE]) # Read the following region as a table
REGS.OTU.FRQ.mat <- rbind(REGS.OTU.FRQ.mat, BonaparteCoast.OTU.FRQ) # merge the following region in the table of the first to "REGS.OTU.FRQ"

CoralSea.OTU.FRQ <- table(CoralSea.only.df$OTU[drop=FALSE]) # Read the following region as a table
REGS.OTU.FRQ.mat <- rbind(REGS.OTU.FRQ.mat, CoralSea.OTU.FRQ) # merge the following region in the table of the first to "REGS.OTU.FRQ"

ExmouthtoBroome.OTU.FRQ <- table(ExmouthtoBroome.only.df$OTU[drop=FALSE]) # Read the following region as a table
REGS.OTU.FRQ.mat <- rbind(REGS.OTU.FRQ.mat, ExmouthtoBroome.OTU.FRQ) # merge the following region in the table of the first to "REGS.OTU.FRQ"

ManningHawkesbury.OTU.FRQ <- table(ManningHawkesbury.only.df$OTU[drop=FALSE]) # Read the following region as a table
REGS.OTU.FRQ.mat <- rbind(REGS.OTU.FRQ.mat, ManningHawkesbury.OTU.FRQ) # merge the following region in the table of the first to "REGS.OTU.FRQ"

NewCaledonia.OTU.FRQ <- table(NewCaledonia.only.df$OTU[drop=FALSE]) # Read the following region as a table
REGS.OTU.FRQ.mat <- rbind(REGS.OTU.FRQ.mat, NewCaledonia.OTU.FRQ) # merge the following region in the table of the first to "REGS.OTU.FRQ"

SolomonArchipelago.OTU.FRQ <- table(SolomonArchipelago.only.df$OTU[drop=FALSE]) # Read the following region as a table
REGS.OTU.FRQ.mat <- rbind(REGS.OTU.FRQ.mat, SolomonArchipelago.OTU.FRQ) # merge the following region in the table of the first to "REGS.OTU.FRQ"

SoutheastPapuaNewGuinea.OTU.FRQ <- table(SoutheastPapuaNewGuinea.only.df$OTU[drop=FALSE]) # Read the following region as a table
REGS.OTU.FRQ.mat <- rbind(REGS.OTU.FRQ.mat, SoutheastPapuaNewGuinea.OTU.FRQ) # merge the following region in the table of the first to "REGS.OTU.FRQ"

TorresStraitNorthernGreatBarrierReef.OTU.FRQ <- table(TorresStraitNorthernGreatBarrierReef.only.df$OTU[drop=FALSE]) # Read the following region as a table
REGS.OTU.FRQ.mat <- rbind(REGS.OTU.FRQ.mat, TorresStraitNorthernGreatBarrierReef.OTU.FRQ) # merge the following region in the table of the first to "REGS.OTU.FRQ"

TweedMoreton.OTU.FRQ <- table(TweedMoreton.only.df$OTU[drop=FALSE]) # Read the following region as a table
REGS.OTU.FRQ.mat <- rbind(REGS.OTU.FRQ.mat, TweedMoreton.OTU.FRQ) # merge the following region in the table of the first to "REGS.OTU.FRQ"

WesternBassian.OTU.FRQ <- table(WesternBassian.only.df$OTU[drop=FALSE]) # Read the following region as a table
REGS.OTU.FRQ.mat <- rbind(REGS.OTU.FRQ.mat, WesternBassian.OTU.FRQ) # merge the following region in the table of the first to "REGS.OTU.FRQ"

REGS.OTU.FRQ.df <- as.data.frame(REGS.OTU.FRQ.mat) #macht ein data frame daraus (turns it into a data frame)

write.xlsx(REGS.OTU.FRQ.df, col.names=TRUE, "E:/0_Master_Thesis/R_test/Final_R/Ecoregions/28S/2bp/REGS.OTU.FRQ.df_2bp.xlsx")

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
OTUS.of.ManningHawkesbury<-which(tREGS.OTU.FRQ.df$"ManningHawkesbury.OTU.FRQ"==1) #pulls out all OTUs that only occur in the location
Number.OTUS.of.ManningHawkesbury.only<-length(intersect(OTUS.with.1.REG.only,OTUS.of.ManningHawkesbury)) #calculates the number of OTUs in the region that only occur once
ENDEMIC.OTUS.ManningHawkesbury<-round(((Number.OTUS.of.ManningHawkesbury.only/sum(tREGS.OTU.FRQ.df$"ManningHawkesbury.OTU.FRQ"))*100), digits = 1) # calculates percentage and rounds to the first decimal place

OTUS.with.1.REG.only<-which(RowSum==1) #pulls out all OTUs that only occur in one location
OTUS.of.ArnhemCoasttoGulfofCarpenteria<-which(tREGS.OTU.FRQ.df$"ArnhemCoasttoGulfofCarpenteria.OTU.FRQ"==1) #pulls out all OTUs that only occur in the location
Number.OTUS.of.ArnhemCoasttoGulfofCarpenteria.only<-length(intersect(OTUS.with.1.REG.only,OTUS.of.ArnhemCoasttoGulfofCarpenteria)) #calculates the number of OTUs in the region that only occur once
ENDEMIC.OTUS.ArnhemCoasttoGulfofCarpenteria<-round(((Number.OTUS.of.ArnhemCoasttoGulfofCarpenteria.only/sum(tREGS.OTU.FRQ.df$"ArnhemCoasttoGulfofCarpenteria.OTU.FRQ"))*100), digits = 1) # calculates percentage and rounds to the first decimal place

OTUS.with.1.REG.only<-which(RowSum==1) #pulls out all OTUs that only occur in one location
OTUS.of.NewCaledonia<-which(tREGS.OTU.FRQ.df$"NewCaledonia.OTU.FRQ"==1) #pulls out all OTUs that only occur in the location
Number.OTUS.of.NewCaledonia.only<-length(intersect(OTUS.with.1.REG.only,OTUS.of.NewCaledonia)) #calculates the number of OTUs in the region that only occur once
ENDEMIC.OTUS.NewCaledonia<-round(((Number.OTUS.of.NewCaledonia.only/sum(tREGS.OTU.FRQ.df$"NewCaledonia.OTU.FRQ"))*100), digits = 1) # calculates percentage and rounds to the first decimal place

OTUS.with.1.REG.only<-which(RowSum==1) #pulls out all OTUs that only occur in one location
OTUS.of.CapeHowe<-which(tREGS.OTU.FRQ.df$"CapeHowe.OTU.FRQ"==1) #pulls out all OTUs that only occur in the location
Number.OTUS.of.CapeHowe<-length(intersect(OTUS.with.1.REG.only,OTUS.of.CapeHowe)) #calculates the number of OTUs in the region that only occur once
ENDEMIC.OTUS.CapeHowe<-round(((Number.OTUS.of.CapeHowe/sum(tREGS.OTU.FRQ.df$"CapeHowe.OTU.FRQ"))*100), digits = 1) # calculates percentage and rounds to the first decimal place

OTUS.with.1.REG.only<-which(RowSum==1) #pulls out all OTUs that only occur in one location
OTUS.of.BonaparteCoast<-which(tREGS.OTU.FRQ.df$"BonaparteCoast.OTU.FRQ"==1) #pulls out all OTUs that only occur in the location
Number.OTUS.of.BonaparteCoast.only<-length(intersect(OTUS.with.1.REG.only,OTUS.of.BonaparteCoast)) #calculates the number of OTUs in the region that only occur once
ENDEMIC.OTUS.BonaparteCoast<-round(((Number.OTUS.of.BonaparteCoast.only/sum(tREGS.OTU.FRQ.df$"BonaparteCoast.OTU.FRQ"))*100), digits = 1) # calculates percentage and rounds to the first decimal place

OTUS.with.1.REG.only<-which(RowSum==1) #pulls out all OTUs that only occur in one location
OTUS.of.TorresStraitNorthernGreatBarrierReef<-which(tREGS.OTU.FRQ.df$"TorresStraitNorthernGreatBarrierReef.OTU.FRQ"==1) #pulls out all OTUs that only occur in the location
Number.OTUS.of.TorresStraitNorthernGreatBarrierReef.only<-length(intersect(OTUS.with.1.REG.only,OTUS.of.TorresStraitNorthernGreatBarrierReef)) #calculates the number of OTUs in the region that only occur once
ENDEMIC.OTUS.TorresStraitNorthernGreatBarrierReef<-round(((Number.OTUS.of.TorresStraitNorthernGreatBarrierReef.only/sum(tREGS.OTU.FRQ.df$"TorresStraitNorthernGreatBarrierReef.OTU.FRQ"))*100), digits = 1) # calculates percentage and rounds to the first decimal place

OTUS.with.1.REG.only<-which(RowSum==1) #pulls out all OTUs that only occur in one location
OTUS.of.SolomonArchipelago<-which(tREGS.OTU.FRQ.df$"SolomonArchipelago.OTU.FRQ"==1) #pulls out all OTUs that only occur in the location
Number.OTUS.of.SolomonArchipelago.only<-length(intersect(OTUS.with.1.REG.only,OTUS.of.SolomonArchipelago)) #calculates the number of OTUs in the region that only occur once
ENDEMIC.OTUS.SolomonArchipelago<-round(((Number.OTUS.of.SolomonArchipelago.only/sum(tREGS.OTU.FRQ.df$"SolomonArchipelago.OTU.FRQ"))*100), digits = 1) # calculates percentage and rounds to the first decimal place

OTUS.with.1.REG.only<-which(RowSum==1) #pulls out all OTUs that only occur in one location
OTUS.of.SoutheastPapuaNewGuinea<-which(tREGS.OTU.FRQ.df$"SoutheastPapuaNewGuinea.OTU.FRQ"==1) #pulls out all OTUs that only occur in the location
Number.OTUS.of.SoutheastPapuaNewGuinea.only<-length(intersect(OTUS.with.1.REG.only,OTUS.of.SoutheastPapuaNewGuinea)) #calculates the number of OTUs in the region that only occur once
ENDEMIC.OTUS.SoutheastPapuaNewGuinea<-round(((Number.OTUS.of.SoutheastPapuaNewGuinea.only/sum(tREGS.OTU.FRQ.df$"SoutheastPapuaNewGuinea.OTU.FRQ"))*100), digits = 1) # calculates percentage and rounds to the first decimal place

OTUS.with.1.REG.only<-which(RowSum==1) #pulls out all OTUs that only occur in one location
OTUS.of.Bassian<-which(tREGS.OTU.FRQ.df$"Bassian.OTU.FRQ"==1) #pulls out all OTUs that only occur in the location
Number.OTUS.of.Bassian.only<-length(intersect(OTUS.with.1.REG.only,OTUS.of.Bassian)) #calculates the number of OTUs in the region that only occur once
ENDEMIC.OTUS.Bassian<-round(((Number.OTUS.of.Bassian.only/sum(tREGS.OTU.FRQ.df$"Bassian.OTU.FRQ"))*100), digits = 1) # calculates percentage and rounds to the first decimal place

OTUS.with.1.REG.only<-which(RowSum==1) #pulls out all OTUs that only occur in one location
OTUS.of.CoralSea<-which(tREGS.OTU.FRQ.df$"CoralSea.OTU.FRQ"==1) #pulls out all OTUs that only occur in the location
Number.OTUS.of.CoralSea.only<-length(intersect(OTUS.with.1.REG.only,OTUS.of.CoralSea)) #calculates the number of OTUs in the region that only occur once
ENDEMIC.OTUS.CoralSea<-round(((Number.OTUS.of.CoralSea.only/sum(tREGS.OTU.FRQ.df$"CoralSea.OTU.FRQ"))*100), digits = 1) # calculates percentage and rounds to the first decimal place

OTUS.with.1.REG.only<-which(RowSum==1) #pulls out all OTUs that only occur in one location
OTUS.of.TweedMoreton<-which(tREGS.OTU.FRQ.df$"TweedMoreton.OTU.FRQ"==1) #pulls out all OTUs that only occur in the location
Number.OTUS.of.TweedMoreton.only<-length(intersect(OTUS.with.1.REG.only,OTUS.of.TweedMoreton)) #calculates the number of OTUs in the region that only occur once
ENDEMIC.OTUS.TweedMoreton<-round(((Number.OTUS.of.TweedMoreton.only/sum(tREGS.OTU.FRQ.df$"TweedMoreton.OTU.FRQ"))*100), digits = 1) # calculates percentage and rounds to the first decimal place

OTUS.with.1.REG.only<-which(RowSum==1) #pulls out all OTUs that only occur in one location
OTUS.of.ExmouthtoBroome<-which(tREGS.OTU.FRQ.df$"ExmouthtoBroome.OTU.FRQ"==1) #pulls out all OTUs that only occur in the location
Number.OTUS.of.ExmouthtoBroome.only<-length(intersect(OTUS.with.1.REG.only,OTUS.of.ExmouthtoBroome)) #calculates the number of OTUs in the region that only occur once
ENDEMIC.OTUS.ExmouthtoBroome<-round(((Number.OTUS.of.ExmouthtoBroome.only/sum(tREGS.OTU.FRQ.df$"ExmouthtoBroome.OTU.FRQ"))*100), digits = 1) # calculates percentage and rounds to the first decimal place

OTUS.with.1.REG.only<-which(RowSum==1) #pulls out all OTUs that only occur in one location
OTUS.of.WesternBassian<-which(tREGS.OTU.FRQ.df$"WesternBassian.OTU.FRQ"==1) #pulls out all OTUs that only occur in the location
Number.OTUS.of.WesternBassian.only<-length(intersect(OTUS.with.1.REG.only,OTUS.of.WesternBassian)) #calculates the number of OTUs in the region that only occur once
ENDEMIC.OTUS.WesternBassian<-round(((Number.OTUS.of.WesternBassian.only/sum(tREGS.OTU.FRQ.df$"WesternBassian.OTU.FRQ"))*100), digits = 1) # calculates percentage and rounds to the first decimal place

write.xlsx(tREGS.OTU.FRQ.df, col.names=TRUE, "E:/0_Master_Thesis/R_test/Final_R/Ecoregions/28S/2bp/tREGS.OTU.FRQ.df_2bp.xlsx")

print(paste("Percentage of unshared OTUs is    ",
            ENDEMIC.OTUS.ArnhemCoasttoGulfofCarpenteria,"(Arnhem Coast to Gulf of Carpenteria)",
            ENDEMIC.OTUS.Bassian,"(Bassian)  ",
            ENDEMIC.OTUS.BonaparteCoast,"(Bonaparte Coast)  ",
            ENDEMIC.OTUS.CapeHowe,"(Cape Howe)  ",
            ENDEMIC.OTUS.CoralSea,"(Coral Sea)  ",
            ENDEMIC.OTUS.ExmouthtoBroome,"(Exmouth to Broome)  ",
            ENDEMIC.OTUS.ManningHawkesbury,"(Manning-Hawkesbury)  ",
            ENDEMIC.OTUS.NewCaledonia,"(New Caledonia)  ",
            ENDEMIC.OTUS.SolomonArchipelago,"(Solomon Archipelago)  ",
            ENDEMIC.OTUS.SoutheastPapuaNewGuinea,"(Southeast Papua New Guinea)  ",
            ENDEMIC.OTUS.TorresStraitNorthernGreatBarrierReef,"(Torres Strait Northern Great Barrier Reef)  ", 
            ENDEMIC.OTUS.TweedMoreton,"(Tweed-Moreton)  ",
            ENDEMIC.OTUS.WesternBassian,"(Western Bassian)"
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

my_palette <- colorRampPalette(brewer.pal(7, "YlGnBu"))(299)
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

write.xlsx(REGS.SO.MAT, col.names=TRUE, "E:/0_Master_Thesis/R_test/Final_R/Ecoregions/28S/2bp/REGS.SO.MAT.xlsx")

## Jaccard index
REGS.JA<-vegdist(REGS.OTU.FRQ.df, method="jaccard", binary=TRUE) #Jaccard index
print("Jaccard index is:") #output to screen
print(REGS.JA) #output to screen
REGS.JA.MAT<-(as.matrix(REGS.JA)) # change to matrix for heatmap

my_palette <- colorRampPalette(brewer.pal(7, "YlGnBu"))(299)
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

library(xlsx)
write.xlsx(REGS.JA.MAT, col.names=TRUE, "E:/0_Master_Thesis/R_test/Final_R/Ecoregions/28S/2bp/REGS.JA.MAT.xlsx")


########################################################
