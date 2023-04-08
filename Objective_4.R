# Import the data for global confirmed cases
confirmed_url <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv"
confirmed_data <- read.csv(confirmed_url, header = TRUE, stringsAsFactors = FALSE)

# Import the data for global deaths
deaths_url <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv"
deaths_data <- read.csv(deaths_url, header = TRUE, stringsAsFactors = FALSE)

# Remove cruise ships from the confirmed cases data
confirmed_data <- confirmed_data[!(confirmed_data$Lat == 0 | is.na(confirmed_data$Lat)), ]
confirmed_data <- confirmed_data[!(confirmed_data$Long == 0 | is.na(confirmed_data$Long)), ]

# Remove cruise ships from the deaths data
deaths_data <- deaths_data[!(deaths_data$Lat == 0 | is.na(deaths_data$Lat)), ]
deaths_data <- deaths_data[!(deaths_data$Long == 0 | is.na(deaths_data$Long)), ]

# Filter both confirmed and deaths data to only include common countries
common_countries <- intersect(confirmed_data$Country.Region, deaths_data$Country.Region)
confirmed_cases <- confirmed_data[confirmed_data$Country.Region %in% common_countries, c("Country.Region", tail(names(confirmed_data), n = 1))]
deaths <- deaths_data[deaths_data$Country.Region %in% common_countries, c("Country.Region", tail(names(deaths_data), n = 1))]

# Calculate risk scores
risk_scores <- round(100 * deaths[, 2] / confirmed_cases[, 2], 2)

# Create data frame with country names and risk scores
risk_scores_df <- data.frame(Country = confirmed_cases$Country.Region, RiskScore = risk_scores)

# Sort risk scores by ascending order and select first row
lowest_risk <- risk_scores_df[order(risk_scores_df$RiskScore), ][1, ]

# If there are multiple areas with lowest risk, select the one with most confirmations
if (sum(!is.na(lowest_risk$Confirmations)) > 0) {
  lowest_risk <- lowest_risk[which(lowest_risk$Confirmations == max(lowest_risk$Confirmations, na.rm = TRUE)), ]
}

# Display the result
cat("The area with the lowest risk score is", lowest_risk$Country, "with a risk score of", lowest_risk$RiskScore, "and", lowest_risk$Confirmations, "confirmations.")

# Sort risk scores by descending order and select first row
highest_risk <- risk_scores_df[order(-risk_scores_df$RiskScore), ][1, ]

# If there are multiple areas with highest risk, select the one with most confirmations
if (sum(!is.na(highest_risk$Confirmations)) > 0) {
  highest_risk <- highest_risk[which(highest_risk$Confirmations == max(highest_risk$Confirmations, na.rm = TRUE)), ]
}

# Display the result
cat("The area with the highest risk score is", highest_risk$Country, "with a risk score of", highest_risk$RiskScore, "and", highest_risk$Confirmations, "confirmations.")

