# DCS211 Final Project: Global IPO Market Exploration
#### By Ian, Jing, Sakina, Xinyi

## Goal 
We aim to visualize the dynamic global Initial Public Offerings (IPO) market in the 21st century and examine the influence of macroeconomic factors on the success of IPO activities from 2000 to 2023, a period marked by significant global events like the 2008 financial crisis and the COVID-19 pandemic. Employing Ordinary Least Squares (OLS) regressions and incorporating a range of macroeconomic variables, this project explores how economic indicators such as inflation, unemployment rates, interest rates, stock market performance, and market volatility impact IPO pop rates, the rates of having a positive closing price, across 31 countries, accounting for over 90% of the global IPO market. 

## Scope
### Global IPO Market
The IPO data for this study was sourced from Bloomberg’s Global Initial Public Offerings (IPO) database, which provides comprehensive daily information on IPO transactions. The timeframe selected for analysis spans from January 1st, 2000 to October 31st, 2023. 

Our visualization includes 47 countries/regions in total, accounting for over 95% of the global IPO market, and our regression analysis covers 31 countries that represent over 90% of the market, given the availability of the selected macroeconomic factors. 

### Country- and Time-specific Macroeconomic Factors
To align with the scope of this study, various (monthly) macroeconomic variables have been chosen, some of which are identified as most relevant in the related literature. These include 
1. inflation (CPI),
2. unemployment rate (UE) as a proxy for the real status of the economy,
3. Monetary policy-related interest rate or short-term interest rate (STIR), indicative of the country-specific monetary policy stance, 
4. government bonds yield or long-term interest rate (LTIR), reflecting long-term financing costs in the local debt market, 
5. S&P 500 index (SP) and S&P 500 Industry Index (SPI), as measures of overall stock market performance and industry-specific stock market returns, and
6. market volatility index (VIX) as a proxy for investment risk.

## Methods 
### Libraries needed
#### Python
- yfinance: for scraping the S&P 500 index monthly returns
- pandas: for manipulating datasets
- matplotlib: for data visualizations
#### R
- ggplot2: for data visualizations
- readr: part of the tidyverse, for reading CSV files
- lubridate: for manipulating date-time data
- dplyr: part of the tidyverse, for data manipulation
- readxl: for reading Excel files

### Visualizations
- Time Series: offer size ($mm USD) for global IPO activities across time; S&P 500 indices performance across industry categories across time
- Heatmap: offer size ($mm USD) for global IPO activities across countries across time (by percentiles)
- Pie Chart: offer size ($mm USD) for the global IPO activities by sectors

### Regressions
- $y_it$: monthly IPO pop rates by country, defined by the percentage of offerings with a positive closing price for a specific country in a specific month
- $x_it$: inflation (CPI), unemployment rate, short-term interest rate, and long-term interest rate for a specific country in a specific month
*Notes: all variables are transformed to their 1st difference to ensure the stationarity of the variables.*

## Instructions
### Install libraries
#### Python
On Windows, use Command Prompt or PowerShell; on macOS or Linux, use the Terminal. Type the following commands, pressing Enter after each line:
- pip install yfinance
- pip install pandas
- pip install matplotlib
#### R
Open RStudio. In the console, type the following commands, pressing Enter after each line:
- install.packages("ggplot2")
- install.packages("readr")
- install.packages("lubridate")
- install.packages("dplyr")
- install.packages("readxl")
### Execute programs
Make sure all libraries are installed.
#### Global IPO Market visualizations
- Program: 
- File: ipo_raw.xlsx
- 
#### S&P 500 (industry) returns scraping & visualization
- Program: spx.py
- File: no file needed
- Open the program in an interpreter; execute the code: it will scrape all the S&P stock indices' monthly returns, write them into a CSV file, and create a time series plot for all of them.
*Notes: You will need to change the existing file path to the local path you want the CSV file to be written into.*
