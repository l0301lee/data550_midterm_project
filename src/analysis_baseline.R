# Load required libraries
library(tidyverse)
library(here)

# Load data
filepath <- here("data", "f75_interim.csv")
df <- read.csv(filepath)

# Summarize numerical variables
numerical_detailed <- df %>%
  summarise(
    age_mean = mean(agemons, na.rm = TRUE),
    age_sd = sd(agemons, na.rm = TRUE),
    weight_mean = mean(weight, na.rm = TRUE),
    weight_sd = sd(weight, na.rm = TRUE),
    height_mean = mean(height, na.rm = TRUE),
    height_sd = sd(height, na.rm = TRUE)
  )

# Save numerical summary to output directory
write.csv(numerical_detailed, here("output", "numerical_summary.csv"), row.names = FALSE)

# Summarize categorical variables: Diarrhea, Kwashiorkor, TB, and HIV status
diarrhea_summary <- df %>%
  summarise(
    diarrhea_count = table(diarrhoea),
    diarrhea_percentage = prop.table(table(diarrhoea)) * 100
  )

kwashiorkor_summary <- df %>%
  summarise(
    kwashiorkor_count = table(kwash),
    kwashiorkor_percentage = prop.table(table(kwash)) * 100
  )

TB_summary <- df %>%
  summarise(
    TB_count = table(tb),
    TB_percentage = prop.table(table(tb)) * 100
  )

HIV_status_summary <- df %>%
  summarise(
    HIV_status_count = table(hiv_results),
    HIV_status_percentage = prop.table(table(hiv_results)) * 100
  )

# Combine categorical summaries into a list for output
categorical_summaries <- list(
  diarrhea = diarrhea_summary,
  kwashiorkor = kwashiorkor_summary,
  TB = TB_summary,
  HIV_status = HIV_status_summary
)

# Save categorical summaries as separate CSV files
write.csv(data.frame(diarrhea_summary), here("output", "diarrhea_summary.csv"), row.names = FALSE)
write.csv(data.frame(kwashiorkor_summary), here("output", "kwashiorkor_summary.csv"), row.names = FALSE)
write.csv(data.frame(TB_summary), here("output", "TB_summary.csv"), row.names = FALSE)
write.csv(data.frame(HIV_status_summary), here("output", "HIV_status_summary.csv"), row.names = FALSE)

# Print summaries to console
print("Numerical Summary:")
print(numerical_detailed)

print("Diarrhea Summary:")
print(diarrhea_summary)

print("Kwashiorkor Summary:")
print(kwashiorkor_summary)

print("TB Summary:")
print(TB_summary)

print("HIV Status Summary:")
print(HIV_status_summary)

