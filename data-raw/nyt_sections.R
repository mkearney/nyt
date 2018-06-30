#tax <- read_source("https://static01.nyt.com/services/json/taxonomy/v2/flat.json")
#tax <- fromjson(tax)
#sections <- tax$path %>% grep("section", ., value = TRUE) %>% gsub(".*section/", "", .) %>%
#  sub("/.*", "", .) %>% unique()
