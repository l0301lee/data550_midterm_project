all: output/days_stable_summary.csv output/discharge_status_counts.csv output/days_stable_boxplot.png output/discharge_status_barchart.png

output/days_stable_summary.csv output/discharge_status_counts.csv: src/analysis_outcome1.R data/f75_interim.csv
	Rscript src/analysis_outcome1.R

# Rule to generate days_stable_boxplot.png
output/days_stable_boxplot.png: src/analysis_outcome1.R data/f75_interim.csv
	Rscript src/analysis_outcome1.R

# Rule to generate discharge_status_barchart.png
output/discharge_status_barchart.png: src/analysis_outcome1.R data/f75_interim.csv
	Rscript src/analysis_outcome1.R


.PHONY: clean
clean:
	rm -f output/days_stable_summary.csv output/discharge_status_counts.csv output/days_stable_boxplot.png output/discharge_status_barchart.png