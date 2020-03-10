#install.packages("xlsx")
library(xlsx)

alldata.df_4bp<-read.csv("E:/0_Master_Thesis/R_test/Final_R/Mantel/table/alldata.df_4bp.csv", sep=",",  header = TRUE, quote = "")
Australian_Samples<-read.csv("E:/0_Master_Thesis/R_test/Final_R/Mantel/table/Australian_Samples.csv", sep=",",  header = TRUE, quote = "")


## To get Ecoregions; names and numbers separately
#Provinces_Mantel <- sort(table(Australian_Samples$PROVINCE), decreasing = TRUE)
#write.xlsx(Provinces_Mantel, col.names=TRUE, "E:/0_Master_Thesis/R_test/Final_R/Mantel/table/Provinces_Mantel.xlsx")


## To merge 2 tables --> using INNER JOIN
#install.packages("data.table")
library(data.table)

Australian_Samples<-data.table(Australian_Samples, key = "museum_code")
alldata.df_4bp<-data.table(alldata.df_4bp, key = "museum_code")

Australian_Samples_4bpOTU <- Australian_Samples[alldata.df_4bp]
write.xlsx(Australian_Samples_4bpOTU, col.names=TRUE, "E:/0_Master_Thesis/R_test/Final_R/Mantel/table/Australian_Samples_4bpOTU.xlsx")


#----------

#install.packages("geosphere")
library(geosphere)
#install.packages("ade4")
library(ade4)
library(vegan)

citation(package = "geosphere")
citation(package = "ade4")
citation(package = "vegan")


Australian_Samples_4bpOTU_noNA<-read.csv("E:/0_Master_Thesis/R_test/Final_R/Mantel/table/Australian_Samples_4bpOTU.csv", sep=",",  header = TRUE, quote = "")

museum_code.dists <- dist(cbind(Australian_Samples_4bpOTU_noNA$longitude, Australian_Samples_4bpOTU_noNA$latitude))
Australian_Samples_4bpOTU_noNA.dists <- dist(Australian_Samples_4bpOTU_noNA$OTU)
as.matrix(museum_code.dists)
as.matrix(Australian_Samples_4bpOTU_noNA.dists)

dist.jaccard = vegdist(Australian_Samples_4bpOTU_noNA.dists, method="jaccard", binary=TRUE, na.rm = FALSE)

geo = data.frame(Australian_Samples_4bpOTU_noNA$longitude, Australian_Samples_4bpOTU_noNA$latitude)

d.geo = distm(geo, fun = distHaversine)
dist.geo = as.dist(d.geo)

jaccard_geo_4bp  = mantel(Australian_Samples_4bpOTU_noNA.dists, dist.geo, method = "spearman", permutations = 5000, na.rm = TRUE)

