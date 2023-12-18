# DCS211 Final Project: Global IPO Market Exploration
#### By Ian, Jing, Sakina, Xinyi

## Goal 
We aim to visualize the dynamic global Initial Public Offerings (IPO) market in the 21st century and examine the influence of macroeconomic factors on the success of IPO activities from 2000 to 2023, a period marked by significant global events like the 2008 financial crisis and the COVID-19 pandemic. Employing Ordinary Least Squares (OLS) regressions and incorporating a range of macroeconomic variables, this project explores how economic indicators such as inflation, unemployment rates, interest rates, stock market performance, and market volatility impact IPO pop rates across 31 countries, accounting for over 90% of the global IPO market. 

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
- yfinance: package needed for scraping the S&P 500 index monthly returns
- pandas
#### R

### Visualization 
- Time Series: offer size ($mm USD) for global IPO activities across time
- Heatmap: offer size ($mm USD) for global IPO activities across time
- Pie Chart: offer size ($mm USD) for the global IPO activities by sectors

All non-default Python and/or R libraries needed.
Instructions for installing those libraries.
Clear and detailed instructions for how to execute your software.

Steps:
1. Visualization - create heatmaps for total offer size around the world
2. Other visualizations
3. clean the data - filter out columns for regression
4. After cleaning the data - Visualization (box plot - inflation and percentage of IPO pop)
5. Multivariate regression:
   - y: Offer to first close
   - x: S&P, cpi, unemployment rate
