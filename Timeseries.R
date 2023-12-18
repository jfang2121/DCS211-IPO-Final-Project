library(ggplot2)
library(readr)
library(lubridate)
library(readxl)

ipo_data <- read_excel("/Users/sakinasaidi/Downloads/ipo_raw.xlsx")

# Convert the Announced Date to Date type
ipo_data$`Announced Date` <- as.Date(ipo_data$`Announced Date`, format="%Y-%m-%d")

# Plot the time series graph
ggplot(data = ipo_data, aes(x = `Announced Date`, y = `Offer Size (M)`)) +
  geom_line(group=1, color="dark blue") +
  labs(title="IPO Offer Size Over Time", x="Date", y="Offer Size (Millions)") +
  theme_minimal()