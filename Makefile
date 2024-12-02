# Makefile for automating the report generation

# Define directories
SRC_DIR := src
OUTPUT_DIR := output
DATA_DIR := data

# Define scripts and report
BASELINE_SCRIPT := $(SRC_DIR)/analysis_baseline.R
OUTCOME1_SCRIPT := $(SRC_DIR)/analysis_outcome1.R
OUTCOME2_SCRIPT := $(SRC_DIR)/analysis_outcome2.R
REPORT_RMD := $(SRC_DIR)/main_report.Rmd
REPORT_HTML := $(OUTPUT_DIR)/report.html

# Default target
all: $(REPORT_HTML)

# Install project dependencies using renv
install:
	Rscript -e "renv::restore()"

# Create output directory if it doesn't exist
$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

# Run baseline analysis
baseline: $(BASELINE_SCRIPT) | $(OUTPUT_DIR)
	Rscript $<

# Run outcome analysis 1
outcome1: $(OUTCOME1_SCRIPT) | $(OUTPUT_DIR)
	Rscript $<

# Run outcome analysis 2
outcome2: $(OUTCOME2_SCRIPT) | $(OUTPUT_DIR)
	Rscript $<

# Knit the final report
$(REPORT_HTML): $(REPORT_RMD) baseline outcome1 outcome2 | $(OUTPUT_DIR)
	Rscript -e "rmarkdown::render('$<', output_file = '../$@')"

# Clean up generated files
clean:
	rm -rf $(OUTPUT_DIR)
