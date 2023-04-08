library ("geosphere")

# How far away are the areas from objective 2 from where the first confirmed case(s) occurred?

first_city_confirmation_index <- which.max(covid_confirmations$X1.22.20)

area_df <- data.frame(Long = covid_confirmations$Long[which(covid_confirmations$X3.9.23 > covid_confirmations$X3.8.23)]
                      ,Lat = covid_confirmations$Lat[which(covid_confirmations$X3.9.23 > covid_confirmations$X3.8.23)])

area_df_matrix <- as.matrix(area_df)

# Hubei Coordinates

First_City_Coords <- data.frame(Long = covid_confirmations$Long[first_city_confirmation_index]
                           ,Lat = covid_confirmations$Lat[first_city_confirmation_index]) 

First_City_Coords_matrix <- as.matrix(Hubei_Coords)

# Find distance between cities
# Use function distm
# distm(x, y)

dist <- distm(area_df_matrix, First_City_Coords_matrix)

# Convert from meters to miles

dist_miles <- round(dist/1609.34, 2)


# Please print the following:
# {recent region} is {distance in miles} away from {origin city, origin country}

distance_from_origin <- data.frame(City = covid_confirmations$Province.State[which(covid_confirmations$X3.9.23 > covid_confirmations$X3.8.23)]
                                   ,Country = covid_confirmations$Country.Region[which(covid_confirmations$X3.9.23 > covid_confirmations$X3.8.23)]
                                   ,Distance = dist_miles)

for(i in 1:length(distance_from_origin$City)) {
  print(paste(distance_from_origin$City[i], distance_from_origin$Country[i], " is ", 
              distance_from_origin$Distance[i], "miles away from", 
              covid_confirmations$Province.State[first_city_confirmation_index], 
              covid_confirmations$Country.Region[first_city_confirmation_index]))
}


