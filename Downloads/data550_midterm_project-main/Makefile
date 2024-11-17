all: output/mortality_table.csv output/adverse_events_table.csv output/muac_box_plot.png output/weight_box_plot.png

output/mortality_table.csv output/adverse_events_table.csv output/muac_box_plot.png output/weight_box_plot.png: src/secondary_outcomes_analysis.R data/f75_interim.csv
	Rscript src/secondary_outcomes_analysis.R