################################## Clean Data ##################################

if (!require(pacman)) install.packages(pacman)
pacman::p_load(dplyr, tidyverse,readxl, lubridate, stringi, broom)
theme_set(theme_minimal())

setwd("/Users/ianmayralboyle/Desktop/DCS211/DCS211-IPO-Final-Project") # Change to match personal path
ipo_raw <- read.csv("ipo_raw.csv")
sp_raw <- read_xlsx("spx.xlsx")
macro_raw <- read_xlsx("ifs_vf.xlsx")

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
ipo$date <- mdy(ipo$date)
ipo$date <- format(ipo$date, "%Ym%m")
ipo$date <- as.character(ipo$date)
ipo$date <- gsub("01$", "1", ipo$date)
ipo$date <- gsub("02$", "2", ipo$date)
ipo$date <- gsub("03$", "3", ipo$date)
ipo$date <- gsub("04$", "4", ipo$date)
ipo$date <- gsub("05$", "5", ipo$date)
ipo$date <- gsub("06$", "6", ipo$date)
ipo$date <- gsub("07$", "7", ipo$date)
ipo$date <- gsub("08$", "8", ipo$date)
ipo$date <- gsub("09$", "9", ipo$date)
ipo <- ipo %>% 
  # filter(country == "UNITED STATES") %>% 
  group_by(date, country) %>% 
  summarize(mean_pop = mean(pop_day, na.rm = TRUE)) %>% 
  rename(month = date)

sp <- sp_raw %>% 
  rename(month = mon) %>% 
  mutate(country = "UNITED STATES")

macro <- macro_raw %>% 
  rename(month = mon)
macro$country <- toupper(macro$country)

################################## Merge Data ##################################

final_data <- merge(ipo, macro)

################################## Regression ##################################

mean_pop_ir_lt <- lm(mean_pop ~ ir_lt, subset(final_data, ir_lt <= 10))
tidy(mean_pop_ir_lt)

mean_pop_ir_st <- lm(mean_pop ~ ir_st, subset(final_data, ir_st <= 10)) 
tidy(mean_pop_ir_st)

mean_pop_ip <- lm(mean_pop ~ ip, final_data) 
tidy(mean_pop_ip)

mean_pop_ue <- lm(mean_pop ~ ue, final_data) 
tidy(mean_pop_ue)

mean_pop_cpi <- lm(mean_pop ~ cpi, subset(final_data, cpi <= 250)) 
tidy(mean_pop_cpi)

regressions <- list(mean_pop_ir_lt, mean_pop_ir_st, mean_pop_ip, mean_pop_ue, mean_pop_cpi)
stargazer(regressions, type = 'text', out = 'regressions.html', 
          dep.var.labels = "Mean 'Pop' Percentage", title = "Results", 
          covariate.labels=c("Long Term Interest Rates", 
                             "Short Term Interest Rates", 
                             "Industrial Production", "Unemployment", 
                             "Inflation (CPI)"), align = TRUE)

#################################### Tables ####################################

table_mean_pop_ir_lt <- ggplot(subset(final_data, ir_lt <= 10), 
                               mapping = aes(y = mean_pop, x = ir_lt)) +
  geom_point() +
  geom_smooth(method = lm, se = F) +
  ggtitle("IPO 'Pops' and Long Term Interest Rates") +
  xlab("Long Term Interest Rates") + ylab("IPO 'Pop' Percentage")
table_mean_pop_ir_lt

table_mean_pop_ir_st <- ggplot(subset(final_data, ir_st <= 10), 
                               mapping = aes(y = mean_pop, x = ir_st)) +
  geom_point() +
  geom_smooth(method = lm, se = F) +
  ggtitle("IPO 'Pops' and Short Term Interest Rates") +
  xlab("Short Term Interest Rates") + ylab("IPO 'Pop' Percentage")
table_mean_pop_ir_st

table_mean_pop_ip <- ggplot(final_data, 
                               mapping = aes(y = mean_pop, x = ip)) +
  geom_point() +
  geom_smooth(method = lm, se = F) +
  ggtitle("IPO 'Pops' and Industrial Production") +
  xlab("Industrial Production") + ylab("IPO 'Pop' Percentage")
table_mean_pop_ip

table_mean_pop_ue <- ggplot(final_data, 
                            mapping = aes(y = mean_pop, x = ue)) +
  geom_point() +
  geom_smooth(method = lm, se = F) +
  ggtitle("IPO 'Pops' and Unemployment") +
  xlab("Unemployment (%)") + ylab("IPO 'Pop' Percentage")
table_mean_pop_ue

table_mean_pop_cpi <- ggplot(subset(final_data, cpi <= 250), 
                            mapping = aes(y = mean_pop, x = cpi)) +
  geom_point() +
  geom_smooth(method = lm, se = F) +
  ggtitle("IPO 'Pops' and Inflation (CPI)") +
  xlab("Inflation (CPI)") + ylab("IPO 'Pop' Percentage")
table_mean_pop_cpi