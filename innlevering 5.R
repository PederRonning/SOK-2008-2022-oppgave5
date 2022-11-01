library(tidyverse)
library(PxWebApiData)

Sys.setlocale(locale="no_NO")

df <- 
  ApiData("https://data.ssb.no/api/v0/no/table/05185/",
              Landbakgrunn=list('agg:Verdensdel2', c("b11", "b12", "b13", "b14", 
                                                     "b2", "b3", "b4", "b5", "b6")), 
              Tid=list('item', c("2005", "2006", "2007", "2008", "2009", "2010", 
                                 "2011", "2012", "2013", "2014", "2015", "2016", 
                                 "2017", "2018", "2019", "2020", "2021", "2022")), 
              ContentsCode=TRUE)

df <- as_tibble(df[[1]])

ggplot(df, aes(x = år, y = value, fill= landbakgrunn)) +
  geom_col(width = 0.7, position = "stack") +
  labs(title="Årlig oversikt",
       x ="År",
       y = "Innvandrere") +
       theme(axis.text.x = element_text(angle = 90))
  
df2 <- ApiData("https://data.ssb.no/api/v0/no/table/13215/",
               Kjonn=list('item', c("0")),
               Alder=list('item', c("15-74")), 
               InnvandrKat=list('item', c("B")), 
               Landbakgrunn=list('item', c("015a")), 
               NACE2007=list('agg:NACE260InnvGrupp2',
                             c("SNI-00-99", "SNI-01-03", "SNI-05-09", "SNI-10-33",
                               "SNI-35-39", "SNI-41-43", "SNI-45-47", "SNI-49-53",
                               "SNI-49.3", "SNI-55", "SNI-56", "SNI-58-63",
                               "SNI-64-66", "SNI-68-75", "SNI-77-82", "SNI-78.2",
                               "SNI-81.2", "SNI-84","SNI-85","SNI-86-88","SNI-90-99",
                               "SNI-00")), 
               Tid=list('item', c("2021")), 
               ContentsCode=TRUE)

df2 <- as_tibble(df2[[1]])

df2 <- df2 %>% 
  select(`næring (SN2007)`, value) %>% 
  arrange(desc(value))

df2$`næring (SN2007)` <- gsub(".*\\.", "", df2$`næring (SN2007)`)

df2 <- df2[-1, ]

df2 %>% 
  ggplot(aes(x = `næring (SN2007)`, y = value, fill= `næring (SN2007)`)) +
  geom_col(width = 0.7, position = "dodge", show.legend = FALSE) +
  labs(title="Øst-Europeere i det norske næringslivet",
       x ="",
       y = "") +
  theme(axis.text.x = element_text(angle = 90))


        