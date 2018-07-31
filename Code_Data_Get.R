# This script will download, consolidate and save the ACS PUMS Person files from 2011 to 2015. 

# It will get usa, usb and pr (puerto rico) files for each of those years from the U.S. Census Bureau's website. The files will be downloaded to the Raw_Data folder of the directory/repositary. 

# loop through each year and download, consolidate and save PUMS data (US + PR) for that year. 

# Create temp file to store downloaded zip file
temp <- tempfile()

# Create vector for each year 2011 to 2013 (URL changes in 2014)
years <- 11:13

for(i in 1:length(years)){
  
  ## Create url for each year 
  acs.year <- paste("acs20", years[i],"_1yr", sep = "")
  # puerto rico file
  prfile.url <- paste("https://www2.census.gov/", acs.year, "/pums/csv_ppr.zip", sep = "")
  # us national file
  usfile.url <- paste("https://www2.census.gov/", acs.year, "/pums/csv_pus.zip", sep = "")
  
  
  ## Puerto Rico - Download Person file
  download.file(url = prfile.url, destfile = temp)
  
  # Puerto Rico - UNZIP Person File 
  # name of csv file in the zip folder
  pprfile<- paste("ss", years[i], "ppr.csv", sep = "")
  #unzip and read ppr file
  ppr <- read.csv(unzip(zipfile = temp, files = pprfile,  exdir = "./Raw_Data"))
  
  ## US/National - Download Person file
  download.file(url = usfile.url, destfile = temp)

  # name of csv files in the zip folder
  usafile <- paste("ss", years[i], "pusa.csv", sep = "")
  usbfile <- paste("ss", years[i], "pusb.csv", sep = "")

  # unzip and read US files a & b
  usa <- read.csv(unzip(zipfile = temp, files = usafile,  exdir = "./Raw_Data"))
  usb <- read.csv(unzip(zipfile = temp, files = usbfile,  exdir = "./Raw_Data"))

  ## Consolidate and save files as RDS
  # rds file name
  rdsfile <- paste("./Raw_Data/", "pusab", years[i], ".Rds", sep = "")
  #consolidate
  usabpr <- rbind(usa, usb, ppr)
  #save
  saveRDS(usabpr, rdsfile)
  rm(usabpr, usa, usb, ppr)
  
}

##### 2014 to 2015 files ############

# Create vector for each year 2011 to 2013 (URL changes in 2014)
years <- 14:15

for(i in 1:length(years)){
  
  ## Create url for each year 
   # puerto rico file
  prfile.url <- paste("https://www2.census.gov/programs-surveys/acs/data/pums/20", years[i], "/1-Year/csv_ppr.zip", sep = "")
  # us national file
  usfile.url <- paste("https://www2.census.gov/programs-surveys/acs/data/pums/20", years[i], "/1-Year/csv_pus.zip", sep = "")
  
  ## Puerto Rico - Download Person file
  download.file(url = prfile.url, destfile = temp)
  
  # Puerto Rico - UNZIP Person File 
  # name of csv file in the zip folder
  pprfile<- paste("ss", years[i], "ppr.csv", sep = "")
  #unzip and read ppr file
  ppr <- read.csv(unzip(zipfile = temp, files = pprfile,  exdir = "./Raw_Data"))
  
  ## US/National - Download Person file
  download.file(url = usfile.url, destfile = temp)

  # name of csv files in the zip folder
  usafile <- paste("ss", years[i], "pusa.csv", sep = "")
  usbfile <- paste("ss", years[i], "pusb.csv", sep = "")

  # unzip and read US files a & b
  usa <- read.csv(unzip(zipfile = temp, files = usafile,  exdir = "./Raw_Data"))
  usb <- read.csv(unzip(zipfile = temp, files = usbfile,  exdir = "./Raw_Data"))

  ## Consolidate and save files as RDS
  # rds file name
  rdsfile <- paste("./Raw_Data/", "pusab", years[i], ".Rds", sep = "")
  #consolidate
  usabpr <- rbind(usa, usb, ppr)
  #save
  saveRDS(usabpr, rdsfile)
  rm(usabpr, usa, usb, ppr)
  
}
