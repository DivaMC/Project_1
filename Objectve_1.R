# Get csv files from CSSEGISandData/COVID-19 database

covid_confirmations <- read.csv("https://raw.githubusercontent.com/DivaMC/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv", stringsAsFactors=FALSE)

covid_deaths <- read.csv("https://raw.githubusercontent.com/DivaMC/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv", stringsAsFactors=FALSE)

covid_recoveries <- read.csv("https://raw.githubusercontent.com/DivaMC/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_recovered_global.csv", stringsAsFactors=FALSE)


# Find greatest number of deaths on first day

for(i in covid_deaths$X1.22.20) {
  if(i > 0) {
    print(i)
  }
}

max(covid_deaths$X1.22.20)
first_city_deaths <- covid_deaths$Province.State[which.max(covid_deaths$X1.22.20)]


# Find greatest number of confirmed cases on first day

max(covid_confirmations$X1.22.20)
first_city_confirmations <- covid_confirmations$Province.State[which.max(covid_confirmations$X1.22.20)]


# Find and print city of origin

if (first_city_deaths == first_city_confirmations) {
  covid_city_origin <- first_city_confirmations
}

print(covid_city_origin)

