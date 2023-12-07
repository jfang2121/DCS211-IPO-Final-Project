################################ Cleaning Data ################################

if (!require(pacman)) install.packages(pacman)
pacman::p_load(dplyr, tidyverse,readxl) # Add other packages here if they are needed
theme_set(theme_minimal())

setwd("/Users/ianmayralboyle/Desktop/DCS211/DCS211-IPO-Final-Project") # Change to match personal path
ipo_raw <- read.csv("ipo_raw.csv")
sp_raw <- read_xlsx("spx.xlsx")
View(ipo_raw)

ipo <- ipo_raw %>% 
  filter(Country.Region.Full.Name == "UNITED STATES") %>% 
  filter(stringr::str_detect(Offer.Type, "IPO")) %>% 
  filter(Offer.To.1st.Close != ""
         & Offer.To.Month.1 != ""
         & Offer.To.1st.6.Months != ""
         & Offer.To.1st.Year != "") %>% 
  rename(date = Effective.Date, 
         first_day = Offer.To.1st.Close, 
         first_month = Offer.To.Month.1, 
         first_6m = Offer.To.1st.6.Months, 
         first_year = Offer.To.1st.Year) %>% 
  select(date, first_day, first_month, first_6m, first_year) %>% 
  mutate(first_day = as.numeric(first_day), 
         first_month = as.numeric(first_month), 
         first_6m = as.numeric(first_6m), 
         first_year = as.numeric(first_year)) %>% 
  mutate(pop_day = ifelse(first_day > 0, 1, 0), 
         pop_month = ifelse(first_month > 0, 1, 0), 
         pop_6m = ifelse(first_6m > 0, 1, 0), 
         pop_year = ifelse(first_year > 0, 1, 0))
View(ipo)

sp <- sp_raw %>% 
  rename(month = mon)
  # Change month format
View(sp)

