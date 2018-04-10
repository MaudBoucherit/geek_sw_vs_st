## Makefile

## Amy, Tyler and Maud

### Cleans the data and....

##run top to bottom
all: results/clean_data.csv

## clean data,
results/clean_data.csv:  src/data_wrang.R
	Rscript src/data_wrang.R data/Geekiness_Survey.csv





##clean up intermediate files.
clean:
	rm -f results/clean_data.csv
