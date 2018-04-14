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
# Usage: Rscript src/data_wrang.R results/clean_data.csv

# Libraries
library(tidyverse)
library(scales)

# Read in command line arguments
args <- commandArgs(trailingOnly = TRUE)
clean_data <- args[1]

# Define main function
main <- function(){
  # Import the clean data
  dat <- read.csv(clean_data)
  dat$desert_island <- factor(dat$desert_island, 
                               levels=rev(levels(dat$desert_island)))
  
  # Get a view of the data
  str(dat)
  dat %>% head()
  
  # Boxplot of geekiness by desert_island (our main response)
  dat %>% 
    ggplot(aes(y = as.numeric(geeky), x = desert_island)) +
    geom_boxplot() +
    theme_bw()
  
  # Box plot of geekiness by familiar (our main explanatory variable)
  dat %>% 
    ggplot(aes(y = as.numeric(geeky), x = familiar)) +
    geom_boxplot() +
    theme_bw()
  
  # Bar plot of desert_island by familiarity
  dat %>% 
    ggplot(aes(x = desert_island, fill = familiar)) +
    geom_bar(colour = "black") +
    scale_fill_manual(values = c("darkolivegreen3", "dodgerblue3", "darkgoldenrod2", "firebrick3")) +
    theme_bw() +
    labs(title = "Desert Island Picks by Familiarity")
  
  ggsave("results/figures/desert_island-familiarity.png")
  
  # Bar plot of familiarity by desert_island
  dat %>% 
    ggplot(aes(fill = desert_island, x = familiar)) +
    geom_bar(colour = "black") +
    theme_bw() +
    labs(title = "Familiarity Picks by Desert Island")
  
  # Density plot of geekiness by desert_island
  dat %>% 
    ggplot(aes(fill = desert_island, x = geeky)) +
    geom_bar() +
    facet_wrap(~desert_island) +
    xlab("Self-identified geekiness") +
    scale_fill_manual(values = c("firebrick3", "darkgoldenrod2", "dodgerblue3")) +
    theme_bw() + guides(fill = FALSE) +
    labs(title = "Desert Island Picks by Self-identified Geekiness")
  
  ggsave("results/figures/desert_island-geekiness.png")
  
  # Bar plot of desert_island by geekiness
  dat %>% 
    ggplot(aes(x = desert_island, fill = geeky)) +
    geom_bar() +
    facet_wrap(~geeky) +
    theme_bw() + guides(fill = FALSE) +
    labs(title = "Desert Island Picks by Self-identified Geekiness")
  
  # Bar plot of desert_island by geekiness
  ggplot(dat, aes(x = desert_island, fill = factor(geeky, levels = rev(levels(geeky))))) + 
    geom_bar(position = "fill", colour = "black") +
    scale_y_continuous("Self-identified geekiness", minor_breaks = NULL,  
                       breaks = c(0.02, 0.12, 0.37, 0.73, 0.94), 
                       labels = c(1, 2, 3, 4, 5)) +
    coord_flip() + guides(fill = FALSE) +
    theme_bw()
  
  # Response by gender
  ggplot(dat, aes(x = desert_island, fill = gender)) + 
    geom_bar(position = "fill", colour = "black") +
    scale_y_continuous("Gender", minor_breaks = NULL,  
                       breaks = c(0.04, 0.34, 0.8), 
                       labels = c("Other", "Male", "Female")) +
    coord_flip() +
    guides(fill = FALSE) +
    theme_bw()
  
  # Response by age
  ggplot(subset(dat, !is.na(age)), aes(x = desert_island, fill = factor(age, level = rev(levels(factor(age)))))) + 
    geom_bar(position = "fill", colour = "black") +
    scale_y_continuous("Age", minor_breaks = NULL,  
                       breaks = c(0, 0.036, 0.735, 0.908, 0.977), 
                       labels = c(0, 20, 30, 40, 50)) +
    coord_flip() + guides(fill = FALSE) +
    scale_fill_brewer(palette = "Dark2") +
    theme_bw()
  
  ggsave("results/figures/desert_island-age.png")
  
  # Response by MDS
  ggplot(data, aes(x = desert_island, fill = MDS)) + 
    geom_bar(position = "fill", colour = "black") +
    scale_y_continuous("Are you an MDS student?", minor_breaks = NULL,  
                       breaks = c(0.1, 0.6), 
                       labels = c("Yes", "No")) +
    coord_flip() + guides(fill = FALSE) +
    theme_bw()
  
  # Response by continent
  ggplot(dat %>% filter(continent %in% c("North America", "Europe", "Asia")), aes(x = desert_island, fill = continent)) + 
    geom_bar(position = "fill", colour = "black") +
    scale_y_continuous("Continent (most identified)", minor_breaks = NULL,  
                       breaks = c(0.125, 0.58, 0.95), 
                       labels = c("North America", "Europe", "Asia")) +
    coord_flip() + guides(fill = FALSE) +
    scale_fill_manual(values = c("darkgoldenrod2", "dodgerblue3", "firebrick3")) +
    ggtitle("Desert Island Proportion by Continent") +
    theme_bw()
  
  ggsave("results/figures/desert_island-continent.png")
  
}


# Call main function
main()
  