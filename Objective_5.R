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
