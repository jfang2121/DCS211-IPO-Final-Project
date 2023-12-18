import pandas as pd
import geopandas as gpd
import matplotlib.pyplot as plt
import plotly.express as px
import pycountry
import numpy as np
import statsmodels.api as sm

def alpha2_to_alpha3(alpha2):
    try:
        return pycountry.countries.get(alpha_2=alpha2).alpha_3
    except Exception:
        # Handle cases where the two-letter code is not found
        return None
    

file_path = "dcs211_final_data.xlsx"
df = pd.read_excel(file_path)
#print(df)
'''
aggregated_data = df.groupby('Country/Region ISO Code')['Offer Size (M)'].sum().reset_index()

aggregated_data['Country/Region ISO Code 3'] = aggregated_data['Country/Region ISO Code'].apply(alpha2_to_alpha3)

world = gpd.read_file(gpd.datasets.get_path('naturalearth_lowres'))

world_merged = world.merge(aggregated_data, how='left', left_on='iso_a3', right_on='Country/Region ISO Code 3')

fig, ax = plt.subplots(1, 1, figsize=(15, 10))
world_merged.plot(column='Offer Size (M)', ax=ax, legend=True, cmap='OrRd', 
                  missing_kwds={'color': 'lightgrey'})
plt.title('IPO Offer Size by Country')
plt.show()

'''


#Plotting World Map
aggregated_data = df.groupby('Country/Region ISO Code')['Offer Size (M)'].sum().reset_index()
aggregated_data['Country/Region ISO Code 3'] = aggregated_data['Country/Region ISO Code'].apply(alpha2_to_alpha3)
aggregated_data = aggregated_data.dropna(subset=['Country/Region ISO Code 3'])

fig = px.choropleth(
    aggregated_data,
    locations="Country/Region ISO Code 3",
    color="Offer Size (M)",
    hover_name="Country/Region ISO Code",
    color_continuous_scale=px.colors.sequential.Viridis_r,  # Reversed Viridis color scale
    title='IPO Offer Size by Country'
)


fig.update_layout(
    geo=dict(
        showcoastlines=True, coastlinecolor="RebeccaPurple",
        showland=True, landcolor="LightGreen",
        showocean=True, oceancolor="LightBlue",
        showlakes=True, lakecolor="Blue", 
        showrivers=True, rivercolor="Blue"
    ),
    coloraxis_colorbar=dict(
        title="Offer Size (M)"
    )
)


fig.show()

#clean data and convert into panel data

country_keep=["Australia", "Brazil", "Canada", "China", "Denmark", "France", 
                     "Germany", "Greece", "India", "Indonesia", "Ireland", "Israel", 
                     "Italy", "Japan", "Malaysia", "Netherlands", "New Zealand", "Norway", 
                     "Poland", "Russia", "Singapore", "South Africa", "South Korea", "Spain", 
                     "Sweden", "Switzerland", "Thailand", "Turkey", "Britain", 
                     "United States", "Vietnam"]
country_keep = [element.upper() for element in country_keep]


df_clean = df[df['Country/Region Full Name'].isin(country_keep)]
df_clean= df_clean[df_clean['Offer Type'].str.contains("IPO")==True]

df_clean= df_clean[['Effective Date','Country/Region Full Name','Offer To 1st Close','Offer To Month 1']]
df_clean = df_clean.dropna(subset=['Offer To 1st Close', 'Offer To Month 1'], how='all')
#change Britain to United Kindom
df_clean['Country/Region Full Name'] = df_clean['Country/Region Full Name'].replace('BRITAIN', 'UNITED KINGDOM')

#print(df_clean['Offer To 1st Close'].isna().any())
df_clean['first day pop'] = np.where(df_clean['Offer To 1st Close'].isna(), np.nan, 
                                     (df_clean['Offer To 1st Close'] > 0).astype(int))
df_clean['first month pop'] = np.where(df_clean['Offer To Month 1'].isna(), np.nan,
                                       (df_clean['Offer To Month 1'] > 0).astype(int))

df_clean['Effective Date'] = pd.to_datetime(df_clean['Effective Date'])

#df_clean['Year'] = df_clean['Effective Date'].dt.year
#df_clean['Month'] = df_clean['Effective Date'].dt.month


df_clean['Month-Year'] = df_clean['Effective Date'].dt.to_period('M')
#print(df_clean)



# Group by Country and Month-Year
panel_df = df_clean.groupby(['Country/Region Full Name', 'Month-Year']).agg({
    'first day pop': lambda x: (x.sum() / x.count()) * 100  # Calculates the percentage
}).reset_index()

panel_df = panel_df.sort_values(by=['Country/Region Full Name', 'Month-Year'])
panel_df['Country/Region Full Name'] = panel_df['Country/Region Full Name'].str.upper()
panel_df.rename(columns = {'first day pop':'first day pop%'}, inplace = True)
#print(panel_df)

#merge the panel data with the macroeconomic indicator excel
file_path2 = "ifs_vf.xlsx"
macro_df = pd.read_excel(file_path2)

macro_df['mon'] = macro_df['mon'].astype(str)

# Extract year and month, and format them
macro_df['Year'] = macro_df['mon'].str[:4]
macro_df['Month'] = macro_df['mon'].str[5:].str.zfill(2)  # Pad single-digit months with a leading zero

macro_df['Month-Year'] = macro_df['Year'] + '-' + macro_df['Month']
macro_df['Month-Year'] = pd.to_datetime(macro_df['Month-Year']).dt.to_period('M')
macro_df.rename(columns={'country': 'Country/Region Full Name'}, inplace=True)
macro_df['Country/Region Full Name'] = macro_df['Country/Region Full Name'].str.upper()
macro_df = macro_df.drop('ip', axis=1)

#print(macro_df)
#print(macro_df)
merged_df = pd.merge(panel_df, macro_df, on=['Country/Region Full Name', 'Month-Year'], how='outer')
#pd.set_option('display.max_columns', None)
#print(merged_df)

merged_df.sort_values(by=['Country/Region Full Name', 'Month-Year'], inplace=True)

print(merged_df)
print(merged_df.columns)

# Calculate the first difference
for column in ['first day pop%', 'ir_lt', 'ir_st', 'ue', 'cpi']:
    merged_df[f'{column}_diff'] = merged_df.groupby('Country/Region Full Name')[column].diff()

pd.set_option('display.max_columns', None)
print(merged_df)

df_filtered = merged_df.dropna(subset=['first day pop%_diff', 'ir_lt_diff', 'ir_st_diff', 'ue_diff', 'cpi_diff'])

#OLS
y = df_filtered['first day pop%_diff']

# Define the independent variables
X = df_filtered[['ir_lt_diff', 'ir_st_diff', 'ue_diff', 'cpi_diff']]
X = sm.add_constant(X)

model = sm.OLS(y, X).fit()


print(model.summary())

