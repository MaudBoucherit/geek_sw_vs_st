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
library(cowplot)

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
  
  ggsave("results/figures/desert_island-geekiness.png", p1, height = 4, units = "in")
  
  
  # Distribution of desert_island by geekiness
  p2 <- dat %>% 
    ggplot(aes(fill = desert_island, x = geeky)) +
    theme_bw() +
    geom_bar(position = "fill", colour = "black") +
    scale_fill_manual(values = c("firebrick3", "darkgoldenrod2", "dodgerblue3")) +
    scale_y_continuous(labels = percent) +
    guides(fill=guide_legend(title="Desert Island \nChoice")) +
    labs(title="Desert Island Distribution by Geekiness",
         x="Self-reported Geekiness", y="Percentage")
  
  ggsave("results/figures/geekiness-desert_island.png", p2, height = 4, units = "in")
  
  
  # Distributions of esert_island and geekiness by age
  # General plot template for the age plots
  age_plot <- subset(dat, !is.na(age)) %>% 
    ggplot(aes(fill = factor(age, level = rev(levels(factor(age)))))) + 
    theme_bw() +
    scale_fill_brewer(labels=c("Younger than 20", "20 to 30", "30 to 40", "40 to 50", "Older than 50"), palette = "Dark2")
  
  # Plot of age proportion by Self-reported Geekiness
  ## with the common title, and the common legend
  age_geekiness <- age_plot +
    geom_bar(aes(x = geeky), position = "fill", colour = "black") +
    labs(title="Proportions by Age Group", x="Self-reported Geekiness", y="Proportion") +
    guides(fill = guide_legend(title = "  Age: ", 
                               title.position = "left", 
                               ncol = 5))  +
    theme(legend.position = c(0, -.2), legend.justification = c(0,0))
  
  # Plot of age proportion by Desert Island Choice
  age_desert <- age_plot + 
    geom_bar(aes(x = desert_island), position = "fill", colour = "black") +
    labs(title=" ", x="Desert Island Choice", y="") +
    theme(plot.margin = unit(c(.2,.2,.3,-.5), "cm"))
  
  # Define the common legend
  legend <- get_legend(age_geekiness)
  
  # Display both plots at once
  p3 <- cowplot::plot_grid(age_geekiness + theme(legend.position="none"), 
                     age_desert + theme(legend.position="none"),
                     rel_widths = c(1, .7),
                     rel_heights = c(1, .1),
                     ncol = 2,
                     legend)
    
  ggsave("results/figures/distributions-age.png", p3, height = 4, units = "in")
  
  
  
  # Response by continent
  # General plot template for the continent plots
  cont_plot <- dat %>% 
    filter(continent %in% c("North America", "Europe", "Asia")) %>% 
    ggplot(aes(fill = continent)) +
      theme_bw() +
      scale_fill_brewer(palette = "Dark2")
  
  # Plot of continent proportion by Self-reported Geekiness
  ## with the common title, and the common legend
  cont_geekiness <- cont_plot +
    geom_bar(aes(x = geeky), position = "fill", colour = "black") +
      labs(title="Proportions by Continent", x="Self-reported Geekiness", y="Proportion") +
      guides(fill = guide_legend(title = "Continent: ", 
                                 title.position = "left", 
                                 ncol = 3))  +
      theme(legend.position = c(.3, -.2), legend.justification = c(0,0))
  
  # Plot of age proportion by Desert Island Choice
  cont_desert <- cont_plot + 
    geom_bar(aes(x = desert_island), position = "fill", colour = "black") +
      labs(title=" ", x="Desert Island Choice", y="") +
      theme(plot.margin = unit(c(.2,.2,.3,-.5), "cm"))
  
  # Define the common legend
  legend <- get_legend(cont_geekiness)
  
  # Display both plots at once
  p4 <- cowplot::plot_grid(cont_geekiness + theme(legend.position="none"), 
                     cont_desert + theme(legend.position="none"),
                     rel_widths = c(1, .7),
                     rel_heights = c(1, .1),
                     ncol = 2,
                     legend)
  
  ggsave("results/figures/distributions-continent.png", p4, height = 4, units = "in")
  
  
  # Star Wars and Star Trek score related to geekiness and desert island
  p5 <- dat %>% 
    gather("serie", "score", sw_score, st_score) %>% 
    ggplot(aes(score, colour = desert_island)) +
      stat_ecdf(geom = "line") +
      facet_wrap(~ serie, 
                 labeller = labeller(serie = c("sw_score" = "Star Wars", "st_score" = "Star Trek"))) +
      theme_bw() +
      scale_colour_manual(values = c("firebrick3", "darkgoldenrod2", "dodgerblue3")) +
      labs(title = "Score Cumulative Density Function by Universe",
           x = "Score", y = "Cumulative Density", colour = "Desert \nIsland ") 
  
  ggsave("results/figures/scores-desert_island.png", p5, height = 4, units = "in")
  
  
  # Score distribution for desert island
  p6 <- dat %>% 
    gather("serie", "score", sw_score, st_score) %>% 
    ggplot(aes(score, colour = factor(geeky))) +
      stat_ecdf(geom = "line") +
      facet_wrap(~ serie, 
                 labeller = labeller(serie = c("sw_score" = "Star Wars", "st_score" = "Star Trek"))) +
      theme_bw() +
      scale_colour_brewer(palette = "Dark2") +
      labs(title = "Score Cumulative Density Function by Universe",
           x = "Score", y = "Cumulative Density", colour = "Geekiness") 
  
  ggsave("results/figures/scores-geekiness.png", p6, height = 4, units = "in")
  
  
  # Average scores
  avg_geeky <- dat %>% 
    mutate(avg = (sw_score + st_score)/2) %>% 
    ggplot(aes(avg, colour = factor(geeky))) +
    stat_ecdf(geom = "line") +
    theme_bw() +
    scale_colour_brewer("", palette = "Dark2") +
    labs(title = "Self-reported Geekiness",
         x = "Aerage Score", y = "Cumulative Density") +
    theme(legend.position = c(.83, .35),
          legend.background = element_blank())
  
  avg_desert <- dat %>% 
    mutate(avg = (sw_score + st_score)/2) %>% 
    ggplot(aes(avg, colour = desert_island)) +
    stat_ecdf(geom = "line") +
    theme_bw() +
    scale_colour_manual(values = c("firebrick3", "darkgoldenrod2", "dodgerblue3")) +
    labs(title = "Desert Island Choice", x = "Average Score", y = "", colour = "") +
    theme(legend.position = c(.73, .26),
          legend.background = element_blank()) +
    theme(plot.margin = unit(c(.3,.2,.2,-.5), "cm"))
  
  # Display both plots at once
  p7 <- cowplot::plot_grid(avg_geeky, avg_desert, 
                     rel_widths = c(1, .9))
  
  ggsave("results/figures/scores-average.png", p7, height = 4, units = "in")
  
  
}


# Call main function
main()
  