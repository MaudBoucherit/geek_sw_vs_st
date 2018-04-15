## Makefile

## Amy, Tyler and Maud

### Cleans the data and produces some EDA plots and....

##run top to bottom
all: eda_figs

## clean data,
clean_data:  src/data_wrang.R data/Geekiness_Survey.csv
	Rscript src/data_wrang.R data/Geekiness_Survey.csv

## create EDA plots,
eda_figs: src/image_ag.R results/clean_data.csv
	Rscript src/image_ag.R results/clean_data.csv

eda_report: results/EDA.Rmd eda_figs
	Rscript -e "ezknitr::ezknit('results/EDA.Rmd')"


##clean up intermediate files.
clean:
	rm -f results/clean_data.csv
	rm -f results/figures/*.png
