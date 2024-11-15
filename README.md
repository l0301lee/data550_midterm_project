# F75 Project: Data Analysis and Reporting Plan

## Project Overview
This project analyzes data from a randomized trial assessing the effectiveness of a modified milk formula (f75) intended to improve outcomes for children with severe acute malnutrition. This analysis includes data from the first six months of a year-long study, focusing on baseline characteristics, primary outcomes, and secondary outcomes.

## Team and Responsibilities
- **Team Lead:** June Yun  
  - Responsibilities: Organize the project structure, maintain configuration settings, set up the GitHub repository, handle all merging and pull requests, and integrate each coder's output into the final report.

- **Coders:**
  - **Drashti Maisuria**  
    - Focus: Baseline Characteristics and Health Conditions
    - Tasks: Provide descriptive statistics for baseline characteristics (e.g., age, sex, weight, height) and clinical conditions (e.g., diarrhea, Kwashiorkor, TB, HIV status). Output includes summary tables and visualizations (histograms and bar plots).
  
  - **Shuting Mao**  
    - Focus: Primary Outcome - Days to Stabilization and Discharge Status
    - Tasks: Analyze days to stabilization (days_stable) and compare it between intervention groups. Examine discharge status (discharge2) for planned discharges. Output includes comparison tables, statistical tests, and visualizations (box plots, pie/bar charts).
  
  - **Tianchen He**  
    - Focus: Secondary Outcomes - Mortality and Adverse Events
    - Tasks: Examine mortality and adverse events, including changes in mid-upper arm circumference (muac) and weight from stabilization to discharge. Output includes tables with counts/percentages and visualizations (bar charts, box plots).

Each coder will ensure that their code is modular, well-documented, and easy to integrate into the final report.

## Dataset
- **Data File:** `f75_interim.csv`
- **Data Dictionary:** `f75_codebook.xlsx`
- **Dataset Description:** This dataset contains information from a randomized trial assessing the effectiveness of a modified milk formula (f75) for children with severe acute malnutrition. The dataset includes baseline characteristics, primary outcomes, and secondary outcomes for the first six months of the study.

## Project Structure
The project is organized as follows:

project/
├── data/                       # Contains raw data and codebook
│   ├── f75_interim.csv
│   └── f75_codebook.xlsx
├── src/                        # Analysis scripts
│   ├── main_report.Rmd         # Main R Markdown report
│   ├── analysis_baseline.R     # Coder 1's baseline analysis
│   ├── analysis_outcome1.R     # Coder 2's outcome analysis
│   ├── analysis_outcome2.R     # Coder 3's outcome analysis
│   └── helpers.R               # Helper functions for analyses
├── config/                     # Configuration settings
│   └── config.yaml             # Config file to control report parameters
├── output/                     # Directory for the generated report
│   └── report.html             # Final report
├── Makefile                    # Makefile for automating report generation
└── README.md                   # Documentation of the project

- **Coder Code and Output:** Each coder’s script is saved in `src/`, and all tables/figures are outputted within the `output/` folder.
- **Final Report:** The integrated final report (`report.html`) will reside in `output/`.
- **Miscellaneous Code:** Utility functions for reuse across analyses are stored in `helpers.R`.

## Customization
The report is fully customizable via the `config.yaml` file, allowing quick adaptation to new data or specific analysis requirements. Customizable elements include:

- **Data Subsets:** Filter specific demographics or time ranges.
- **Outcome Selection:** Prioritize primary or secondary outcomes.
- **Plot Themes:** Configure color themes and plot aesthetics for presentation alignment.

Changes made to the `config.yaml` file automatically update the report without further code modifications, ensuring the report’s adaptability for future updates.

## How to Run
1. Clone the repository.
2. Place the `f75_interim.csv` and `f75_codebook.xlsx` files in the `data/` folder.
3. Modify `config/config.yaml` as needed for customization.
4. Run `make` in the project root directory to generate the report.

## Requirements
- **R**: Required for running the analysis scripts.
- **Make**: For automating the report generation.
- **R Packages**: Ensure the required R packages are installed (e.g., `tidyverse`, `ggplot2`, `knitr`, etc.).

## License
This project is licensed under the MIT License.

---

For more details, please refer to the `config.yaml` file and individual analysis scripts in the `src/` directory.