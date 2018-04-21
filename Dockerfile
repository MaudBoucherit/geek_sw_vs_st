# Docker file for Geekiness Survey
# Amy, Tyler, Maud,  April 2018

# use rocker/tidyverse as the base image and
FROM rocker/tidyverse


# install R packages from cran
RUN Rscript -e "install.packages('glue', repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "install.packages('scales', repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "install.packages('cowplot', repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "install.packages('nnet', repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "install.packages('MASS', repos = 'http://cran.us.r-project.org')"

#  install the ezknitr packages
RUN Rscript -e "install.packages('ezknitr', repos = 'https://mran.revolutionanalytics.com/snapshot/2017-12-11')"


# install git
RUN apt-get install -y wget
RUN apt-get install -y make git

### I've used previous docker images as a base
