#This script Convertst the consolidated PUMS files into survey design objects.
library(survey)

pums <- list.files("Raw_Data/")
pums <- pums[grep("pusab", pums)]

for(i in 1:length(pums)){
  
  pathname <- paste("Raw_Data/", pums[i], sep="")
  
  svy.data <- readRDS(pathname)
  
  #create survey design object - General/Total Population All Variables
  svy.obj <- svydesign(id = ~1, 
                       weights = svy.data$PWGTP,
                       data = svy.data,
                       repweights = "pwgtp[0-9]+",
                       type = "JKn",
                       scale = 4/80, 
                       rscales = rep(1,80),
                       combined.weights = TRUE
  )
  
  rm(svy.data)
  
  saveRDS(svy.obj, paste("Svy_Objects/", pums[i], sep=""))
  
  rm(svy.obj)
  
  print(paste(pums[i], " is complete!", sep=""))
  
}


## Create svy design object with 2015 PUMS file for Vietnam Veterans
#read-in person data -win
per_design <- readRDS("Svy_Objects/pusab15.rds")

viet_design <- subset(per_design, MIL %in% c(2) & VPS %in% c(6:8))

saveRDS(viet_design, "Svy_Objects/Data_per115_viet_design.Rds")
