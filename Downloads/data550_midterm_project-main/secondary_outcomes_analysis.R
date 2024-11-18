# Load required libraries
library(tidyverse)
library(ggplot2)
library(here)

# Load the dataset
here::i_am("secondary_outcomes_analysis.R")
data <- read.csv(here("data/f75_interim.csv"))

# 1. Mortality Analysis: Counts and Percentages
mortality_table <- data %>%
  filter(!is.na(withdraw2)) %>%
  group_by(withdraw2) %>%
  summarise(count = n()) %>%
  mutate(percentage = (count / sum(count)) * 100)

write.csv(mortality_table, here("output/mortality_table.csv"), row.names = FALSE)

mortality_plot <- ggplot(mortality_table, aes(x = withdraw2, y = count, fill = withdraw2)) +
  geom_bar(stat = "identity") +
  labs(title = "Mortality and Withdrawal Status", x = "Outcome", y = "Count") +
  theme_minimal() +
  scale_fill_brewer(palette = "Set3")

ggsave(here("output/mortality_bar_chart.png"), plot = mortality_plot)

# 2. Adverse Events Analysis: Counts and Percentages
adverse_events_table <- data %>%
  filter(!is.na(oedema2)) %>%
  group_by(oedema2) %>%
  summarise(count = n()) %>%
  mutate(percentage = (count / sum(count)) * 100)

write.csv(adverse_events_table, here("output/adverse_events_table.csv"), row.names = FALSE)

adverse_events_plot <- ggplot(adverse_events_table, aes(x = oedema2, y = count, fill = oedema2)) +
  geom_bar(stat = "identity") +
  labs(title = "Adverse Events: Oedema", x = "Oedema Status", y = "Count") +
  theme_minimal() +
  scale_fill_brewer(palette = "Set2")

ggsave(here("output/adverse_events_bar_chart.png"), plot = adverse_events_plot)

# 3. MUAC and Weight Changes
data <- data %>%
  mutate(
    muac_change = muac2 - muac,
    weight_change = weight2 - weight
  )

muac_box_plot <- ggplot(data, aes(y = muac_change)) +
  geom_boxplot(fill = "skyblue") +
  labs(title = "MUAC Change: Stabilization to Discharge", y = "MUAC Change (cm)") +
  theme_minimal()

weight_box_plot <- ggplot(data, aes(y = weight_change)) +
  geom_boxplot(fill = "tomato") +
  labs(title = "Weight Change: Stabilization to Discharge", y = "Weight Change (kg)") +
  theme_minimal()

ggsave(here("output/muac_box_plot.png"), plot = muac_box_plot)
ggsave(here("output/weight_box_plot.png"), plot = weight_box_plot)