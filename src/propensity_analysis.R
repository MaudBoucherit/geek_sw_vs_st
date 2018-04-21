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


# Import the clean data
clean_data <- read.csv("results/clean_data.csv")


###############################################
###############################################

## Final version (the one in the report)
# 
# First fit a linear regression on geekiness by confounders.
# Then fit a POLR (proportional odds logistic regression) on 
# desert island by geekiness, SW and ST scores, and propensity.
# 
##

##########################################
## Build lm for propensity coefficients
##########################################

# Linear model of self-reported geekiness against the confounders
propensity <- lm(geeky ~ gender + age + continent, data = clean_data)
summary(propensity)

# Add propensity score to the data
pred <- predict(propensity, newdata = clean_data)
clean_data <- clean_data %>%
  mutate(propensity = pred)

#########################################################
## Build a POLR on our response by expalantory/propensity
#########################################################

polr_model <- MASS::polr(
  desert_island ~ geeky + st_score + sw_score + propensity,
  data = clean_data, method = "logistic", Hess = TRUE)

summary(polr_model)

# Compare without propensity
summary(MASS::polr(desert_island ~ geeky + sw_score + st_score, 
                   data = clean_data, method = "logistic", Hess = TRUE))


###############################################
###############################################

## First version
# 
# First fit a Poisson GLM on geekiness by confounders.
# Then fit a nnet model on desert island by geekiness and propensity.
# 
##

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
## Fit a nnet model
#################################

## fit a multinomial model
#fit2 <- glmnet::glmnet(clean_data$familiar~clean_data$geeky + clean_data$propensity,family = "multinomial")
#fit2 <- glm(clean_data$familiar~clean_data$geeky + clean_data$propensity,family = "multinomial")
fit2 <- nnet::multinom(desert_island~geeky + propensity,data = clean_data)

summary(fit2)


###############################################
###############################################

## Second version
# 
# First fit a Poisson GLM on geekiness by confounders.
# Then fit a bunch of binomial GLM on desert island 
# by geekiness and propensity, with success being each
# of the three levels.
# 
##

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


###############################################
###############################################

## Third version
# 
# Fit a nnet model on desert island by geekiness and SW/ST scores.
# Try some prediction functions.
# Fit a POLR model on the same variables.
# Add some propensity.
# 
##

###########################################################################
## Here I used the nnet package, which uses the power of a neural network.  
###########################################################################

multi<- nnet::multinom(desert_island ~ geeky + sw_score + st_score, 
                       family = binomial, data = clean_data)
summary(multi)

##lookign around
attributes(multi)

## gives probabilities, adding "probs"
predict(multi,clean_data,"probs")

## gives the highest probability, like we want.

##success rate:
mean(clean_data$desert_island==(predict(multi,clean_data)))
## 69%


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
## And now let's add some propensity scores 
###########################################################################

polr_prop <- polr(desert_island ~ geeky + sw_score + st_score + propensity, data = clean_data, method = "logistic", Hess = TRUE)

summary(polr_prop)

###  This shows that geekiness has very little effect. 
