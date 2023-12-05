################################ Cleaning Data ################################

library(dplyr)
library(tidyverse)
library(readxl)

setwd("/Users/ianmayralboyle/Desktop/DCS211/Final") # Change to match personal path
ipo_raw <- read.csv("ipo_raw.csv")
sp_raw <- read_xlsx("spx.xlsx")
View(ipo_raw)

ipo <- ipo_raw %>% 
  filter(Country.Region.Full.Name == "UNITED STATES") %>% 
  filter(stringr::str_detect(Offer.Type, "IPO")) %>% 
  filter(Offer.To.1st.6.Months != "" & Offer.To.1st.Year != "")
  # Rename columns
View(ipo)

sp <- sp_raw %>% 
  rename(month = mon)
  # Change month format
View(sp)

