## Most recent area to have a confirmed case
## Use a for loop, if statement, and subsets.

recent_confirmations <- c()

for (i in 1:nrow(covid_confirmations)) {
  if (covid_confirmations$X3.9.23[i] > covid_confirmations$X3.8.23[i]) {
    recent_confirmations <- c(recent_confirmations,covid_confirmations$Country.Region[i])
   }
}

print(recent_confirmations)

#R Solution
#recent_confirmations <- paste(covid_confirmations$Province.State[which(covid_confirmations$X3.9.23 > covid_confirmations$X3.8.23)], 
#                              covid_confirmations$Country.Region[which(covid_confirmations$X3.9.23 > covid_confirmations$X3.8.23)])




      

