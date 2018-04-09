library(dplyr)
library(stringr)


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


dat <- read.csv("data/Geekiness_Survey_(Responses).csv",col.names = new_names)

dat <- dat %>% 
  select(-Timestamp, -participate) %>% 
  mutate(StarWars_knowledge = substring(StarWars_knowledge,2,2),
         StarWars_fandom = substring(StarWars_knowledge,2,2),
         StarTrek_knowledge = substring(StarWars_knowledge,2,2),
         StarTrek_fandom = substring(StarWars_knowledge,2,2)) %>% 
  mutate(MDS = word(MDS, 1))
  

                 