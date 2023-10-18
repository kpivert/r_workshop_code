# Loading necessary libraries
library(tidyverse)

# Fetching data
data <- airquality

# Data Cleaning - Remove rows with NA
data <- data %>%
 filter(!is.na(Ozone), !is.na(Solar.R), !is.na(Wind), !is.na(Temp), !is.na(Month), !is.na(Day))

# Define a function to calculate the average Solar Radiation for each month
calculate_average_solar <- function(data, month) {
 data %>%
  filter(Month == month) %>%
  summarise(Average_Solar_Radiation = mean(Solar.R, na.rm = TRUE))
}

# Calculate average Solar Radiation for each month
avg_solar_may <- calculate_average_solar(data, 5)
avg_solar_june <- calculate_average_solar(data, 6)
avg_solar_july <- calculate_average_solar(data, 7)
avg_solar_august <- calculate_average_solar(data, 8)
avg_solar_september <- calculate_average_solar(data, 9)

# Print the results
print(paste("Average Solar Radiation for May: ", avg_solar_may$Average_Solar_Radiation))
print(paste("Average Solar Radiation for June: ", avg_solar_june$Average_Solar_Radiation))
print(paste("Average Solar Radiation for July: ", avg_solar_july$Average_Solar_Radiation))
print(paste("Average Solar Radiation for August: ", avg_solar_august$Average_Solar_Radiation))
print(paste("Average Solar Radiation for September: ", avg_solar_september$Average_Solar_Radiation))

# Define a function to calculate the correlation between Ozone and Solar Radiation for each month
calculate_correlation <- function(data, month) {
 data %>%
  filter(Month == month) %>%
  summarise(Correlation = cor(Ozone, Solar.R, use = "complete.obs"))
}

# Calculate correlation for each month
correlation_may <- calculate_correlation(data, 5)
correlation_june <- calculate_correlation(data, 6)
correlation_july <- calculate_correlation(data, 7)
correlation_august <- calculate_correlation(data, 8)
correlation_september <- calculate_correlation(data, 9)

# Print the results
print(paste("Correlation for May: ", correlation_may$Correlation))
print(paste("Correlation for June: ", correlation_june$Correlation))
print(paste("Correlation for July: ", correlation_july$Correlation))
print(paste("Correlation for August: ", correlation_august$Correlation))
print(paste("Correlation for September: ", correlation_september$Correlation))

# Define a function to save plots
save_monthly_plot <- function(data, month, filename) {
 plot_data <- data %>%
  filter(Month == month)
 
 g <- ggplot(plot_data, aes(x = Solar.R, y = Ozone, shape = factor(Month))) +
  geom_point() +
  ggtitle(month)
 
 ggsave(filename, g)
}

# Save plots for each month
save_monthly_plot(data, 5, "plot_may.png")
save_monthly_plot(data, 6, "plot_june.png")
save_monthly_plot(data, 7, "plot_july.png")
save_monthly_plot(data, 8, "plot_august.png")
save_monthly_plot(data, 9, "plot_september.png")

# Save data
write.csv(data, "cleaned_data.csv", row.names = FALSE)


# Take Two with purrr ----

# Loading necessary libraries
library(tidyverse)

# Fetching data
data <- airquality

# Data Cleaning - Remove rows with NA
data <- data %>%
 filter(!is.na(Ozone), !is.na(Solar.R), !is.na(Wind), !is.na(Temp), !is.na(Month), !is.na(Day))

# Define a function to calculate the average Solar Radiation for each month
calculate_average_solar <- function(data, month) {
 data %>%
  filter(Month == month) %>%
  summarise(Average_Solar_Radiation = mean(Solar.R, na.rm = TRUE))
}

# Calculate average Solar Radiation for each month using purrr::map_dbl
months <- 5:9
avg_solar <- map_dbl(months, ~ calculate_average_solar(data, .x)$Average_Solar_Radiation)

# Print the results
map2(months, avg_solar, ~ cat("Average Solar Radiation for Month", .x, ":", .y, "\n"))

# Define a function to calculate the correlation between Ozone and Solar Radiation for each month
calculate_correlation <- function(data, month) {
 data %>%
  filter(Month == month) %>%
  summarise(Correlation = cor(Ozone, Solar.R, use = "complete.obs"))
}

# Calculate correlation for each month using purrr::map_dbl
correlation <- map_dbl(months, ~ calculate_correlation(data, .x)$Correlation)

# Print the results
map2(months, correlation, ~ cat("Correlation for Month", .x, ":", .y, "\n"))

# Define a function to save plots
save_monthly_plot <- function(data, month, filename) {
 plot_data <- data %>%
  filter(Month == month)
 
 g <- ggplot(plot_data, aes(x = Solar.R, y = Ozone, shape = factor(Month))) +
  geom_point() +
  ggtitle(paste("Month", month))
 
 ggsave(filename, g)
}

# Save plots for each month using purrr::walk
map2(months, c("May", "June", "July", "August", "September"), ~ save_monthly_plot(data, .x, paste("plot_", .x, ".png")))

# Save data
write.csv(data, "cleaned_data.csv", row.names = FALSE)
