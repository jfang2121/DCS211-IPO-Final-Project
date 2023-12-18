# DCS211 Final Project: Global IPO Market Exploration
#### By Ian, Jing, Sakina, Xinyi

## Goal 
We aim to visualize the dynamic global Initial Public Offerings (IPO) market in the 21st century and examine the influence of macroeconomic factors on the success of IPO activities from 2000 to 2023, a period marked by significant global events like the 2008 financial crisis and the COVID-19 pandemic. Employing Ordinary Least Squares (OLS) and fixed-effect panel data regressions and incorporating a range of macroeconomic variables, this project explores how economic indicators such as inflation, unemployment rates, and interest rates impact IPO pop rates, the rates of having a positive closing price. 

## Scope
### Global IPO Market
The IPO data for this study was sourced from Bloomberg’s Global Initial Public Offerings (IPO) database, which provides comprehensive daily information on IPO transactions. The timeframe selected for analysis spans from January 1st, 2000 to October 31st, 2023. 

Our visualization includes 47 countries/regions in total, accounting for over 95% of the global IPO market, and our regression analysis covers 31 countries that represent over 90% of the market, given the availability of the selected macroeconomic factors. 

### Country- and Time-specific Macroeconomic Factors
To align with the scope of this study, various (monthly) macroeconomic variables have been chosen, some of which are identified as most relevant in the related literature. These include 
1. inflation (CPI),
2. unemployment rate (UE) as a proxy for the real status of the economy,
3. Monetary policy-related interest rate or short-term interest rate (STIR), indicative of the country-specific monetary policy stance, 
4. government bonds yield or long-term interest rate (LTIR), reflecting long-term financing costs in the local debt market, and
5. S&P 500 index (SP) and S&P 500 Industry Index (SPI), as measures of overall stock market performance and industry-specific stock market returns.

*Notes: 1-4 are used as independent variables in the regression analyses; 5 is plotted separately to add to the visualization of the global IPO market.*

## Methods 
### Libraries needed
#### Python
- yfinance: for scraping the S&P 500 index monthly returns
- pandas: for manipulating datasets
- matplotlib: for data visualizations
- geopandas: for working with geospatial data
- plotly: for create interactive graphs 
- pycountry: for accessing ISO-standardized country, language, and currency data
- numpy: for scientific computing 
- statsmodels: for statistical modeling
- linearmodels: for estimating linear models
#### R
- ggplot2: for data visualizations
- readr: part of the tidyverse, for reading CSV files
- lubridate: for manipulating date-time data
- dplyr: part of the tidyverse, for data manipulation
- readxl: for reading Excel files
- pacman: for loading multiple packages at once or installing missing packages on the fly
- string: for handling character-based data
- broom: for turning model objects into tidy data frames

### Visualizations
- Time Series: offer size ($mm USD) for global IPO activities across time; S&P 500 indices performance across industry categories across time
- Heatmap: offer size ($mm USD) for global IPO activities across countries across time (by percentiles)
- Pie Chart: offer size ($mm USD) for the global IPO activities by sectors

### Regressions
- $y_it$: monthly IPO pop rates by country, defined by the percentage of offerings with a positive closing price (for the 1st date and 1st month) for a specific country in a specific month
- $x_it$: inflation (CPI), unemployment rate, short-term interest rate, and long-term interest rate for a specific country in a specific month

*Notes: all variables are transformed to their 1st difference to ensure the stationarity of the variables.*

## Instructions

### Install libraries
#### Python
On Windows, use Command Prompt or PowerShell; on macOS or Linux, use the Terminal. Type the following commands, pressing Enter after each line:
- pip install yfinance
- pip install pandas
- pip install matplotlib
- pip install geopandas
- pip install plotly
- pip install pycountry
- pip install numpy
- pip install statsmodels
- pip install linearmodels

#### R
Open RStudio. In the console, type the following commands, pressing Enter after each line:
- install.packages("ggplot2")
- install.packages("readr")
- install.packages("lubridate")
- install.packages("dplyr")
- install.packages("readxl")
- install.packages("pacman")
- install.packages("string")
- install.packages("broom")

### Execute programs
Make sure all libraries are installed.

#### Global IPO market visualizations in R
- Program(s): Timeseries.R, Heatmap.R, Heatmap_percentiles.R, Piechart.R
- Data: ipo_raw.xlsx (for global IPO data)
- Open the R files in RStudio; execute the code: the files will generate the respective visualizations.

*Notes: You will need to change the file path(s) in the program to the local path your data file is in.*

#### Global IPO market visualization in Python (interactive map)
- Program(s): dcs211_map_plotting.py
- Data: ipo_raw.xlsx (for global IPO data)
- Open the Python file in an interpreter; execute the code. It will generate an interactive world map with the total IPO volume (the sum of all the individual offer sizes) for each available country in the dataset. 

*Notes: You will need to change the file path(s) in the program to the local path your data file is in.*

#### S&P 500 (industry) indices returns scraping & visualization
- Program(s): spx.py
- Data: no file needed
- Open the Python file in an interpreter; execute the code. It will:
1. scrape all the S&P stock (industry) indices' monthly returns from January 2000 to October 2023 (ideally it will scrape through the whole period, but sometimes it stops at December 1st, 2021 because of the API constraints)
2. write them into a CSV file, and
3. create a time series plot that includes all of them.

*Notes: You will need to change the file path(s) in the program to the local path you want the CSV file to be written into.*

#### Regressions in Python
- Program(s): dcs211_pythpn_reg.py
- Data: ipo_raw.xlsx (for global IPO data), ifs_vf.xlsx (for macroeconomic data)
- Open the Python file in an interpreter; execute the code. It will:
1. clean the IPO raw data to match with the available macroeconomic data;
2. merge the IPO dataset with the macroeconomic dataset;
3. generate a binary variable that takes on 1 for positive closing prices, and 0 for negative ones;
4. calculate the IPO pop rates by country by month and transform the data into a monthly panel dataset by country;
5. run OLS and fixed-effect (by time and country) panel data regressions on IPO pop rates by 1st closing prices and 1st-month closing prices and generate regression tables.

*Notes: You will need to change the file path(s) in the program to the local path your data files are in.*

#### Regressions in R
- Program(s): cleanData.R
- Data: ipo_raw.xlsx (for global IPO data), ifs_vf.xlsx (for macroeconomic data)
- Open the R files in RStudio; execute the code. It will:
1. clean the IPO raw data to match with the available macroeconomic data;
2. merge the IPO dataset with the macroeconomic dataset;
3. generate a binary variable that takes on 1 for positive closing prices, and 0 for negative ones;
4. calculate the IPO pop rates by country by month and transform the data into a monthly panel dataset by country;
5. run OLS panel data regressions and generate a regression table as an HTML file;
6. plot IPO pop rates with each macroeconomic factor.

*Notes: You will need to change the file path(s) in the program to the local path your data files are in.*
