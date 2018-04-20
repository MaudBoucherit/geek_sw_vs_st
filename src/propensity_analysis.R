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
## Explanatory = geeky, SW and ST related questions
## Confounders = age, continent, gender
#########################################################



# Libraries
library(tidyverse)
library(nnet)


# Read in command line arguments
#args <- commandArgs(trailingOnly = TRUE)
#clean_data <- args[1]

clean_data <- read.csv("results/clean_data.csv")

# str(clean_data)




###############################################
###############################################

## Amy'S version

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



### note:  I changed this just to see,  It's...  ok?
fit2 <- nnet::multinom(desert_island~geeky + propensity,data = clean_data)

summary(fit2)

###############################################
###############################################

## Maud's version

##########################################
## Create glm for propensity coefficients
##########################################

# On the confounding variables
propensity <- glm(geeky ~ age + continent + gender, 
            family = poisson, data = clean_data)

# Add propensity score to the data
pred <- predict(propensity, newdata = clean_data)
clean_data <- clean_data %>% 
  mutate(propensity = cut(pred, breaks=c(0, quantile(pred[-63], (1:4)/5), 1)))


##################################
## Make a new model!
#################################

# Creating score variables summarizing information related to SW & ST
clean_data$sw_score <- clean_data$StarWars_fandom + clean_data$StarWars_knowledge + 
            2.5*(clean_data$familiar %in% c("Star Wars", "both"))
clean_data$st_score <- clean_data$StarTrek_fandom + clean_data$StarTrek_knowledge + 
            2.5*(clean_data$familiar %in% c("Star Trek", "both"))

# Fit a model where the success is Star Wars
clean_data$sw_success <- (clean_data$desert_island == "Star Wars")
sw_success <- glm(sw_success ~ geeky + sw_score + st_score, 
            family = binomial, data = clean_data)
summary(sw_success)

# Fit a model where the success is Star Trek
clean_data$st_success <- (clean_data$desert_island == "Star Trek")
st_success <- glm(st_success ~ geeky + sw_score + st_score, 
                  family = binomial, data = clean_data)
summary(st_success)

# Fit a model where the success is none of them
clean_data$no_success <- (clean_data$desert_island == "neither")
no_success <- glm(no_success ~ geeky + sw_score + st_score, 
                  family = binomial, data = clean_data)
summary(no_success)

# Fit a multinomial model
## TODO


###########################################################################
## Here I used the nnet package, which uses the power of a neural network.  
###########################################################################


multi<- nnet::multinom(desert_island ~ geeky + sw_score + st_score, 
                       family = binomial, data = clean_data)
summary(multi)

##lookign around
attributes(multi)


## predict stuff
## gives probabilities, adding "probs"
predict(multi,clean_data,"probs")

## gives the highest probability, like we want.

##success rate:
mean(clean_data$desert_island==(predict(multi,clean_data)))

##69%.  That's...  ok, I guess?


###########################################################################
## Here I used the MASS, because it has an ordered logit model 
###########################################################################

library(MASS)  ##note, this masks dplyr select, so we should load it first in the future.

### this is an ordered logit model:
## name means Proportional Ordered Logistic Regression

polr_model <- polr(desert_island ~ geeky + sw_score + st_score, data = clean_data, method = "logistic", Hess = TRUE)

##look:
polr_model

summary(polr_model)

###########################################################################
## And now let's add some propensity scores! 
###########################################################################

polr_prop <- polr(desert_island ~ geeky + sw_score + st_score + propensity, data = clean_data, method = "logistic", Hess = TRUE)

summary(polr_prop)


###  Uh.. this shows that geekiness has very little effect. Interesting!
