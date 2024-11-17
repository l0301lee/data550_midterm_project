all: output/mortality_table.csv output/adverse_events_table.csv output/muac_box_plot.png output/weight_box_plot.png

output/mortality_table.csv output/adverse_events_table.csv output/muac_box_plot.png output/weight_box_plot.png: secondary_outcomes_analysis.R data/f75_interim.csv
	Rscript /Users/catherine/Downloads/data550_midterm_project-main/secondary_outcomes_analysis.R