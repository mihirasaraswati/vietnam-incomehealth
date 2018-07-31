library(survey)

# calculate svymeans for ESR variable from ACS 1-yr PUMS (2011 to  --------

#read list of person files from 2011 to 2015
svy.files <- list.files("./Svy_Objects/")

#create empty df to store all ESR values
esr.df <- data.frame("Year" = factor(), "ESRLvl" = factor(), "Mean" = numeric(), "SE" = numeric())

#!!!!2011 and 2012 files (MIL levels change in 2013)
#loop to run through files (svy objects), calculate ESR and store them in a list
for(i in 1:2){
  
  #create a pathname variable to the object file
  pathname <- paste("./Svy_Objects/", svy.files[i], sep = "")
  
  #read the svy object
  svy.obj <- readRDS(pathname)
  
  #calculate svymean for ESR, store ESR calculation as a list item
  esr <- svymean(~factor(ESR), 
                  subset(svy.obj, MIL %in% c(2,3) & VPS %in% c(6:8)),
                  na.rm = TRUE)
  #convert to df
  esr <- data.frame(esr)
  
  #create temporary df to store ESR calculations 
  tmp.df <- data.frame(Year = rep(paste("201", i, sep = ""), nrow(esr)), 
                       EsrLvl = row.names(esr),
                       Mean = esr$mean, 
                       SE = esr$SE)
  
  esr.df <- rbind(esr.df, tmp.df)
  
}


#!!!!2013 and 2015 files 
#loop to run through files (svy objects), calculate ESR and store them in a list
for(i in 3:5){
  
  #create a pathname variable to the object file
  pathname <- paste("./Svy_Objects/", svy.files[i], sep = "")
  
  #read the svy object
  svy.obj <- readRDS(pathname)
  
  #calculate svymean for ESR, store ESR calculation as a list item
  esr <- svymean(~factor(ESR), 
                  subset(svy.obj, MIL == 2 & VPS %in% c(6:8)),
                  na.rm = TRUE)
  #convert to df
  esr <- data.frame(esr)
  
  #create temporary df to store ESR calculations 
  tmp.df <- data.frame(Year = rep(paste("201", i, sep = ""), length(esr)), 
                       EsrLvl = row.names(esr),
                       Mean = esr$mean, 
                       SE = esr$SE)
  
  esr.df <- rbind(esr.df, tmp.df)
  
}

#clean-up EsrLvl variable
esr.df$EsrLvl <- sub(x = esr.df$EsrLvl, 
                     pattern = "factor(ESR)", 
                     replacement = "", 
                     fixed = TRUE)

esr.df$EsrLvl <- factor(x = esr.df$EsrLvl, levels = unique(esr.df$EsrLvl), labels = c("Civ @ Work", "Civ NOT @ Work", "Unemployed", "Not in Labor Force"))

#save df as Rds to be used elsewhere (i.e. making graphs)
saveRDS(esr.df, "Data_ESR_Mean_DF_2011_2015.Rds")

# rm(list=ls())
