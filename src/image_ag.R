library(tidyverse)

dat <- read.csv("results/clean_data.csv")


str(dat)

dat %>% head()

dat %>% 
  ggplot(aes(y = geeky, x = desert_island))+
  geom_boxplot()+
  theme_bw()

dat %>% 
  ggplot(aes(y = geeky, x = familiar))+
  geom_boxplot()+
  theme_bw()

dat %>% 
  ggplot(aes(x = desert_island, fill = familiar))+
  geom_bar()+
  theme_bw()+
  labs(title = "Desert Island Picks by familiarity")

dat %>% 
  ggplot(aes(fill = desert_island, x = familiar))+
  geom_bar()+
  theme_bw()+
  labs(title = "Familiarity Picks by Desert Island")

dat %>% 
  ggplot(aes(fill = desert_island, x = geeky))+
  geom_bar()+
  facet_wrap(~desert_island)+
  theme_bw()+
  labs(title = "Desert Island Picks by geekiness")
  
  dat %>% 
    ggplot(aes(x = desert_island, fill = geeky))+
    geom_bar()+
    facet_wrap(~geeky)+
    theme_bw()+
    labs(title = "Desert Island Picks by geekiness")
