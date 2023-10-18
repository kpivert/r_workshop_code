---
editor_options: 
  markdown: 
    wrap: 72
---

## Loading necessary libraries

-   **Required Packages:** `tidyverse`
-   **Inputs:** None
-   **Outputs:** None

```{r}

library(tidyverse)
```

## Fetching Data

Required Packages: None Inputs: None Outputs: data - a data frame
containing the airquality dataset R Copy code data \<- airquality Data
Cleaning - Remove Rows with NA Required Packages: None Inputs: data - a
data frame containing the airquality dataset Outputs: data - a cleaned
data frame with NA rows removed R Copy code data \<- data %\>%
filter(!is.na(Ozone), !is.na(Solar.R), !is.na(Wind), !is.na(Temp),
!is.na(Month), !is.na(Day)) Calculate Average Solar Radiation for Each
Month Required Packages: tidyverse Inputs: data - a data frame
containing the airquality dataset, month - the month for which to
calculate the average Outputs: A numeric value representing the average
Solar Radiation for the specified month R Copy code
calculate_average_solar \<- function(data, month) { data %\>%
filter(Month == month) %\>% summarise(Average_Solar_Radiation =
mean(Solar.R, na.rm = TRUE)) } Calculate Average Solar Radiation for
Each Month Using purrr::map_dbl Required Packages: tidyverse, purrr
Inputs: months - a vector of months (e.g., c(5, 6, 7, 8, 9) Outputs:
avg_solar - a numeric vector of average Solar Radiation values for each
month R Copy code months \<- 5:9 avg_solar \<- map_dbl(months, \~
calculate_average_solar(data,
.x)$Average_Solar_Radiation) Print the Results Required Packages: None Inputs: months - a vector of months (e.g., c(5, 6, 7, 8, 9), avg_solar - a numeric vector of average Solar Radiation values Outputs: None R Copy code map2(months, avg_solar, ~ cat("Average Solar Radiation for Month", .x, ":", .y, "\n")) Calculate Correlation for Each Month Required Packages: tidyverse Inputs: data - a data frame containing the airquality dataset, month - the month for which to calculate the correlation Outputs: A numeric value representing the correlation between Ozone and Solar Radiation for the specified month R Copy code calculate_correlation <- function(data, month) { data %>% filter(Month == month) %>% summarise(Correlation = cor(Ozone, Solar.R, use = "complete.obs")) } Calculate Correlation for Each Month Using purrr::map_dbl Required Packages: tidyverse, purrr Inputs: months - a vector of months (e.g., c(5, 6, 7, 8, 9) Outputs: correlation - a numeric vector of correlation values for each month R Copy code correlation <- map_dbl(months, ~ calculate_correlation(data, .x)$Correlation)
Print the Results Required Packages: None Inputs: months - a vector of
months (e.g., c(5, 6, 7, 8, 9), correlation - a numeric vector of
correlation values Outputs: None R Copy code map2(months, correlation,
\~ cat("Correlation for Month", .x, ":", .y, "\n")) Define a Function to
Save Plots Required Packages: tidyverse Inputs: data - a data frame
containing the airquality dataset, month - the month for which to save
the plot, filename - the filename for the saved plot Outputs: None R
Copy code save_monthly_plot \<- function(data, month, filename) {
plot_data \<- data %\>% filter(Month == month)

g \<- ggplot(plot_data, aes(x = Solar.R, y = Ozone, shape =
factor(Month))) + geom_point() + ggtitle(paste("Month", month))

ggsave(filename, g) } Save Plots for Each Month Using purrr::walk
Required Packages: tidyverse, purrr Inputs: months - a vector of months
(e.g., c(5, 6, 7, 8, 9), month_names - a vector of month names (e.g.,
c("May", "June", "July", "August", "September") Outputs: None R Copy
code map2(months, c("May", "June", "July", "August", "September"), \~
save_monthly_plot(data, .x, paste("plot\_", .x, ".png"))) Save Data
Required Packages: None Inputs: data - a data frame to be saved,
filename - the filename for the saved CSV Outputs: None R Copy code
write.csv(data, "cleaned_data.csv", row.names = FALSE) The comments
describe the purpose of each function, the required packages, and the
inputs and outputs of each function. This documentation should make the
code more understandable and maintainable.
