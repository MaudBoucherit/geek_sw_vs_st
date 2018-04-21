# data_wrang.R
# Amy Goldlist, Tyler Roberts, Maud Boucherit
# April 2018
#
# This script cleans the survey raw data set. 
# Mainly, it renames the levels of variables
#
# Input: a csv file, the raw data set
# Output: a csv file, the clean data set
#
# Usage: Rscript src/data_wrang.R

# Libraries
library(tidyverse)
library(glue)

# Read in command line arguments
args <- commandArgs(trailingOnly = TRUE)
survey_responses <- args[1]

# Define main function
main <- function(){
  
  # Rename variables
  new_names <- c("Timestamp", 
               "participate", 
               "geeky", 
               "StarWars_fandom",
               "StarWars_knowledge",
               "StarTrek_fandom",
               "StarTrek_knowledge",
               "StarWars_obscure",
               "StarTrek_obscure",
               "familiar",
               "desert_island",
               "age",
               "gender",
               "continent",
               "sector",
               "MDS" )
  # Read raw data
  data <- read.csv("data/Geekiness_Survey.csv", col.names = new_names) %>% 
    select(-Timestamp, -participate) %>% 
    mutate(
      # Change discrete variables into factors
      geeky = as.factor(geeky),
      StarWars_fandom = as.factor(StarWars_fandom),
      StarTrek_fandom = as.factor(StarTrek_fandom),
      continent = as.factor(continent),
      
      # Rename the labels with number from the scale
      StarWars_knowledge = as.factor(substring(StarWars_knowledge,2,2)),
      StarTrek_knowledge = as.factor(substring(StarTrek_knowledge,2,2)),
      
      # Rename long labels 
      familiar = str_replace(familiar, "I am familiar with neither", "neither"),
      familiar = str_replace(familiar, "I know everything about both!!!", "both"),
      familiar = as.factor(familiar), 
      
      # Convert age to numeric (Part 1)
      age = str_replace(age, "Below 20",    "18"),
      age = str_replace(age, "In my 20s",   "25"),
      age = str_replace(age, "In my 30s",   "35"),
      age = str_replace(age, "In my 40s",   "45"),
      age = str_replace(age, "50 or older", "55"),
      
      # Group in "other" gender that are not Male or Female
      gender = as.factor(ifelse(test=(as.character(gender) %in% c("Male", "Female")), yes = as.character(gender), no = "Other")),
      
      # Cast MDS as a boolean
      MDS = (word(MDS, 1) == "Yes"))
  
  # Convert age to numeric (Part 2)
  data$age[!data$age %in% c("18", "25", "35", "45", "55")] <- NA
  data$age <- as.numeric(data$age)
  
  # Rename especially long label
  data$desert_island <- as.character(data$desert_island)
  data$desert_island[! data$desert_island %in% c("Star Wars", "Star Trek")] <- "neither"
  data$desert_island <- as.factor(data$desert_island)
  
  ## create combined scores.
  data$sw_score <- (as.numeric(paste(data$StarWars_fandom)) + 
    as.numeric(paste(data$StarWars_knowledge)) + 
    2.5*(data$familiar %in% c("Star Wars", "both")))/12.5
  data$st_score <- (as.numeric(paste(data$StarTrek_fandom)) + 
    as.numeric(paste(data$StarTrek_knowledge)) + 
    2.5*(data$familiar %in% c("Star Trek", "both")))/12.5
  
  # save the clean data set
  write_csv(data, "results/clean_data.csv")
}


# call main function
main()
