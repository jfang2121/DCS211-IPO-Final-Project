import yfinance as yf
import pandas as pd

# Set the S&P 500 stock tickers to fetch
stocks = ['^SPX', # S&P 500
          '^SP500-15', # Basic Materials
          '^SP500-50', # Communications
          '^SP500-25', # Consumer, Cyclical
          '^SP500-30', # Consumer, Non-cyclical
          '^GSPE', # Energy
          '^SP500-40', # Financial
          '^SP500-20', # Industrial
          '^SP500-45', # Technology
          '^SP500-55', # Utilities
          ]
# Set the start and end date to match our dataset
start_date = '2000-01-01'
end_date = '2023-10-31'

# Create an empty DataFrame to store the adjusted close prices
combined_data = pd.DataFrame()

for stock in stocks:
    # Fetch the historical data
    data = yf.download(stock, start=start_date, end=end_date, interval='1mo')['Adj Close']

    # Create a Ticker object to fetch the long name
    ticker = yf.Ticker(stock)
    
    # Fetch the company's full name, default to the ticker symbol if not found
    company_name = ticker.info.get('longName', stock)

    # Rename the column to the company's full name and add to the combined DataFrame
    combined_data[company_name] = data

# Align the data by date
combined_data = combined_data.dropna(how='any')

# Export the combined data to CSV
combined_data.to_csv('/Users/Ximena/Desktop/DCS211/spx.csv')