# propensity_analysis.R
# Amy Goldlist, Tyler Roberts, Maud Boucherit
# April 2018
#
# This script does some propensity analysis exploration 
# Uses code from Paul Gustafson lecture notes as inspiration
#
# Input: a csv file, the clean data set
# Output: ???
#
# Usage: Rscript src/propensity_analysis.R results/clean_data.csv

########################################################
## Response = desert_island
## Explanatory = geeky
## Confounders = age, familiar, continent, (MDS????)
#########################################################



# Libraries
library(tidyverse)
library(nnet)


# Read in command line arguments
#args <- commandArgs(trailingOnly = TRUE)
#clean_data <- args[1]

clean_data <- read.csv("results/clean_data.csv")

# str(clean_data)


##########################################
## Create glm for propensity coefficients
##########################################

## fit
fit1 <- glm(geeky~ age+ familiar+continent,family = poisson, data =clean_data)

## look at fit
summary(fit1)

## our PROPENSITY SCORES are fitted vals from this regression

clean_data <- clean_data %>% 
  mutate(propensity= predict(fit1, newdata=clean_data))



##################################
## Make a new model!
#################################

## fit
#fit2 <- glmnet::glmnet(clean_data$familiar~clean_data$geeky + clean_data$propensity,family = "multinomial")
#fit2 <- glm(clean_data$familiar~clean_data$geeky + clean_data$propensity,family = "multinomial")


fit2 <- nnet::multinom(familiar~geeky + propensity,data = clean_data)

summary(fit2)

