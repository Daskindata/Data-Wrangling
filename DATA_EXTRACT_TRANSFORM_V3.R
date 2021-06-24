install.packages('tidyr')
install.packages('dplyr')
#install.packages('janitor')
library(dplyr)
library(tidyr)
install.packages("writexl")
library(writexl)
install.packages("openxlsx")
library(openxlsx)
install.packages("trim")

### Don't forget to save each csv file first
###################################################################################
#1 No filter
# Import the data 
df <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/1_no_filter.csv', sep = ",", header=TRUE)
#df <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/1_no_filter.csv', sep= ",", header=TRUE)
#summary(df)
#df <- trimws(df, which = c("both"))
#trimws(df)

# remove index header row, duplications and columns with % 
names(df) <- df[1,]
df <- df[-1,]
df <- df[,!duplicated(colnames(df))]
df_sub <- select(df, -contains("%"))

#transpose data
df_transpose <- as.data.frame(t(as.matrix(df_sub)), header = TRUE)
#df_transpose
names(df_transpose) <- df_transpose[1,]
df_transpose <- df_transpose[-1,]

#Change row name to first column  
library(tidyr)
df2<-tibble::rownames_to_column(df_transpose, "Measure")
#df2 <- trimws(df2$Measure, which = c("both"))


#Add additional columns 
df3 <- cbind('Filtered By' = "No filters applied", df2)
df3 <- cbind('Audit Month' = seq(from = as.Date("2021-05-01"), to = as.Date("2021-05-01"),by = 'day'), df3)
#df3 <- cbind('Generated On' = seq(from = as.Date("2020-10-27"), to = as.Date("2020-10-27"),by = 'day'), df3)
df3 <- cbind('Generated On' = Sys.Date(), df3)
df3$Measure <- trimws(df3$Measure, which = c("both"))
write.csv(df3,"C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/Practice Report Data/1_05_no_filter_T.csv", row.names = FALSE)


##############################################################################################
#2 Active patients

# Import the data 
df <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/2_active.csv', sep= ",", header=TRUE)
#trimws(df)
# remove index header row, duplications and columns with % 
names(df) <- df[1,]
df <- df[-1,]
df <- df[, !duplicated(colnames(df))]
df_sub <- select(df, -contains("%"))

#transpose data
df_transpose <- as.data.frame(t(as.matrix(df_sub)), header = TRUE)
#df_transpose
names(df_transpose) <- df_transpose[1,]
df_transpose <- df_transpose[-1,]

#Change row name to first column  
library(tidyr)
df2 <-tibble::rownames_to_column(df_transpose, "Measure")

#Add additional columns 
df3 <- cbind('Filtered By' = "Active Patients", df2)
df3 <- cbind('Audit Month' = seq(from = as.Date("2021-05-01"), to = as.Date("2021-05-01"),by = 'day'), df3)
#df3 <- cbind('Generated On' = seq(from = as.Date("2020-10-27"), to = as.Date("2020-10-27"),by = 'day'), df3)
df3 <- cbind('Generated On' = Sys.Date(), df3)
df3$Measure <- trimws(df3$Measure, which = c("both"))
write.csv(df3,"C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/Practice Report Data/2_05_active_T.csv", row.names = FALSE)

###############################################################################################
#3 Active Patients, Conditions: (Diabetes - YES), Last Results: <= 12 mths

# Import the data 
df <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/3_diabetes12m.csv', sep =",", header=TRUE)
#df <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/3_diabetes12m.csv', sep =",", header=TRUE)
#trimws(df)
# remove index header row, duplications and columns with % 
names(df) <- df[1,]
df <- df[-1,]
df <- df[, !duplicated(colnames(df))]
df_sub <- select(df, -contains("%"))

#transpose data
df_transpose <- as.data.frame(t(as.matrix(df_sub)), header = TRUE)
#df_transpose
names(df_transpose) <- df_transpose[1,]
df_transpose <- df_transpose[-1,]

#Change row name to first column  
library(tidyr)
df2<-tibble::rownames_to_column(df_transpose, "Measure")

#Add additional columns 
df3 <- cbind('Filtered By' = "Active Patients Conditions: (Diabetes - YES) Last Results: <= 12 mths", df2)
df3 <- cbind('Audit Month' = seq(from = as.Date("2021-05-01"), to = as.Date("2021-05-01"),by = 'day'), df3)
#df3 <- cbind('Generated On' = seq(from = as.Date("2020-10-27"), to = as.Date("2020-10-27"),by = 'day'), df3)
df3 <- cbind('Generated On' = Sys.Date(), df3)
df3$Measure <- trimws(df3$Measure, which = c("both"))
write.csv(df3,"C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/Practice Report Data/3_05_diabetes12m_T.csv", row.names = FALSE)

##############################################################################################
#4 Active Patients, Indigenous

# Import the data 
df <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/4_indigenous.csv', sep= ",", header=TRUE)
#trimws(df)
# remove index header row, duplications and columns with % 
names(df) <- df[1,]
df <- df[-1,]
df <- df[, !duplicated(colnames(df))]
df_sub <- select(df, -contains("%"))

#transpose data
df_transpose <- as.data.frame(t(as.matrix(df_sub)), header = TRUE)
#df_transpose
names(df_transpose) <- df_transpose[1,]
df_transpose <- df_transpose[-1,]

#Change row name to first column  
library(tidyr)
df2<-tibble::rownames_to_column(df_transpose, "Measure")

#Add additional columns 
df3 <- cbind('Filtered By' = "Active Patients Indigenous", df2)
df3 <- cbind('Audit Month' = seq(from = as.Date("2021-05-01"), to = as.Date("2021-05-01"),by = 'day'), df3)
#df3 <- cbind('Generated On' = seq(from = as.Date("2020-10-27"), to = as.Date("2020-10-27"),by = 'day'), df3)
df3 <- cbind('Generated On' = Sys.Date(), df3)
df3$Measure <- trimws(df3$Measure, which = c("both"))
write.csv(df3,"C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/Practice Report Data/4_05_indigenous_T.csv", row.names = FALSE)

###########################################################################################
#5 Active Patients, Conditions: (CVD - YES)

# Import the data 
df <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/5_CVD.csv', sep= ",", header=TRUE)
#trimws(df)
# remove index header row, duplications and columns with % 
names(df) <- df[1,]
df <- df[-1,]
df <- df[, !duplicated(colnames(df))]
df_sub <- select(df, -contains("%"))

#transpose data
df_transpose <- as.data.frame(t(as.matrix(df_sub)), header = TRUE)
#df_transpose
names(df_transpose) <- df_transpose[1,]
df_transpose <- df_transpose[-1,]

#Change row name to first column  
library(tidyr)
df2<-tibble::rownames_to_column(df_transpose, "Measure")

#Add additional columns 
df3 <- cbind('Filtered By' = "Active Patients Conditions: (CVD - YES)", df2)
df3 <- cbind('Audit Month' = seq(from = as.Date("2021-05-01"), to = as.Date("2021-05-01"),by = 'day'), df3)
#df3 <- cbind('Generated On' = seq(from = as.Date("2020-10-27"), to = as.Date("2020-10-27"),by = 'day'), df3)
df3 <- cbind('Generated On' = Sys.Date(), df3)
df3$Measure <- trimws(df3$Measure, which = c("both"))
write.csv(df3,"C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/Practice Report Data/5_05_CVD_T.csv", row.names = FALSE)

##########################################################################################
#6 Active Patients, Last Results: <= 12 mths

# Import the data 
df <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/6_less_12mths.csv', sep= ",", header=TRUE)
#trimws(df)
# remove index header row, duplications and columns with % 
names(df) <- df[1,]
df <- df[-1,]
df <- df[, !duplicated(colnames(df))]
df_sub <- select(df, -contains("%"))

#transpose data
df_transpose <- as.data.frame(t(as.matrix(df_sub)), header = TRUE)
#df_transpose
names(df_transpose) <- df_transpose[1,]
df_transpose <- df_transpose[-1,]

#Change row name to first column  
library(tidyr)
df2<-tibble::rownames_to_column(df_transpose, "Measure")

#Add additional columns 
df3 <- cbind('Filtered By' = "Active Patients Last Results: <= 12 mths", df2)
df3 <- cbind('Audit Month' = seq(from = as.Date("2021-05-01"), to = as.Date("2021-05-01"),by = 'day'), df3)
#df3 <- cbind('Generated On' = seq(from = as.Date("2020-10-27"), to = as.Date("2020-10-27"),by = 'day'), df3)
df3 <- cbind('Generated On' = Sys.Date(), df3)
df3$Measure <- trimws(df3$Measure, which = c("both"))
write.csv(df3,"C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/Practice Report Data/6_05_12mths_T.csv", row.names = FALSE)

########################################################################################
#7 Active Patients, Non-Indigenous

# Import the data 
df <- read.csv("C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/7_non_indigenous.csv", sep = ",", header=TRUE)
#trimws(df)
# remove index header row, duplications and columns with % 
names(df) <- df[1,]
df <- df[-1,]
df <- df[, !duplicated(colnames(df))]
df_sub <- select(df, -contains("%"))

#transpose data
df_transpose <- as.data.frame(t(as.matrix(df_sub)), header = TRUE)
#df_transpose
names(df_transpose) <- df_transpose[1,]
df_transpose <- df_transpose[-1,]

#Change row name to first column  
library(tidyr)
df2<-tibble::rownames_to_column(df_transpose, "Measure")

#Add additional columns 
df3 <- cbind('Filtered By' = "Active Patients Non-Indigenous", df2)
df3 <- cbind('Audit Month' = seq(from = as.Date("2021-05-01"), to = as.Date("2021-05-01"),by = 'day'), df3)
#df3 <- cbind('Generated On' = seq(from = as.Date("2020-10-27"), to = as.Date("2020-10-27"),by = 'day'), df3)
df3 <- cbind('Generated On' = Sys.Date(), df3)
df3$Measure <- trimws(df3$Measure, which = c("both"))
write.csv(df3,"C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/Practice Report Data/7_05_non_indigenous_T.csv", row.names = FALSE)

#################################################################################
#8 Active Patients, Conditions: (Diabetes - YES)

# Import the data 
df <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/8_diabetes.csv', sep= ",", header=TRUE)
#trimws(df)
# remove index header row, duplications and columns with % 
names(df) <- df[1,]
df <- df[-1,]
df <- df[, !duplicated(colnames(df))]
df_sub <- select(df, -contains("%"))

#transpose data
df_transpose <- as.data.frame(t(as.matrix(df_sub)), header = TRUE)
#df_transpose
names(df_transpose) <- df_transpose[1,]
df_transpose <- df_transpose[-1,]

#Change row name to first column  
library(tidyr)
df2<-tibble::rownames_to_column(df_transpose, "Measure")

#Add additional columns 
df3 <- cbind('Filtered By' = "Active Patients Conditions: (Diabetes - YES)", df2)
df3 <- cbind('Audit Month' = seq(from = as.Date("2021-05-01"), to = as.Date("2021-05-01"),by = 'day'), df3)
#df3 <- cbind('Generated On' = seq(from = as.Date("2020-10-27"), to = as.Date("2020-10-27"),by = 'day'), df3)
df3 <- cbind('Generated On' = Sys.Date(), df3)
df3$Measure <- trimws(df3$Measure, which = c("both"))
write.csv(df3,"C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/Practice Report Data/8_05_diabetes_T.csv", row.names = FALSE)

################################################################################
#9 Active Patients, Conditions: (Diabetes - NO), Medications: (Antidiabetics - YES), Last Results: <= 12 mths

# Import the data 
df <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/9_inject_oral.csv', sep= ",", header=TRUE)
#trimws(df)
# remove index header row, duplications and columns with % 
names(df) <- df[1,]
df <- df[-1,]
df <- df[, !duplicated(colnames(df))]
df_sub <- select(df, -contains("%"))

#transpose data
df_transpose <- as.data.frame(t(as.matrix(df_sub)), header = TRUE)
#df_transpose
names(df_transpose) <- df_transpose[1,]
df_transpose <- df_transpose[-1,]

#Change row name to first column  
library(tidyr)
df2<-tibble::rownames_to_column(df_transpose, "Measure")

#Add additional columns 
df3 <- cbind('Filtered By' = "Active Patients Conditions: (Diabetes - NO) Medications: (Antidiabetics - YES) Last Results: <= 12 mths", df2)
df3 <- cbind('Audit Month' = seq(from = as.Date("2021-05-01"), to = as.Date("2021-05-01"),by = 'day'), df3)
#df3 <- cbind('Generated On' = seq(from = as.Date("2020-10-27"), to = as.Date("2020-10-27"),by = 'day'), df3)
df3 <- cbind('Generated On' = Sys.Date(), df3)
df3$Measure <- trimws(df3$Measure, which = c("both"))
write.csv(df3,"C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/Practice Report Data/9_05_inject_oral_T.csv", row.names = FALSE)

#################################################################################
#10 Active Patients, Conditions: (Diabetes - YES), Last Results: <= 6 mths

# Import the data 
df <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/10_diabetes6m.csv', sep= ",", header = TRUE)
#trimws(df)
# remove index header row, duplications and columns with % 
names(df) <- df[1,]
df <- df[-1,]
df <- df[, !duplicated(colnames(df))]
df_sub <- select(df, -contains("%"))

#transpose data
df_transpose <- as.data.frame(t(as.matrix(df_sub)), header = TRUE)
#df_transpose
names(df_transpose) <- df_transpose[1,]
df_transpose <- df_transpose[-1,]

#Change row name to first column  
library(tidyr)
df2<-tibble::rownames_to_column(df_transpose, "Measure")

#Add additional columns 
df3 <- cbind('Filtered By' = "Active Patients Conditions: (Diabetes - YES) Last Results: <= 6 mths", df2)
df3 <- cbind('Audit Month' = seq(from = as.Date("2021-05-01"), to = as.Date("2021-05-01"),by = 'day'), df3)
#df3 <- cbind('Generated On' = seq(from = as.Date("2020-10-27"), to = as.Date("2020-10-27"),by = 'day'), df3)
df3 <- cbind('Generated On' = Sys.Date(), df3)
df3$Measure <- trimws(df3$Measure, which = c("both"))
write.csv(df3,"C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/Practice Report Data/10_05_diabetes6m_T.csv", row.names = FALSE)

#################################################################################
#11 Active Patients Conditions: (COPD - YES)

# Import the data 
df <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/11_COPD.csv', sep= ",", header=TRUE)

# remove index header row, duplications and columns with % 
names(df) <- df[1,]
df <- df[-1,]
df <- df[, !duplicated(colnames(df))]
df_sub <- select(df, -contains("%"))

#transpose data
df_transpose <- as.data.frame(t(as.matrix(df_sub)), header = TRUE)
#df_transpose
names(df_transpose) <- df_transpose[1,]
df_transpose <- df_transpose[-1,]

#Change row name to first column  
library(tidyr)
df2<-tibble::rownames_to_column(df_transpose, "Measure")

#Add additional columns 
df3 <- cbind('Filtered By' = "Active Patients Conditions: (COPD - YES)", df2)
df3 <- cbind('Audit Month' = seq(from = as.Date("2021-05-01"), to = as.Date("2021-05-01"),by = 'day'), df3)
#df3 <- cbind('Generated On' = seq(from = as.Date("2020-10-27"), to = as.Date("2020-10-27"),by = 'day'), df3)
df3 <- cbind('Generated On' = Sys.Date(), df3)
write.csv(df3,"C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/Practice Report Data/11_05_COPD_T.csv", row.names = FALSE)

###################################################################################

#12 Active Patients Conditions: (COPD - YES) Last Results: <= 12 mths

# Import the data 
df <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/12_COPD_12m.csv', sep= ",", header=TRUE)
#trimws(df)
# remove index header row, duplications and columns with % 
names(df) <- df[1,]
df <- df[-1,]
df <- df[, !duplicated(colnames(df))]
df_sub <- select(df, -contains("%"))

#transpose data
df_transpose <- as.data.frame(t(as.matrix(df_sub)), header = TRUE)
#df_transpose
names(df_transpose) <- df_transpose[1,]
df_transpose <- df_transpose[-1,]

#Change row name to first column  
library(tidyr)
df2<-tibble::rownames_to_column(df_transpose, "Measure")

#Add additional columns 
df3 <- cbind('Filtered By' = "Active Patients Conditions: (COPD - YES) Last Results: <= 12 mths", df2)
df3 <- cbind('Audit Month' = seq(from = as.Date("2021-05-01"), to = as.Date("2021-05-01"),by = 'day'), df3)
#df3 <- cbind('Generated On' = seq(from = as.Date("2020-10-27"), to = as.Date("2020-10-27"),by = 'day'), df3)
df3 <- cbind('Generated On' = Sys.Date(), df3)
df3$Measure <- trimws(df3$Measure, which = c("both"))
write.csv(df3,"C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/Practice Report Data/12_05_COPD_12m_T.csv", row.names = FALSE)


##############################################################################
#13 Age >= 45Yrs Age <= 75Yrs Active Patients

# Import the data 
df <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/13_45to75yrs.csv', sep= ",", header=TRUE)
#trimws(df)
# remove index header row, duplications and columns with % 
names(df) <- df[1,]
df <- df[-1,]
df <- df[, !duplicated(colnames(df))]
df_sub <- select(df, -contains("%"))

#transpose data
df_transpose <- as.data.frame(t(as.matrix(df_sub)), header = TRUE)
#df_transpose
names(df_transpose) <- df_transpose[1,]
df_transpose <- df_transpose[-1,]

#Change row name to first column  
library(tidyr)
df2<-tibble::rownames_to_column(df_transpose, "Measure")

#Add additional columns 
df3 <- cbind('Filtered By' = "Age >= 45Yrs Age <= 75Yrs Active Patients", df2)
df3 <- cbind('Audit Month' = seq(from = as.Date("2021-05-01"), to = as.Date("2021-05-01"),by = 'day'), df3)
#df3 <- cbind('Generated On' = seq(from = as.Date("2020-10-27"), to = as.Date("2020-10-27"),by = 'day'), df3)
df3 <- cbind('Generated On' = Sys.Date(), df3)
df3$Measure <- trimws(df3$Measure, which = c("both"))
write.csv(df3,"C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/Practice Report Data/13_05_45to75yrs_T.csv", row.names = FALSE)

#############################################################################
#14 Age >= 45Yrs Age <= 75Yrs Active Patients Last Results: <= 12 mths

# Import the data 
df <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/14_45to75yrs_12m.csv', sep= ",", header=TRUE)
#trimws(df)
# remove index header row, duplications and columns with % 
names(df) <- df[1,]
df <- df[-1,]
df <- df[, !duplicated(colnames(df))]
df_sub <- select(df, -contains("%"))

#transpose data
df_transpose <- as.data.frame(t(as.matrix(df_sub)), header = TRUE)
#df_transpose
names(df_transpose) <- df_transpose[1,]
df_transpose <- df_transpose[-1,]

#Change row name to first column  
library(tidyr)
df2<-tibble::rownames_to_column(df_transpose, "Measure")

#Add additional columns 
df3 <- cbind('Filtered By' = "Age >= 45Yrs Age <= 75Yrs Active Patients Last Results: <= 12 mths", df2)
df3 <- cbind('Audit Month' = seq(from = as.Date("2021-05-01"), to = as.Date("2021-05-01"),by = 'day'), df3)
#df3 <- cbind('Generated On' = seq(from = as.Date("2020-10-27"), to = as.Date("2020-10-27"),by = 'day'), df3)
df3 <- cbind('Generated On' = Sys.Date(), df3)
df3$Measure <- trimws(df3$Measure, which = c("both"))
write.csv(df3,"C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/Practice Report Data/14_05_45to75yrs_12m_T.csv", row.names = FALSE)

############################################################################
#15 Age >= 15Yrs Age <= 29Yrs Active Patients

# Import the data 
df <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/15_15to29yrs.csv', sep= ",", header=TRUE)
#trimws(df)
# remove index header row, duplications and columns with % 
names(df) <- df[1,]
df <- df[-1,]
df <- df[, !duplicated(colnames(df))]
df_sub <- select(df, -contains("%"))

#transpose data
df_transpose <- as.data.frame(t(as.matrix(df_sub)), header = TRUE)
#df_transpose
names(df_transpose) <- df_transpose[1,]
df_transpose <- df_transpose[-1,]

#Change row name to first column  
library(tidyr)
df2<-tibble::rownames_to_column(df_transpose, "Measure")

#Add additional columns 
df3 <- cbind('Filtered By' = "Age >= 15Yrs Age <= 29Yrs Active Patients", df2)
df3 <- cbind('Audit Month' = seq(from = as.Date("2021-05-01"), to = as.Date("2021-05-01"),by = 'day'), df3)
#df3 <- cbind('Generated On' = seq(from = as.Date("2020-10-27"), to = as.Date("2020-10-27"),by = 'day'), df3)
df3 <- cbind('Generated On' = Sys.Date(), df3)
df3$Measure <- trimws(df3$Measure, which = c("both"))
write.csv(df3,"C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/Practice Report Data/15_05_15to29yrs_T.csv", row.names = FALSE)

############################################################################
#Filtering By
#16 Active Patients _ Papa Smear

# Import the data 
df <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/16_papsmear.csv', sep= ",", header=TRUE)
#trimws(df)
# remove index header row, duplications and columns with % 
names(df) <- df[1,]
df <- df[-1,]
df <- df[, !duplicated(colnames(df))]
df_sub <- select(df, -contains("%"))

#transpose data
df_transpose <- as.data.frame(t(as.matrix(df_sub)), header = TRUE)
#df_transpose
names(df_transpose) <- df_transpose[1,]
df_transpose <- df_transpose[-1,]

#Change row name to first column  
library(tidyr)
df2<-tibble::rownames_to_column(df_transpose, "Measure")

#Add additional columns 
df3 <- cbind('Filtered By' = "Active Patients", df2)
df3 <- cbind('Audit Month' = seq(from = as.Date("2021-05-01"), to = as.Date("2021-05-01"),by = 'day'), df3)
#df3 <- cbind('Generated On' = seq(from = as.Date("2020-10-27"), to = as.Date("2020-10-27"),by = 'day'), df3)
df3 <- cbind('Generated On' = Sys.Date(), df3)
df3$Measure <- trimws(df3$Measure, which = c("both"))
write.csv(df3,"C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/Practice Report Data/16_05_papsmear_T.csv", row.names = FALSE)

##########################################################################
#17 Active Patients - Diabetes Indicators

# Import the data 
df <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/17_active_diabetes.csv', sep= ",", header=TRUE)
#trimws(df)
# remove index header row, duplications and columns with % 
names(df) <- df[1,]
df <- df[-1,]
df <- df[, !duplicated(colnames(df))]
df_sub <- select(df, -contains("%"))

#transpose data
df_transpose <- as.data.frame(t(as.matrix(df_sub)), header = TRUE)
#df_transpose
names(df_transpose) <- df_transpose[1,]
df_transpose <- df_transpose[-1,]

#Change row name to first column  
library(tidyr)
df2<-tibble::rownames_to_column(df_transpose, "Measure")

#Add additional columns 
df3 <- cbind('Filtered By' = "Active Patients", df2)
df3 <- cbind('Audit Month' = seq(from = as.Date("2021-05-01"), to = as.Date("2021-05-01"),by = 'day'), df3)
#df3 <- cbind('Generated On' = seq(from = as.Date("2020-10-27"), to = as.Date("2020-10-27"),by = 'day'), df3)
df3 <- cbind('Generated On' = Sys.Date(), df3)
df3$Measure <- trimws(df3$Measure, which = c("both"))
write.csv(df3,"C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/Practice Report Data/17_05_active_diabetes_T.csv", row.names = FALSE)

#########################################################################
#18 Age >= 65Yrs, Active Patients, Non-Indigenous/Not Recorded, Conditions: (Diabetes - YES) _ Data Quality

# Import the data 
df <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/18_65_nonindig_notrecord_diabetes.csv', sep= ",", header=TRUE)
#trimws(df)
# remove index header row, duplications and columns with % 
names(df) <- df[1,]
df <- df[-1,]
df <- df[, !duplicated(colnames(df))]
df_sub <- select(df, -contains("%"))

#transpose data
df_transpose <- as.data.frame(t(as.matrix(df_sub)), header = TRUE)
#df_transpose
names(df_transpose) <- df_transpose[1,]
df_transpose <- df_transpose[-1,]

#Change row name to first column  
library(tidyr)
df2<-tibble::rownames_to_column(df_transpose, "Measure")

#Add additional columns 
df3 <- cbind('Filtered By' = "Age >= 65Yrs Active Patients Non-Indigenous/Not Recorded Conditions: (Diabetes - YES)", df2)
df3 <- cbind('Audit Month' = seq(from = as.Date("2021-05-01"), to = as.Date("2021-05-01"),by = 'day'), df3)
#df3 <- cbind('Generated On' = seq(from = as.Date("2020-10-27"), to = as.Date("2020-10-27"),by = 'day'), df3)
df3 <- cbind('Generated On' = Sys.Date(), df3)
df3$Measure <- trimws(df3$Measure, which = c("both"))
write.csv(df3,"C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/Practice Report Data/18_05_65_nonindig_notrecord_diabetes_T.csv", row.names = FALSE)

#######################################################################
#19 Age >= 45Yrs, Active Patients, Indigenous, Conditions: (Diabetes - YES)_ Data Quality

# Import the data 
df <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/19_45_indig_diabetes.csv', sep= ",", header=TRUE)
#trimws(df)
# remove index header row, duplications and columns with % 
names(df) <- df[1,]
df <- df[-1,]
df <- df[, !duplicated(colnames(df))]
df_sub <- select(df, -contains("%"))

#transpose data
df_transpose <- as.data.frame(t(as.matrix(df_sub)), header = TRUE)
#df_transpose
names(df_transpose) <- df_transpose[1,]
df_transpose <- df_transpose[-1,]

#Change row name to first column  
library(tidyr)
df2<-tibble::rownames_to_column(df_transpose, "Measure")

#Add additional columns 
df3 <- cbind('Filtered By' = "Age >= 45Yrs Active Patients Indigenous Conditions: (Diabetes - YES)", df2)
df3 <- cbind('Audit Month' = seq(from = as.Date("2021-05-01"), to = as.Date("2021-05-01"),by = 'day'), df3)
#df3 <- cbind('Generated On' = seq(from = as.Date("2020-10-27"), to = as.Date("2020-10-27"),by = 'day'), df3)
df3 <- cbind('Generated On' = Sys.Date(), df3)
df3$Measure <- trimws(df3$Measure, which = c("both"))
write.csv(df3,"C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/Practice Report Data/19_05_45_indig_diabetes_T.csv", row.names = FALSE)


#######################################################################
#20 Age >= 75Yrs, Active Patients, Non-Indigenous/Not Recorded, Conditions: (Diabetes - YES)_ Data Quality

# Import the data 
df <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/20_75_nonidig_notrecord_diabetes.csv', sep= ",", header=TRUE)
#trimws(df)
# remove index header row, duplications and columns with % 
names(df) <- df[1,]
df <- df[-1,]
df <- df[, !duplicated(colnames(df))]
df_sub <- select(df, -contains("%"))

#transpose data
df_transpose <- as.data.frame(t(as.matrix(df_sub)), header = TRUE)
#df_transpose
names(df_transpose) <- df_transpose[1,]
df_transpose <- df_transpose[-1,]

#Change row name to first column  
library(tidyr)
df2<-tibble::rownames_to_column(df_transpose, "Measure")

#Add additional columns 
df3 <- cbind('Filtered By' = "Age >= 75Yrs Active Patients Non-Indigenous/Not Recorded Conditions: (Diabetes - YES)", df2)
df3 <- cbind('Audit Month' = seq(from = as.Date("2021-05-01"), to = as.Date("2021-05-01"),by = 'day'), df3)
#df3 <- cbind('Generated On' = seq(from = as.Date("2020-10-27"), to = as.Date("2020-10-27"),by = 'day'), df3)
df3 <- cbind('Generated On' = Sys.Date(), df3)
df3$Measure <- trimws(df3$Measure, which = c("both"))
write.csv(df3,"C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/Practice Report Data/20_05_75_nonidig_notrecord_diabetes_T.csv", row.names = FALSE)

#######################################################################
#21 Age >= 65Yrs, Active Patients, Indigenous, Conditions: (Diabetes - YES)_ Data Quality

# Import the data 
df <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/21_65_indig_diabetes.csv', sep= ",", header=TRUE)
#trimws(df)
# remove index header row, duplications and columns with % 
names(df) <- df[1,]
df <- df[-1,]
df <- df[, !duplicated(colnames(df))]
df_sub <- select(df, -contains("%"))

#transpose data
df_transpose <- as.data.frame(t(as.matrix(df_sub)), header = TRUE)
#df_transpose
names(df_transpose) <- df_transpose[1,]
df_transpose <- df_transpose[-1,]

#Change row name to first column  
library(tidyr)
df2<-tibble::rownames_to_column(df_transpose, "Measure")

#Add additional columns 
df3 <- cbind('Filtered By' = "Age >= 65Yrs Active Patients Indigenous Conditions: (Diabetes - YES)", df2)
df3 <- cbind('Audit Month' = seq(from = as.Date("2021-05-01"), to = as.Date("2021-05-01"),by = 'day'), df3)
#df3 <- cbind('Generated On' = seq(from = as.Date("2020-10-27"), to = as.Date("2020-10-27"),by = 'day'), df3)
df3 <- cbind('Generated On' = Sys.Date(), df3)
df3$Measure <- trimws(df3$Measure, which = c("both"))
write.csv(df3,"C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/Practice Report Data/21_05_65_indig_diabetes_T.csv", row.names = FALSE)


#######################################################################

