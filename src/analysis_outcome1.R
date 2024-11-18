library(ggplot2)
library(here)
here::i_am("src/analysis_outcome1.R")
# Load data
data <- read.csv(here::here("data", "f75_interim.csv"))

data$arm<- factor(
  data$arm
)

data$discharge_status <- factor(
  data$discharged2,
  levels = c(0, 1),
  labels = c("No", "Yes")
)

length(data$days_stable)
length(data$arm)
# **1. Median Days to Stabilization and Statistical Comparison**
# Calculate group-wise median and IQR

# Calculate group-wise median and IQR for days_stable
days_stable_summary <- aggregate(
  days_stable ~ arm, 
  data = data, 
  FUN = function(x) c(median = median(x, na.rm = TRUE), iqr = IQR(x, na.rm = TRUE))
)

days_stable_summary <- do.call(data.frame, days_stable_summary)
colnames(days_stable_summary) <- c("intervention_group", "median_days", "iqr_days")
days_stable_summary

# Perform Mann-Whitney U Test
mann_whitney_test <- wilcox.test(
  days_stable ~ arm, 
  data = data
)

write.csv(
  days_stable_summary, 
  here::here("output", "days_stable_summary.csv"),
  row.names = FALSE
)

# **2. Discharge Status Counts and Proportions**
# Create contingency table

discharge_status_counts <- table(data$arm, data$discharged2)
discharge_status_proportions <- prop.table(discharge_status_counts, 1)

# Save Discharge Status Table
write.csv(
  as.data.frame.matrix(discharge_status_counts), 
  here::here("output", "discharge_status_counts.csv"),
  row.names = TRUE
)

# **3. Visualizations**
# Box plot for days_stable
plot<-ggplot(data, aes(x = arm, y = days_stable, fill = arm)) +
  geom_boxplot() +
  labs(
    title = "Days to Stabilization by Intervention Group",
    x = "Intervention Group",
    y = "Days to Stabilization"
  ) +
  theme_minimal()+ ylim(0, 30) 

ggsave(
  filename = here::here("output", "days_stable_boxplot.png"),
  plot = plot,
  width = 7, 
  height = 7
)

# Bar chart for discharge outcomes
discharge_df <- as.data.frame(as.table(discharge_status_counts))
colnames(discharge_df) <- c("Group", "DischargeStatus", "Count")

discharge_plot<-ggplot(discharge_df, aes(x = Group, y = Count, fill = DischargeStatus)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(
    title = "Discharge Outcomes by Intervention Group",
    x = "Intervention Group",
    y = "Count",
    fill = "Discharge Status"
  ) +
  theme_minimal() 

ggsave(
  filename = here::here("output", "discharge_status_barchart.png"),
  plot = discharge_plot,
  width = 8, 
  height = 6
)

# **4. Outputs**
# Print summaries
print("Days to Stabilization Summary:")
print(days_stable_summary)
print("Mann-Whitney U Test Results:")
print(mann_whitney_test)

print("Discharge Status Counts:")
print(discharge_status_counts)
