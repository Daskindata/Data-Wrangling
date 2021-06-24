#install.packages("dplyr")                                         # Install dplyr package
install.packages("plyr")                                          # Install plyr package
install.packages("readr")                                         # Install readr package

#library("dplyr")                                                  # Load dplyr package
library("plyr")                                                   # Load plyr package
library("readr") 

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
df <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/1_DIAB_ALL_HCH_04_19.csv', sep = ",", header=TRUE)
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
#df3 <- cbind('Filtered By' = "No filters applied", df2)
#df3 <- cbind('Audit Month' = seq(from = as.Date("2021-04-01"), to = as.Date("2021-04-01"),by = 'day'), df3)
#df3 <- cbind('Generated On' = seq(from = as.Date("2020-10-27"), to = as.Date("2020-10-27"),by = 'day'), df3)
#df3 <- cbind('Generated On' = Sys.Date(), df3)
df2$Measure <- trimws(df2$Measure, which = c("both"))
df3 <- df2[order(df2$Measure),]
df3 <- cbind('Audit Month' = "Apr 2019", df3)
df3 <- cbind('Group' = "", df3)
df3 <- df3 %>% relocate('Audit Month', .after = Measure)
df3 <- df3 %>% relocate(Group, .after = 'Audit Month')
#df3 <- cbind('Group' = "", df2)
#df3 <- cbind('Audit Period' = "Apr-2019", df2)
#df3 <- df3 %>% relocate(Group, .after = Measure)

df3 <- df3[-c(1:7, 13:14,20,25, 31:43), ] 
vec <- c(3.1, 2, 1, 1, 3, 3.1, 3, 2, 2, 2, 3, 1, 1, 3.1, 3.1, 1, 1, 1, 3.1)
df3$Group <- vec

library(dplyr)
df4 <- df3 %>% select(1, 2, 3, 159, 180)

df4 <- df4 %>%
  rename(
    'Total CD' = 'Total patients with one or more chronic diseases',
    'Indigenous' = 'Total Indigenous patients'
    )

write.csv(df4,"C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/HCH_Compare/DIAB_0419.csv", row.names = FALSE)


##############################################################################################
#2 Active patients

# Import the data 
df <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/2_MBS_ALL_HCH_Less12mths_04_19.csv', sep= ",", header=TRUE)
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
#df3 <- cbind('Filtered By' = "Active Patients", df2)
#df3 <- cbind('Audit Month' = seq(from = as.Date("2021-04-01"), to = as.Date("2021-04-01"),by = 'day'), df3)
#df3 <- cbind('Generated On' = seq(from = as.Date("2020-10-27"), to = as.Date("2020-10-27"),by = 'day'), df3)
#df3 <- cbind('Generated On' = Sys.Date(), df3)
df2$Measure <- trimws(df2$Measure, which = c("both"))
df3 <- df2[order(df2$Measure),]
df3 <- cbind('Audit Month' = "Apr 2019", df3)
df3 <- cbind('Group' = "", df3)
df3 <- df3 %>% relocate('Audit Month', .after = Measure)
df3 <- df3 %>% relocate(Group, .after = 'Audit Month')
#df3 <- cbind('Audit Period' = "Apr-2019", df2)
#df3 <- cbind('Group' = "", df2)
#df3 <- df3 %>% relocate(Group, .after = Measure)
df3 <- df3[-c(1:7, 13:14,20,25, 31:43), ]
vec <- c(3.1, 2, 1, 1, 3, 3.1, 3, 2, 2, 2, 3, 1, 1, 3.1, 3.1, 1, 1, 1, 3.1)
df3$Group <- vec

library(dplyr)
df4 <- df3 %>% select(1, 2, 3, 5, 6, 9:14)

write.csv(df4,"C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/HCH_Compare/MBS_0419.csv", row.names = FALSE)

###############################################################################################
#3 Active Patients, Conditions: (Diabetes - YES), Last Results: <= 12 mths

# Import the data 
df <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/3_MBS_ALL_HCH_MH_Less12mths_04_19.csv', sep =",", header=TRUE)
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
#df3 <- cbind('Filtered By' = "Active Patients Conditions: (Diabetes - YES) Last Results: <= 12 mths", df2)
#df3 <- cbind('Audit Month' = seq(from = as.Date("2021-04-01"), to = as.Date("2021-04-01"),by = 'day'), df3)
#df3 <- cbind('Generated On' = seq(from = as.Date("2020-10-27"), to = as.Date("2020-10-27"),by = 'day'), df3)
#df3 <- cbind('Generated On' = Sys.Date(), df3)
df2$Measure <- trimws(df2$Measure, which = c("both"))
df3 <- df2[order(df2$Measure),]
df3 <- cbind('Audit Month' = "Apr 2019", df3)
df3 <- cbind('Group' = "", df3)
df3 <- df3 %>% relocate('Audit Month', .after = Measure)
df3 <- df3 %>% relocate(Group, .after = 'Audit Month')
#df3 <- cbind('Audit Period' = "Apr-2019", df2)
#df3 <- cbind('Group' = "", df2)
#df3 <- df3 %>% relocate(Group, .after = Measure)
df3 <- df3[-c(1:7, 13:14,20,25, 31:43), ]
vec <- c(3.1, 2, 1, 1, 3, 3.1, 3, 2, 2, 2, 3, 1, 1, 3.1, 3.1, 1, 1, 1, 3.1)
df3$Group <- vec

library(dplyr)
df4 <- df3 %>% select(1, 2, 3, 4, 19, 20)

write.csv(df4,"C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/HCH_Compare/MBS_MH_0419.csv", row.names = FALSE)

##############################################################################################
#4 Active Patients, Indigenous

# Import the data 
df <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/4_PDQ_ALL_HCH_04_19.csv', sep= ",", header=TRUE)
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
#df3 <- cbind('Filtered By' = "Active Patients Indigenous", df2)
#df3 <- cbind('Audit Month' = seq(from = as.Date("2021-04-01"), to = as.Date("2021-04-01"),by = 'day'), df3)
#df3 <- cbind('Generated On' = seq(from = as.Date("2020-10-27"), to = as.Date("2020-10-27"),by = 'day'), df3)
#df3 <- cbind('Generated On' = Sys.Date(), df3)
df2$Measure <- trimws(df2$Measure, which = c("both"))
df3 <- df2[order(df2$Measure),]
df3 <- cbind('Audit Month' = "Apr 2019", df3)
df3 <- cbind('Group' = "", df3)
df3 <- df3 %>% relocate('Audit Month', .after = Measure)
df3 <- df3 %>% relocate(Group, .after = 'Audit Month')
#df3 <- cbind('Audit Period' = "Apr-2019", df2)
#df3 <- cbind('Group' = "", df2)
#df3 <- df3 %>% relocate(Group, .after = Measure)
df3 <- df3[-c(1:7, 13:14,20,25, 31:43), ]
vec <- c(3.1, 2, 1, 1, 3, 3.1, 3, 2, 2, 2, 3, 1, 1, 3.1, 3.1, 1, 1, 1, 3.1)
df3$Group <- vec

library(dplyr)
df4 <- df3 %>% select(1, 2, 3, 4, 46, 47)

write.csv(df4,"C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/HCH_Compare/PDQ_0419.csv", row.names = FALSE)

###########################################################################################
#5 Active Patients, Conditions: (CVD - YES)

# Import the data 
df <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/5_DIAB_ALL_HCH_04_20.csv', sep= ",", header=TRUE)
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
#df3 <- cbind('Filtered By' = "Active Patients Conditions: (CVD - YES)", df2)
#df3 <- cbind('Audit Month' = seq(from = as.Date("2021-04-01"), to = as.Date("2021-04-01"),by = 'day'), df3)
#df3 <- cbind('Generated On' = seq(from = as.Date("2020-10-27"), to = as.Date("2020-10-27"),by = 'day'), df3)
#df3 <- cbind('Generated On' = Sys.Date(), df3)
df2$Measure <- trimws(df2$Measure, which = c("both"))
df3 <- df2[order(df2$Measure),]
df3 <- cbind('Audit Month' = "Apr 2020", df3)
df3 <- cbind('Group' = "", df3)
df3 <- df3 %>% relocate('Audit Month', .after = Measure)
df3 <- df3 %>% relocate(Group, .after = 'Audit Month')
#df3 <- cbind('Audit Period' = "Apr-2020", df2)
#df3 <- cbind('Group' = "", df2)
#df3 <- df3 %>% relocate(Group, .after = Measure)
df3 <- df3[-c(1:7, 13:14,20,25, 31:43), ]
vec <- c(3.1, 2, 1, 1, 3, 3.1, 3, 2, 2, 2, 3, 1, 1, 3.1, 3.1, 1, 1, 1, 3.1)
df3$Group <- vec
library(dplyr)
df4 <- df3 %>% select(1, 2, 3, 159, 180)

df4 <- df4 %>%
  rename(
    'Total CD' = 'Total patients with one or more chronic diseases',
    'Indigenous' = 'Total Indigenous patients'
  )

write.csv(df4,"C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/HCH_Compare/DIAB_0420.csv", row.names = FALSE)

##########################################################################################
#6 Active Patients, MBS Last Results: <= 12 mths

# Import the data 
df <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/6_MBS_ALL_HCH_Less12mths_04_20.csv', sep= ",", header=TRUE)

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
df2$Measure <- trimws(df2$Measure, which = c("both"))
df3 <- df2[order(df2$Measure),]
df3 <- cbind('Audit Month' = "Apr 2020", df3)
df3 <- cbind('Group' = "", df3)
df3 <- df3 %>% relocate('Audit Month', .after = Measure)
df3 <- df3 %>% relocate(Group, .after = 'Audit Month')
#Remove rows not required
df3 <- df3[-c(1:7, 13:14,20,25, 31:43), ]

#Add HCH Gruop ID
vec <- c(3.1, 2, 1, 1, 3, 3.1, 3, 2, 2, 2, 3, 1, 1, 3.1, 3.1, 1, 1, 1, 3.1)
df3$Group <- vec
#Select required columns
library(dplyr)
df4 <- df3 %>% select(1, 2, 3, 5, 6, 9:14)

#create CSV file
write.csv(df4,"C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/HCH_Compare/MBS_0420.csv", row.names = FALSE)

########################################################################################
#7 Active Patients, Non-Indigenous

# Import the data 
df <- read.csv("C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/7_MBS_ALL_HCH_MH_Less12mths_04_20.csv", sep = ",", header=TRUE)
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
#df3 <- cbind('Filtered By' = "Active Patients Non-Indigenous", df2)
#df3 <- cbind('Audit Month' = seq(from = as.Date("2021-04-01"), to = as.Date("2021-04-01"),by = 'day'), df3)
#df3 <- cbind('Generated On' = seq(from = as.Date("2020-10-27"), to = as.Date("2020-10-27"),by = 'day'), df3)
#df3 <- cbind('Generated On' = Sys.Date(), df3)
df2$Measure <- trimws(df2$Measure, which = c("both"))
df3 <- df2[order(df2$Measure),]
df3 <- cbind('Audit Month' = "Apr 2020", df3)
df3 <- cbind('Group' = "", df3)
df3 <- df3 %>% relocate('Audit Month', .after = Measure)
df3 <- df3 %>% relocate(Group, .after = 'Audit Month')
#df3 <- cbind('Audit Period' = "Apr-2020", df2)
#df3 <- cbind('Group' = "", df2)
#df3 <- df3 %>% relocate(Group, .after = Measure)
df3 <- df3[-c(1:7, 13:14,20,25, 31:43), ]
vec <- c(3.1, 2, 1, 1, 3, 3.1, 3, 2, 2, 2, 3, 1, 1, 3.1, 3.1, 1, 1, 1, 3.1)
df3$Group <- vec

library(dplyr)
df4 <- df3 %>% select(1, 2, 3, 4, 19, 20)

write.csv(df4,"C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/HCH_Compare/MBS_MH_0420.csv", row.names = FALSE)

#################################################################################
#8 Active Patients, Conditions: (Diabetes - YES)

# Import the data 
df <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/8_PDQ_ALL_HCH_04_20.csv', sep= ",", header=TRUE)
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
#df3 <- cbind('Filtered By' = "Active Patients Conditions: (Diabetes - YES)", df2)
#df3 <- cbind('Audit Month' = seq(from = as.Date("2020-04-01"), to = as.Date("2020-04-01"),by = 'day'), df2)
#df3 <- cbind('Generated On' = seq(from = as.Date("2020-10-27"), to = as.Date("2020-10-27"),by = 'day'), df3)
#df3 <- cbind('Generated On' = Sys.Date(), df3)
df2$Measure <- trimws(df2$Measure, which = c("both"))
df3 <- df2[order(df2$Measure),]
#df3 <- cbind('Audit Month' = seq(from = as.Date("2020-04-01"), to = as.Date("2020-04-01"),by = 'day'), df2)
#df3 <- cbind('Audit Month' = "Apr-2020", df2)
df3 <- cbind('Audit Month' = "Apr 2020", df3)
df3 <- cbind('Group' = "", df3)
df3 <- df3 %>% relocate('Audit Month', .after = Measure)
df3 <- df3 %>% relocate(Group, .after = 'Audit Month')
df3 <- df3[-c(1:7, 13:14,20,25, 31:43), ]
vec <- c(3.1, 2, 1, 1, 3, 3.1, 3, 2, 2, 2, 3, 1, 1, 3.1, 3.1, 1, 1, 1, 3.1)
df3$Group <- vec

library(dplyr)
df4 <- df3 %>% select(1, 2, 3, 4, 46, 47)

write.csv(df4,"C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/HCH_Compare/PDQ_0420.csv", row.names = FALSE)

################################################################################
#9 Active Patients, Conditions: (Diabetes - NO), Medications: (Antidiabetics - YES), Last Results: <= 12 mths

# Import the data 
df <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/9_DIAB_ALL_HCH_04_21.csv', sep= ",", header=TRUE)
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
#df3 <- cbind('Filtered By' = "Active Patient Conditions: (Diabetes - NO) Medications: (Antidiabetics - YES) Last Results: <= 12 mths", df2)
#df3 <- cbind('Audit Month' = seq(from = as.Date("2021-04-01"), to = as.Date("2021-04-01"),by = 'day'), df3)
#df3 <- cbind('Generated On' = seq(from = as.Date("2020-10-27"), to = as.Date("2020-10-27"),by = 'day'), df3)
#df3 <- cbind('Generated On' = Sys.Date(), df3)
df2$Measure <- trimws(df2$Measure, which = c("both"))
df3 <- df2[order(df2$Measure),]
df3 <- cbind('Audit Month' = "Apr 2021", df3)
df3 <- cbind('Group' = "", df3)
df3 <- df3 %>% relocate('Audit Month', .after = Measure)
df3 <- df3 %>% relocate(Group, .after = 'Audit Month')
#df3 <- cbind('Audit Period' = "Apr-2021", df2)
#df3 <- cbind('Group' = "", df2)
#df3 <- df3 %>% relocate(Group, .after = Measure)
df3 <- df3[-c(1:7, 13:14,20,25, 31:43), ]
vec <- c(3.1, 2, 1, 1, 3, 3.1, 3, 2, 2, 2, 3, 1, 1, 3.1, 3.1, 1, 1, 1, 3.1)
df3$Group <- vec
library(dplyr)
df4 <- df3 %>% select(1, 2, 3, 159, 180)

write.csv(df4,"C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/HCH_Compare/DIAB_0421.csv", row.names = FALSE)

#################################################################################
#10 Active Patients, Conditions: (Diabetes - YES), Last Results: <= 6 mths

# Import the data 
df <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/10_MBS_ALL_HCH_Less12mths_04_21.csv', sep= ",", header = TRUE)
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
#df3 <- cbind('Filtered By' = "Active Patients Conditions: (Diabetes - YES) Last Results: <= 6 mths", df2)
#df3 <- cbind('Audit Month' = seq(from = as.Date("2021-04-01"), to = as.Date("2021-04-01"),by = 'day'), df3)
#df3 <- cbind('Generated On' = seq(from = as.Date("2020-10-27"), to = as.Date("2020-10-27"),by = 'day'), df3)
#df3 <- cbind('Generated On' = Sys.Date(), df3)
df2$Measure <- trimws(df2$Measure, which = c("both"))
df3 <- df2[order(df2$Measure),]
df3 <- df3 <- cbind('Audit Month' = "Apr 2021", df3)
df3 <- cbind('Group' = "", df3)
df3 <- df3 %>% relocate('Audit Month', .after = Measure)
df3 <- df3 %>% relocate(Group, .after = 'Audit Month') 

#df3 <- cbind('Audit Period' = "Apr-2021", df2)
#df3 <- cbind('Group' = "", df2)
#df3 <- df3 %>% relocate(Group, .after = Measure)
df3 <- df3[-c(1:7, 13:14,20,25, 31:43), ]
vec <- c(3.1, 2, 1, 1, 3, 3.1, 3, 2, 2, 2, 3, 1, 1, 3.1, 3.1, 1, 1, 1, 3.1)
df3$Group <- vec
library(dplyr)
df4 <- df3 %>% select(1, 2, 3, 5, 6, 9:14)

write.csv(df4,"C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/HCH_Compare/MBS_0421.csv", row.names = FALSE)

#################################################################################
#11 Active Patients Conditions: (COPD - YES)

# Import the data 
df <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/11_MBS_ALL_HCH_MH_Less12mths_04_21.csv', sep= ",", header=TRUE)

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
#df3 <- cbind('Filtered By' = "Active Patients Conditions: (COPD - YES)", df2)
#df3 <- cbind('Audit Month' = seq(from = as.Date("2021-04-01"), to = as.Date("2021-04-01"),by = 'day'), df3)
#df3 <- cbind('Generated On' = seq(from = as.Date("2020-10-27"), to = as.Date("2020-10-27"),by = 'day'), df3)
#df3 <- cbind('Generated On' = Sys.Date(), df3)
df2$Measure <- trimws(df2$Measure, which = c("both"))
df3 <- df2[order(df2$Measure),]
df3 <- df3 <- cbind('Audit Month' = "Apr 2021", df3)
df3 <- cbind('Group' = "", df3)
#df3 <- df3[-c(1:7, 13:14,20,25, 31:43), ]
#vec <- c(3.1, 2, 1, 1, 3, 3.1, 3, 2, 2, 2, 3, 1, 1, 3.1, 3.1, 1, 1, 1, 3.1)
#df3$Group <- vec
df3 <- df3 %>% relocate('Audit Month', .after = Measure)
df3 <- df3 %>% relocate(Group, .after = 'Audit Month')

#df3 <- cbind('Audit Period' = "Apr-2021", df2)
#df3 <- cbind('Group' = "", df2)
#df3 <- df3 %>% relocate(Group, .after = Measure)
df3 <- df3[-c(1:7, 13:14,20,25, 31:43), ]
vec <- c(3.1, 2, 1, 1, 3, 3.1, 3, 2, 2, 2, 3, 1, 1, 3.1, 3.1, 1, 1, 1, 3.1)
df3$Group <- vec

library(dplyr)
df4 <- df3 %>% select(1, 2, 3, 4, 19, 20)

write.csv(df4,"C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/HCH_Compare/MBS_MH_0421.csv", row.names = FALSE)

###################################################################################

#12 Active Patients Conditions: (COPD - YES) Last Results: <= 12 mths

# Import the data 
df <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/12_PDQ_ALL_HCH_04_21.csv', sep= ",", header=TRUE)
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
#df3 <- cbind('Filtered By' = "Active Patients Conditions: (COPD - YES) Last Results: <= 12 mths", df2)
#df3 <- cbind('Audit Month' = seq(from = as.Date("2021-04-01"), to = as.Date("2021-04-01"),by = 'day'), df3)
#df3 <- cbind('Generated On' = seq(from = as.Date("2020-10-27"), to = as.Date("2020-10-27"),by = 'day'), df3)
#df3 <- cbind('Generated On' = Sys.Date(), df3)
df2$Measure <- trimws(df2$Measure, which = c("both"))
df3 <- df2[order(df2$Measure),]
df3 <- df3 <- cbind('Audit Month' = "Apr 2021", df3)
df3 <- cbind('Group' = "", df3)
df3 <- df3 %>% relocate('Audit Month', .after = Measure)
df3 <- df3 %>% relocate(Group, .after = 'Audit Month')
#df3 <- cbind('Audit Period' = "Apr-2021", df2)
#df3 <- cbind('Group' = "", df2)
#df3 <- df3 %>% relocate(Group, .after = Measure)
df3 <- df3[-c(1:7, 13:14,20,25, 31:43), ]
vec <- c(3.1, 2, 1, 1, 3, 3.1, 3, 2, 2, 2, 3, 1, 1, 3.1, 3.1, 1, 1, 1, 3.1)
df3$Group <- vec

library(dplyr)
df4 <- df3 %>% select(1, 2, 3, 4, 46, 47)

write.csv(df4,"C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/HCH_Compare/PDQ_0421.csv", row.names = FALSE)


##############################################################################


df1 <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/HCH_Compare/HCH_DATA/DIAB_0419.csv', sep= ",", header=TRUE)
df2 <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/HCH_Compare/HCH_DATA/DIAB_0420.csv', sep= ",", header=TRUE)
df3 <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/HCH_Compare/HCH_DATA/DIAB_0421.csv', sep= ",", header=TRUE)
df4 <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/HCH_Compare/HCH_DATA/MBS_0419.csv', sep= ",", header=TRUE)
df5 <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/HCH_Compare/HCH_DATA/MBS_0420.csv', sep= ",", header=TRUE)
df6 <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/HCH_Compare/HCH_DATA/MBS_0421.csv', sep= ",", header=TRUE)
df7 <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/HCH_Compare/HCH_DATA/MBS_MH_0419.csv', sep= ",", header=TRUE)
df8 <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/HCH_Compare/HCH_DATA/MBS_MH_0420.csv', sep= ",", header=TRUE)
df9 <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/HCH_Compare/HCH_DATA/MBS_MH_0421.csv', sep= ",", header=TRUE)
df10 <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/HCH_Compare/HCH_DATA/PDQ_0419.csv', sep= ",", header=TRUE)
df11 <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/HCH_Compare/HCH_DATA/PDQ_0420.csv', sep= ",", header=TRUE)
df12 <- read.csv('C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/HCH_Compare/HCH_DATA/PDQ_0421.csv', sep= ",", header=TRUE)

#merge each data extraction seperately into the 4 data categories 
df_1 <- merge(df1,df2, by = c("measure","auditmonth", "hchgroup", "totalcd", "indigenous"), all = TRUE)
df_2 <- merge(df_1, df3, by = c("measure","auditmonth", "hchgroup", "totalcd", "indigenous"), all = TRUE)
df_3 <- merge(df4, df5, by = c("measure","auditmonth", "hchgroup", "ha75.", "ha45.49", "indigenous.ha.55.", "indigenous.ha.15.54", 
                                "indigenous.ha..15", "cdm.gpmp", "cdm.tca", "cdm.review"), all = TRUE)
df_4 <- merge(df_3, df6, by = c("measure","auditmonth", "hchgroup", "ha75.", "ha45.49", "indigenous.ha.55.", "indigenous.ha.15.54", 
                                "indigenous.ha..15", "cdm.gpmp", "cdm.tca", "cdm.review"), all = TRUE)
df_5 <-merge(df7, df8, by = c("measure","auditmonth", "hchgroup","mhnumber","gp_mhtp", "gp_mhtp.review"), all = TRUE)
df_6 <- merge(df_5, df9, by = c("measure","auditmonth", "hchgroup","mhnumber","gp_mhtp", "gp_mhtp.review"), all = TRUE) 
df_7 <-merge(df10, df11, by = c("measure","auditmonth", "hchgroup", "total_population", "X75.", "X45_49"), all = TRUE )
df_8 <-merge(df_7, df12, by = c("measure","auditmonth", "hchgroup", "total_population", "X75.", "X45_49"), all = TRUE)

#merge all merged dataframes together
df_9 <- merge(df_2, df_4, by = c("measure","auditmonth", "hchgroup"),all = TRUE)
df_10 <- merge(df_9, df_6, by = c("measure","auditmonth", "hchgroup"),all = TRUE)
df_11 <- merge(df_10, df_8, by = c("measure","auditmonth", "hchgroup"),all = TRUE)

library(dplyr)

df_12 <- df_11[, c(1,2,3,17,4,11,12,13,14,15,16,5,8,9,10,19,7,18,6)]

#df_12 %>% mutate(ha715_total = select(.,indigenous.ha.55., indigenous.ha.15.54, indigenous.ha..15) %>% rowSums(na.rm = TRUE))

df_12$ha715_total <- rowSums(df_12[,c(13,14,15)], na.rm = TRUE)

df_12[4:19] <- lapply(df_12[4:19], as.numeric)
df_12[is.na(df_12)] <- 0
library(scales)
df_12$perc_cd = (df_12$totalcd/df_12$total_population)*100   
df_12$perc_gpmp = (df_12$cdm.gpmp/df_12$totalcd)*100 
df_12$perc_tca = (df_12$cdm.tca/df_12$totalcd)*100 
df_12$perc_review = (df_12$cdm.review/df_12$totalcd)*100
df_12$perc_mh = (df_12$mhnumber/df_12$total_population)*100 
df_12$perc_mhtp = (df_12$gp_mhtp/df_12$mhnumber)*100 
df_12$perc_review = (df_12$gp_mhtp.review/df_12$mhnumber)*100 
df_12$perc_indig = (df_12$indigenous/df_12$total_population)*100 
df_12$perc_715 = (df_12$ha715_total/df_12$indigenous)*100 
df_12$perc_45_49 = (df_12$X45_49/df_12$total_population)*100 
df_12$perc_ha45_49 = (df_12$ha45.49/df_12$X45_49)*100 
df_12$perc_75 = (df_12$X75./df_12$total_population)*100 
df_12$perc_ha75 = (df_12$ha75./df_12$X75.)*100

write.csv(df_12,"C:/Users/Kathleen/Dropbox (WQPHN)/David/Data Export/HCH_Compare/HCH_DATA/hchdata_all4.csv", row.names = FALSE)
str(df_12)

