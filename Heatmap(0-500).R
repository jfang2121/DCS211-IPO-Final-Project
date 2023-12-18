library(ggplot2)
library(readr)
library(lubridate)
library(dplyr)
library(readxl)

ipo_data <- read_excel("/Users/sakinasaidi/Downloads/ipo_raw.xlsx")

# Convert the Announced Date to Date type
ipo_data$`Announced Date` <- as.Date(ipo_data$`Announced Date`, format="%Y-%m-%d")
# Ensure numeric variables are correctly formatted
ipo_data$`Offer Size (M)` <- as.numeric(ipo_data$`Offer Size (M)`)

# Aggregate data for heatmap, like sum the offer size by Announced Date and Country/Region
ipo_aggregated <- ipo_data %>%
  group_by(`Announced Date`, `Country/Region ISO Code`) %>%
  summarise(TotalOfferSize = sum(`Offer Size (M)`))

# Create the heatmap
ggplot(ipo_aggregated, aes(x = `Announced Date`, y = `Country/Region ISO Code`, fill = TotalOfferSize)) +
  geom_tile() +
  labs(title = "Heatmap of IPO Offer Size", x = "Announced Date", y = "Country/Region ISO Code") +
  scale_fill_gradient(low = "blue", high = "red", limits = c(0, 500)) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))