# Docker file for Geekiness Survey
# Amy, Tyler, Maud,  April 2018

# use rocker/tidyverse as the base image and
FROM rocker/tidyverse


#install R packages
RUN Rscript -e "install.packages('glue', repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "install.packages('scales', repos = 'http://cran.us.r-project.org')"

#  install the ezknitr packages
RUN Rscript -e "install.packages('ezknitr', repos = 'https://mran.revolutionanalytics.com/snapshot/2017-12-11')"


# install git
RUN apt-get install -y wget
RUN apt-get install -y make git

### I've used previous docker images as a base
### Assuming we need Python

# install python 3
#RUN apt-get update \
#  && apt-get install -y python3-pip python3-dev \
#  && cd /usr/local/bin \
#  && ln -s /usr/bin/python3 python \
#  && pip3 install --upgrade pip

# get python package dependencies
#RUN apt-get install -y python3-tk

# install numpy
#RUN pip3 install numpy

## install pandas
#RUN pip3 install pandas

##install scipy
#RUN pip3 install scipy

##install sklearn
#RUN pip3 install sklearn
