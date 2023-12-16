import pandas as pd
import geopandas as gpd
import matplotlib.pyplot as plt
import plotly.express as px
import pycountry


def alpha2_to_alpha3(alpha2):
    try:
        return pycountry.countries.get(alpha_2=alpha2).alpha_3
    except Exception:
        # Handle cases where the two-letter code is not found
        return None
    

file_path = "dcs211_final_data.xlsx"
df = pd.read_excel(file_path)
'''

# Group and aggregate the data by country code
aggregated_data = df.groupby('Country/Region ISO Code')['Offer Size (M)'].sum().reset_index()

# Convert the two-letter country codes to three-letter codes in the aggregated data
aggregated_data['Country/Region ISO Code 3'] = aggregated_data['Country/Region ISO Code'].apply(alpha2_to_alpha3)

# Load the GeoPandas world geometries
world = gpd.read_file(gpd.datasets.get_path('naturalearth_lowres'))

# Merge the aggregated data with the world geometries
world_merged = world.merge(aggregated_data, how='left', left_on='iso_a3', right_on='Country/Region ISO Code 3')

# Plotting
fig, ax = plt.subplots(1, 1, figsize=(15, 10))
world_merged.plot(column='Offer Size (M)', ax=ax, legend=True, cmap='OrRd', 
                  missing_kwds={'color': 'lightgrey'})
plt.title('IPO Offer Size by Country')
plt.show()

'''



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