library(ggplot2)
library(readr)
library(dplyr)
library(readxl)

ipo_data <- read_excel("/Users/sakinasaidi/Downloads/ipo_raw.xlsx")

# Aggregate data by Industry Group for the pie chart
industry_data <- ipo_data %>%
  group_by(`Industry Group`) %>%
  summarise(TotalOfferSize = sum(`Offer Size (M)`)) %>%
  mutate(Percentage = TotalOfferSize / sum(TotalOfferSize) * 100)

# Create the pie chart
ggplot(industry_data, aes(x = "", y = Percentage, fill = `Industry Group`)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  theme_void() +
  labs(fill = "Industry Group",
       title = "Pie Chart of IPO Offer Size by Industry") +
  guides(fill = guide_legend(title = "Industry Group"))