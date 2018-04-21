###############################################################
# 
# extra_plot.R
# 
# This script is not explicitely used in the final report.
# It contains the plots we created, but didn't used in the end.
# 
###############################################################

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
    theme_bw() +
    scale_fill_manual(values = c("darkolivegreen3", "dodgerblue3", "darkgoldenrod2", "firebrick3")) +
    guides(fill=guide_legend(title="Most Familiar With")) +
    labs(title = "Desert Island Picks by Familiarity", y="Count", x="Desert Island Choice")

# Bar plot of familiarity by desert_island
dat %>% 
  ggplot(aes(fill = desert_island, x = familiar)) +
    geom_bar(colour = "black") +
    theme_bw() +
    labs(title = "Familiarity Picks by Desert Island", y="Desert Island Choice")

# Bar plot of desert_island by geekiness
dat %>% 
  ggplot(aes(x = desert_island, fill = geeky)) +
    geom_bar() +
    facet_wrap(~geeky) +
    theme_bw() + 
    guides(fill = FALSE) +
    labs(title = "Desert Island Picks by Self-identified Geekiness", y="Desert Island Choice")

# Bar plot of desert_island by geekiness
dat %>% 
  ggplot(aes(x = desert_island, fill = factor(geeky, levels = rev(levels(geeky))))) + 
    geom_bar(position = "fill", colour = "black") +
    theme_bw() +
    scale_y_continuous("Self-identified geekiness", minor_breaks = NULL,  
                       breaks = c(0.02, 0.12, 0.37, 0.73, 0.94), 
                       labels = c(1, 2, 3, 4, 5)) +
    coord_flip() + 
    guides(fill = FALSE) +
    labs(title="Desert Island Picks by Self-Identified Geekiness")
