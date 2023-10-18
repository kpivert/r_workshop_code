# User
# You are an experienced R programmer very fluent in the tidyverse and tidymodels. 
# Use the tidyverse to remove the redundancy of this code.

library(tidyverse)

# Fetching data and cleaning
data <- airquality %>%
 drop_na(Ozone, Solar.R, Wind, Temp, Month, Day)

# Analysis Part 1: Calculate average Solar Radiation for each month
avg_solar <- data %>%
 group_by(Month) %>%
 summarize(avg_solar = mean(Solar.R, na.rm = TRUE)) %>%
 mutate(Month = factor(Month, levels = 5:9, labels = c("May", "June", "July", "August", "September")))

# Print average Solar Radiation for each month
cat("Average Solar Radiation for Each Month:\n")
cat(paste(avg_solar$Month, avg_solar$avg_solar, sep = ": "), "\n")

# Analysis Part 2: Correlation between Ozone and Solar Radiation for each month
correlations <- data %>%
 group_by(Month) %>%
 summarize(correlation = cor(Ozone, Solar.R, use = "complete.obs")) %>%
 mutate(Month = factor(Month, levels = 5:9, labels = c("May", "June", "July", "August", "September")))

# Print correlations for each month
cat("Correlation for Each Month:\n")
cat(paste(correlations$Month, correlations$correlation, sep = ": "), "\n")

# Visualization
plot_shapes <- ifelse(correlations$correlation > 0.5, 19, 17)

# Save Plots
for (month in unique(avg_solar$Month)) {
 g <- ggplot(data %>% filter(Month == month), aes(x = Solar.R, y = Ozone, shape = factor(Month))) +
  geom_point() +
  ggtitle(month)
 ggsave(paste("plot_", tolower(month), ".png", sep = ""), g)
}

# Save data
write_csv(data, "cleaned_data.csv")


# Take Two

library(tidyverse)

# Fetching data
data <- airquality

# Data Cleaning - Remove rows with NA
data <- data %>%
 drop_na(Ozone, Solar.R, Wind, Temp, Month, Day)



# Take Three

library(tidyverse)

# Data Cleaning - Remove rows with NA
data <- airquality %>%
 drop_na(Ozone, Solar.R, Wind, Temp, Month, Day)

# Analysis Part 1: Calculate average Solar Radiation for each month
monthly_averages <- data %>%
 group_by(Month) %>%
 summarize(
  avg_solar = sum(Solar.R) / ifelse(Month %in% c(5, 7, 8), 31, 30)
 ) %>%
 mutate(Month = factor(Month, levels = 5:9, labels = c("May", "June", "July", "August", "September")))

# Print monthly averages
print(monthly_averages)



library(tidyverse)

# Data Cleaning - Remove rows with NA
data <- airquality %>%
 drop_na(Ozone, Solar.R, Wind, Temp, Month, Day)

# Analysis Part 1: Calculate average Solar Radiation for each month
monthly_averages <- data %>%
 group_by(Month) %>%
 summarize(
  avg_solar = sum(Solar.R) / ifelse(Month %in% c(5, 7, 8), 31, 30)
 ) %>%
 mutate(Month = factor(Month, levels = 5:9, labels = c("May", "June", "July", "August", "September"))) %>%
 ungroup() %>%
 print(n = 5)

monthly_averages


library(tidyverse)

# Data Cleaning - Remove rows with NA
data <- airquality %>%
 drop_na(Ozone, Solar.R, Wind, Temp, Month, Day)

# Analysis Part 1: Calculate average Solar Radiation for each month
monthly_averages <- data %>%
 group_by(Month) %>%
 summarize(
  avg_solar = sum(Solar.R) / ifelse(Month %in% c(5, 7, 8), 31, 30)
 ) %>%
 mutate(Month = factor(Month, levels = 5:9, labels = c("May", "June", "July", "August", "September"))) %>%
 reframe()

# Print monthly averages
print(monthly_averages)

Copy code
library(tidyverse)

# Data Cleaning - Remove rows with NA
data <- airquality %>%
 drop_na(Ozone, Solar.R, Wind, Temp, Month, Day)

# Analysis Part 1: Calculate average Solar Radiation for each month
monthly_averages <- data %>%
 group_by(Month) %>%
 summarize(
  avg_solar = sum(Solar.R) / sum(1, na.rm = TRUE)
 ) %>%
 mutate(Month = factor(Month, levels = 5:9, labels = c("May", "June", "July", "August", "September")))

# Print monthly averages
print(monthly_averages)


# To refactor the code using the tidyverse and return a tibble with the correlations for each month, you can use the following code:
 
#  R
# Copy code
library(tidyverse)

# Data Cleaning - Remove rows with NA
data <- airquality %>%
 drop_na(Ozone, Solar.R, Wind, Temp, Month, Day)

# Analysis Part 2: Correlation between Ozone and Solar Radiation for each month
correlation_data <- data %>%
 group_by(Month) %>%
 summarize(
  correlation = cor(Ozone, Solar.R, use = "complete.obs")
 ) %>%
 mutate(Month = factor(Month, levels = 5:9, labels = c("May", "June", "July", "August", "September")))

# Print tibble with correlations
print(correlation_data)

library(tidyverse)

# Data Cleaning - Remove rows with NA
data <- airquality %>%
 drop_na(Ozone, Solar.R, Wind, Temp, Month, Day)

# Save Plots
months <- c("May", "June", "July", "August", "September")

for (month in months) {
 g <- data %>%
  filter(Month == match(month, months)) %>%
  ggplot(aes(x = Solar.R, y = Ozone, shape = factor(Month))) +
  geom_point() +
  ggtitle(month)
 ggsave(paste("plot_", tolower(month), ".png", sep = ""), g)
}

# Save data
write_csv(data, "cleaned_data.csv")


library(tidyverse)

# Data Cleaning - Remove rows with NA
data <- airquality %>%
 drop_na(Ozone, Solar.R, Wind, Temp, Month, Day)

# Calculate plot shapes based on correlation
data <- data %>%
 mutate(
  plot_shapes = case_when(
   correlation_May > 0.5 ~ "19",
   correlation_June > 0.5 ~ "17",
   TRUE ~ "15"
  )
 )

# Save Plots
months <- c("May", "June", "July", "August", "September")

for (month in months) {
 plot_data <- data %>% filter(Month == match(month, months))
 g <- ggplot(plot_data, aes(x = Solar.R, y = Ozone, shape = factor(Month))) +
  geom_point() +
  ggtitle(month)
 ggsave(paste("plot_", tolower(month), ".png", sep = ""), g)
}

# Save data
write_csv(data, "cleaned_data.csv")

library(tidyverse)

# Data Cleaning - Remove rows with NA
data <- airquality %>%
 drop_na(Ozone, Solar.R, Wind, Temp, Month, Day)

# Assume you have calculated correlations (replace with actual values)
correlation_May <- 0.5
correlation_June <- 0.6
correlation_July <- 0.4
correlation_August <- 0.7
correlation_September <- 0.3

# Calculate plot shapes based on correlation
data <- data %>%
 mutate(
  plot_shapes = case_when(
   correlation_May > 0.5 ~ 19,
   correlation_June > 0.5 ~ 17,
   TRUE ~ 15
  )
 )

# Save Plots
months <- c("May", "June", "July", "August", "September")

for (month in months) {
 plot_data <- data %>% filter(Month == match(month, months))
 g <- ggplot(plot_data, aes(x = Solar.R, y = Ozone, shape = factor(Month))) +
  geom_point() +
  ggtitle(month)
 ggsave(paste("plot_", tolower(month), ".png", sep = ""), g)
}

# Save data
write_csv(data, "cleaned_data.csv")
