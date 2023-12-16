################################ Cleaning Data ################################

if (!require(pacman)) install.packages(pacman)
pacman::p_load(dplyr, tidyverse,readxl) # Add other packages here if they are needed
theme_set(theme_minimal())

setwd("/Users/ianmayralboyle/Desktop/DCS211/DCS211-IPO-Final-Project") # Change to match personal path
ipo_raw <- read.csv("ipo_raw.csv")
sp_raw <- read_xlsx("spx.xlsx")
# View(ipo_raw)

ipo <- ipo_raw %>% 
  rename(country = Country.Region.Full.Name) %>% 
  filter(country == "UNITED STATES" | country == "BRITAIN" | country == "DENMARK" | 
         country == "FRANCE" | country == "GERMANY" | country == "ITALY" | 
         country == "NETHERLANDS" | country == "NORWAY" | country == "SWEDEN" | 
         country == "SWITZERLAND" | country == "CANADA" | country == "JAPAN" | 
         country == "GREECE" | country == "IRELAND" | country == "SPAIN" | 
         country == "TURKEY" | country == "AUSTRALIA" | country == "BRAZIL" | 
         country == "ISRAEL" | country == "SOUTH KOREA" | country == "MALAYSIA" | 
         country == "THAILAND" | country == "RUSSIA" | country == "NORWAY" | 
         country == "NORWAY" | country == "CHINA" | country == "POLAND" | 
         country == "SOUTH AFRICA" | country == "INDIA" | country == "SINGAPORE" | 
         country == "VIETNAM" | country == "NEW ZEALAND" | country == "INDONESIA") %>%
  filter(stringr::str_detect(Offer.Type, "IPO")) %>%
  filter(Offer.To.1st.Close != "" | Offer.To.Month.1 != "") %>% 
  rename(date = Effective.Date, 
         first_day = Offer.To.1st.Close, 
         first_month = Offer.To.Month.1) %>% 
  select(date, country, first_day, first_month) %>% 
  mutate(first_day = as.numeric(first_day), 
         first_month = as.numeric(first_month)) %>% 
  mutate(pop_day = ifelse(first_day > 0, 1, 0), 
         pop_month = ifelse(first_month > 0, 1, 0))
View(ipo)

sp <- sp_raw %>% 
  rename(month = mon)

########################### Haven't figured out yet ###########################

sp$month <- strptime(as.character(sp$month), "%Ym%-d")

sp$newdate <- format(sp$month, "%Y/%m/%d")

as.character(sp$month)[1]

sp %>% 
  mutate(newdate)

view(sp)

