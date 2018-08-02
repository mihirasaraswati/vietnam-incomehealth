### Introduction

VA's National Center for Veteran Analysis and Statistics (NCVAS) publishes a variety of profiles of and deep-dives on Veterans. The profiles focus on the demographic and socioeconomic characteristics of a Veteran cohort (e.g. period of service, race/ethnic group) and provide a variety of statistics on topics like income, education, health, benefits received and utilization of VA services. The deep-dives provide an in-depth look into a few topics. This deep-dive explores the income, insurance, and disability variables in the American Community Survey

This repository has the code that creates the Vietnam Veteran Deep Dive on Finance and Health. My intent was to ensure reproducibility but I did end up making quite a few edits to the Beamer (pdf) slides using Adobe Pro - it's a lot easier to make cosmetic changes using Adobe Pro than it is to customize the Beamer template given my limited knowledge of LaTeX. Despite these manual edits the main pieces (getting, setting up, and creating statistics) of the deep-dive are reproducible. 

### Required Packages

The following R packages are required: survey, dplyr, RColorBrewer, ggplot2, knitr and kable. 

### Step 1 - Setup the R project and from the GitHub repository

The first step in reproducing this profile is to create a R project from the GitHub repository. You will need to have R, R Studio, and Git installed on your machine. The tutorials from the [RStudio Support Site](https://support.rstudio.com/hc/en-us/articles/200532077-Version-Control-with-Git-and-SVN) and the [Data Surg blog](http://www.datasurg.net/2015/07/13/rstudio-and-github/) will help get setup with these tools. 


### Step 2 - Getting the data
        
The script *[Code_Data_Get.R](https://github.com/mihiriyer/vietnam-incomehealth/blob/master/Code_Data_Get.R)*, will download the American Community Survey (ASC) Public Use Microdata Sample (PUMS) files (csv format) from the Census website. The first part of the script will download files from 2011 to 2013 and the second part downloads 2014 and 2015. The script will consolidate the United States and Puerto Rico files and save them as Rds files. The PUMS csv and Rds files will be saved to the *Raw_Data* folder and the all file names have been added to the *.gitignore* file so that they don't get added to repository and as such if they are not ignored pushes to repository will fail because of their large size. 


### Step 3 - Preparing the data and creating the survey design objects 

There are three scripts that will setup the data for analysis. The first script, *[Code_Data_Create_Survey_Objects.R](https://github.com/mihiriyer/vietnam-incomehealth/blob/master/Code_Data_Create_Survey_Objects.R)*, will convert the consolidated csv files into survey object and save them as Rds files in Svy_Objects folder. Similar to  the raw data files they have been added to the *.gitignore* file so that they don't get pushed to the repository. This script also subsets the 2015 file for Vietnam Veterans using the Military Service (MIL) and Veteran Period of Service (VPS) variables. The next two scripts, *[Code_ERS_MEAN_DF_2011_2015.R](https://github.com/mihiriyer/vietnam-incomehealth/blob/master/Code_Data_ESR_MEAN_DF_2011_2015.R)* and *[Code_ERS_Total_DF_2011_2015.R](https://github.com/mihiriyer/vietnam-incomehealth/blob/master/Code_Data_ESR_Total_DF_2011_2015.R)* calculate the svymean and svytotal of the ESR variable from 2011 to 2015 and store the results in data frame.


### Step 4 - Creating the slides

The deep-dive is a set of LaTeX Beamer slides and is created with the R Markdown document called *Analysis_Vietnam_Veteran_DeepDive_Part01_DRAFT_Alt_03.Rmd*. I left the word draft in the filename so that the pdf that gets generated also bears the same name and can be distinguished from final version which I edited manually with Adobe Pro. The manual edits I made consist of adding a footer on certain slides and moving x-axis label on the mosaic plots. I also modified the default Beamer template, this template file is named *default-beamer-twocol.tex* and is essential to knitting the R Markdown document.

#### *Beamer template customization*

1. Custom command to create two columns within which a R chunk can be processed.
2. Custom command to apply the tiny command on text output from r.
3. Color the slide header background blue and font black.
4. Color hyperlinks blue.

Good Luck!
