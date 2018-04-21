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

# Distribution of desert_island on geekiness, grouped
dat %>% 
  filter(desert_island != "neither") %>% 
  ggplot(aes(fill = desert_island, x = geeky)) +
    theme_bw() +
    geom_bar(position = "fill") +
    scale_fill_manual(values = c("darkgoldenrod2", "dodgerblue3")) +
    coord_flip() + 
    #scale_fill_brewer(palette = "Dark2") +
    guides(fill=guide_legend(title="Continent")) +
    labs(title="Desert Island Proportion by Geekiness", x="Proportion Selected", y="Desert Island Choice")

# Distribution of desert_island on geekiness, double grouped
dat %>% 
  filter(desert_island != "neither") %>% 
  mutate(geeky = ifelse(geeky %in% c(1,2), "not geeky", ifelse(geeky %in% c(4,5),"geeky", "neutral"))) %>% 
  ggplot(aes(fill = desert_island, x = geeky)) +
    theme_bw() +
    geom_bar(position = "fill") +
    scale_fill_manual(values = c("darkgoldenrod2", "dodgerblue3")) +
    coord_flip() + 
    #scale_fill_brewer(palette = "Dark2") +
    guides(fill=guide_legend(title="Continent")) +
    labs(title="Desert Island Proportion by Geekiness", x="Proportion Selected", y="Desert Island Choice")

# Bar plot of geekiness by desert_island
dat %>% 
  ggplot(aes(fill = desert_island, x = geeky)) +
    geom_density(n=5) +
    facet_wrap(~desert_island) +
    theme_bw() + 
    scale_fill_manual(values = c("firebrick3", "darkgoldenrod2", "dodgerblue3")) +
    guides(fill = FALSE) +
    labs(title = "Desert Island Picks by Self-Identified Geekiness", y="Count", x="Self-Identified Geekiness")

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

# Distribution of desert island by continent
dat %>% 
  filter(continent %in% c("North America", "Europe", "Asia")) %>% 
  ggplot(aes(fill = desert_island, x = continent)) +
  theme_bw() +
  geom_bar(position = "fill", colour = "black") +               
  coord_flip() + 
  scale_fill_manual(values = c("firebrick3", "darkgoldenrod2", "dodgerblue3")) +
  guides(fill=guide_legend(title="Desert Island Choice")) +
  labs(title="Desert Proportion by Continent", x="Continent", y="Proportion Selected")

# Distribution of geekiness by continent
dat %>% 
  filter(continent %in% c("North America", "Europe", "Asia")) %>% 
  ggplot(aes(fill = as.factor(geeky), x = continent)) +
  theme_bw() +
  geom_bar(position = "fill", colour = "black") +               
  coord_flip() + 
  scale_fill_brewer(palette = "Dark2") +
  guides(fill=guide_legend(title="Self-reported Geekiness")) +
  labs(title="Geekiness Proportion by Continent", x="Continent", y="Proportion Selected")

