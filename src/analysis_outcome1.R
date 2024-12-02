# Load required libraries
library(ggplot2)
library(here)
library(dplyr)

# Set working directory reference for the script
here::i_am("src/analysis_outcome1.R")

# Load the data
data <- read.csv(here("data", "f75_interim.csv"))

# Convert relevant variables to factors
data$arm <- factor(data$arm)
data$discharge_status <- factor(
  data$discharged2,
  levels = c(0, 1),
  labels = c("No", "Yes")
)

# Check data consistency
cat("Length of days_stable:", length(data$days_stable), "\n")
cat("Length of arm:", length(data$arm), "\n")

# **1. Median Days to Stabilization and Statistical Comparison**
# Calculate group-wise median and IQR for days_stable
days_stable_summary <- data %>%
  group_by(arm) %>%
  summarise(
    median_days = median(days_stable, na.rm = TRUE),
    iqr_days = IQR(days_stable, na.rm = TRUE)
  )

# Perform Mann-Whitney U Test
mann_whitney_test <- wilcox.test(days_stable ~ arm, data = data)

# Save summary and test results
write.csv(
  days_stable_summary, 
  here("output", "days_stable_summary.csv"), 
  row.names = FALSE
)

# Print summaries
cat("Days to Stabilization Summary:\n")
print(days_stable_summary)
cat("\nMann-Whitney U Test Results:\n")
print(mann_whitney_test)

# **2. Discharge Status Counts and Proportions**
# Create contingency table and proportions
discharge_status_counts <- table(data$arm, data$discharged2)
discharge_status_proportions <- prop.table(discharge_status_counts, 1)

# Save discharge status counts
write.csv(
  as.data.frame.matrix(discharge_status_counts), 
  here("output", "discharge_status_counts.csv"),
  row.names = TRUE
)

# Print discharge status counts
cat("\nDischarge Status Counts:\n")
print(discharge_status_counts)

# **3. Visualizations**

# Boxplot for days_stable
days_stable_boxplot <- ggplot(data, aes(x = arm, y = days_stable, fill = arm)) +
  geom_boxplot() +
  labs(
    title = "Days to Stabilization by Intervention Group",
    x = "Intervention Group",
    y = "Days to Stabilization"
  ) +
  theme_minimal() +
  ylim(0, 30)

ggsave(
  filename = here("output", "days_stable_boxplot.png"),
  plot = days_stable_boxplot,
  width = 7,
  height = 7
)

# Bar chart for discharge outcomes
discharge_df <- as.data.frame(as.table(discharge_status_counts))
colnames(discharge_df) <- c("Group", "DischargeStatus", "Count")

discharge_status_barchart <- ggplot(discharge_df, aes(x = Group, y = Count, fill = DischargeStatus)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(
    title = "Discharge Outcomes by Intervention Group",
    x = "Intervention Group",
    y = "Count",
    fill = "Discharge Status"
  ) +
  theme_minimal()

ggsave(
  filename = here("output", "discharge_status_barchart.png"),
  plot = discharge_status_barchart,
  width = 8,
  height = 6
)

# **4. Outputs**
cat("\nAnalysis Complete. Outputs saved in the 'output/' directory.\n")
