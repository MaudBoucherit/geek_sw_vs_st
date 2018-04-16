## Makefile

## Amy, Tyler and Maud

### Cleans the data and produces some EDA plots and....

##run top to bottom
all: doc/EDA.md doc/report.md

## clean data,
results/clean_data.csv:  src/data_wrang.R data/Geekiness_Survey.csv
	Rscript src/data_wrang.R data/Geekiness_Survey.csv

## create EDA plots,
eda_figs: src/image_ag.R results/clean_data.csv
	Rscript src/image_ag.R results/clean_data.csv

doc/EDA.md: src/EDA.Rmd eda_figs
	Rscript -e "ezknitr::ezknit('src/EDA.Rmd', out_dir = 'doc')"

doc/report.md: src/report.Rmd eda_figs
	Rscript -e "ezknitr::ezknit('src/report.Rmd', out_dir = 'doc')"


##clean up intermediate files.
clean:
	rm -f results/clean_data.csv
	rm -f results/figures/*.png
	rm -f doc/EDA.md
	rm -f doc/EDA.html
	rm -f doc/report.md
	rm -f doc/report.html
