# Load the CSV files for COVID-19 data
confirmed_cases <- read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv", stringsAsFactors = FALSE)
deaths <- read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv", stringsAsFactors = FALSE)

# Extract the country names from the data frames
countries <- unique(confirmed_cases$Country.Region)

# Initialize empty lists for the sums of confirmed cases and deaths
confirmed_sums <- list()
death_sums <- list()

# Calculate the sums of confirmed cases and deaths for each country
for (country in countries) {
  confirmed_sums[[country]] <- sum(confirmed_cases[confirmed_cases$Country.Region == country, -(1:4)])
  death_sums[[country]] <- sum(deaths[deaths$Country.Region == country, -(1:4)])
}
# Convert the sums into data frames
confirmed_df <- data.frame(Country = names(confirmed_sums), Confirmed = unlist(confirmed_sums))
death_df <- data.frame(Country = names(death_sums), Deaths = unlist(death_sums))

# Sort the data frames by the values of confirmed cases and deaths, respectively
confirmed_df <- confirmed_df[order(-confirmed_df$Confirmed),]
death_df <- death_df[order(-death_df$Deaths),]

# Select the top 5 countries with the most confirmed cases and deaths
top_5_confirmed <- head(confirmed_df, 5)
top_5_deaths <- head(death_df, 5)




