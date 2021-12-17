getwd()
setwd("C:/Temp/Rwork/dataset1/dataset1")
getwd()

# 이순규
#1.
data("CO2")
data
data.frame(CO2)

#1)
CO2
co3 <- subset(CO2, Treatment == "nonchilled")
co3
write.csv(co3, "CO2_df1.csv", row.names = F)
co4 <- read.csv(file = "CO2_df1.csv", sep = ",", header = F)
co4

#2)
CO2
co5 <- subset(CO2, Treatment == "chilled")
co5
write.csv(co5, "CO2_df2.csv", row.names = F)
co6 <- read.csv(file = "CO2_df2.csv", sep = ",", header = F)
co6

#2.

#1)
titanicData <- read.csv(file = 'titanic.txt', sep = ',', na.strings = '-')
titanicData

str(titanicData)

#2)
head(titanicData[-1,-3], 6)
# head(titanicData, -c(1,3), 6)
