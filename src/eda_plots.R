# eda_plot.R
# Amy Goldlist, Tyler Roberts, Maud Boucherit
# April 2018
#
# This script produces some visualisations of 
# our variables for EDA.
#
# Input: a csv file, the clean data set
# Output: few png image, the visualisations
#
# Usage: Rscript src/eda_plot.R results/clean_data.csv

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
  
  # Bar plot of the distribution of geekiness by desert_island
  p1 <- dat %>% 
    ggplot(aes(fill = desert_island, x = geeky)) +
      geom_bar(aes(y = ..prop..)) +
      facet_wrap(~ desert_island) +
      theme_bw() + 
      scale_fill_manual(values = c("firebrick3", "darkgoldenrod2", "dodgerblue3")) +
      scale_y_continuous(labels = percent) +
      guides(fill = FALSE) +
      labs(title = "Desert Island Picks by Self-Identified Geekiness",
           y="Percentage", x="Self-reported Geekiness")
  
  ggsave("results/figures/desert_island-geekiness.png", p1)
  
  
  # Bar plot of geekiness by desert_island
  p2 <- dat %>% 
    ggplot(aes(fill = desert_island, x = geeky)) +
    geom_density(n=5) +
    facet_wrap(~desert_island) +
    theme_bw() + 
    scale_fill_manual(values = c("firebrick3", "darkgoldenrod2", "dodgerblue3")) +
    guides(fill = FALSE) +
    labs(title = "Desert Island Picks by Self-Identified Geekiness", y="Count", x="Self-Identified Geekiness")
  
  ggsave("results/figures/desert_island-geekiness.png", p2)
  
     
    
    # Response by gender
    dat %>% 
      ggplot(aes(x = desert_island, fill = gender)) +
        theme_bw() + 
        geom_bar(position = "fill", colour = "black") +
        scale_y_continuous("Gender", minor_breaks = NULL,  
                           breaks = c(0.04, 0.34, 0.8), 
                           labels = c("Other", "Male", "Female")) +
        coord_flip() +
        guides(fill = FALSE)
  
  # Response by age
  p3 <- subset(dat, !is.na(age)) %>% 
    ggplot(aes(x = desert_island, fill = factor(age, level = rev(levels(factor(age)))))) + 
      geom_bar(position = "fill", colour = "black") +
      theme_bw() +
      #scale_y_continuous("Age", minor_breaks = NULL,  
       #                  breaks = c(0, 0.036, 0.735, 0.908, 0.977), 
        #                 labels = c(0, 20, 30, 40, 50)) +
      coord_flip() + 
      scale_fill_brewer(labels=c("Less than 20", "20 to 30", "30 to 40", "40 to 50", "Greater than 50"), palette = "Dark2") +
      guides(fill=guide_legend(title="Age Group")) +
      labs(title="Desert Island Picks by Age", x="Desert Island Choice", y="Proportion Selected")
    
  ggsave("results/figures/desert_island-age.png", p3)
  
  # Response by MDS
  dat %>% 
  ggplot(aes(x = desert_island, fill = MDS)) + 
    theme_bw() +
    geom_bar(position = "fill", colour = "black") +
    scale_y_continuous("Are you an MDS student?", minor_breaks = NULL,  
                       breaks = c(0.1, 0.6), 
                       labels = c("Yes", "No")) +
    coord_flip() + guides(fill = FALSE) +
    labs(title="Desert Island picks MDS vs. Non-MDS", y="Desert Island Choice")
  
  # Response by continent
  p4 <- dat %>% 
    filter(continent %in% c("North America", "Europe", "Asia")) %>% 
    ggplot(aes(x = desert_island, fill = continent)) +
      theme_bw() +
      geom_bar(position = "fill", colour = "black") +
      #scale_y_continuous("Continent (most identified)", minor_breaks = NULL,  
       #                  breaks = c(0.125, 0.58, 0.95), 
        #                 labels = c("North America", "Europe", "Asia")) +
      coord_flip() + 
      scale_fill_brewer(palette = "Dark2") +
      guides(fill=guide_legend(title="Continent")) +
      labs(title="Desert Island Proportion by Continent", x="Desert Island Choice", y="Proportion Selected")
      
  
  ggsave("results/figures/desert_island-continent.png", p4)
  
}


# Call main function
main()
  