## Makefile

## Amy, Tyler and Maud

### Cleans the data and produces some EDA plots and....

##run top to bottom
all: results/figures/

## clean data,
results/clean_data.csv:  src/data_wrang.R data/Geekiness_Survey.csv
	Rscript src/data_wrang.R data/Geekiness_Survey.csv

## create EDA plots,
results/figures/: src/image_ag.R results/clean_data.csv
	Rscript src/image_ag.R results/clean_data.csv




##clean up intermediate files.
clean:
	rm -f results/clean_data.csv
	rm -f results/figures/*.png
