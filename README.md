# Self-Identified Geekiness: How is that related to Star Wars or Star Trek fandom?
This project is investigating the influence of self-identified geekiness on Star Trek and Star Wars fandom.

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)
[![License: MIT](https://img.shields.io/badge/License-MIT-cc0000.svg)](https://opensource.org/licenses/MIT)
[![Software: R](https://img.shields.io/badge/R%20Version-3.4-blue.svg)](https://cran.r-project.org/)


![](images/sw_vs_st.png)

The survey is located at [here](https://docs.google.com/forms/d/e/1FAIpQLSeqOI6W16UiiSh5LFngb5gjdM1ZHqsQ4zXytjOKEWQunqeUjA/viewform?usp=sf_link)

### To run

#### With Make
To run the full analysis, clone the full repository, and from the root use the command:

```
make all
```

To delete all the files, use the command:

```
make clean
```

#### With Docker

To avoid any software dependency errors, you might prefer like to work in a Docker container, you can locally build a Docker image by  navigating to the `geek_sw_vs_st` folder in your terminal and running the following command:

```
docker build --tag geek_sw_vs_st .

```

To run any of the scripts interactively, use
```
docker run --rm -it -v  C:\Path\to\cloned\repo:/home/geek_sw_vs_st geek_sw_vs_st  /bin/bash
```

To run the full script, use
```
docker run --rm -it -v  C:\Path\to\cloned\repo:/home/geek_sw_vs_st geek_sw_vs_st make -C 'home/geek_sw_vs_st' all
```

and to delete all of the new files:

```
docker run --rm -it -v  C:\Path\to\cloned\repo:/home/geek_sw_vs_st geek_sw_vs_st make -C 'home/geek_sw_vs_st' clean
```

Make sure to replace `C:\Path\to\cloned\repo` with the path to the cloned repo on your own computer.  If you are working with Windows PowerShell, be sure to check the direction of your backslashes.

### Software Dependencies
The analysis was performed with R 3.4.2.  

##### R packages used
* tidyverse
* cowplot
* scales
* MASS
* nnet (only if running the additional scripts.)
* ezknitr


##### Other tools
* make


### Contributing:

[![PRs Welcome](https://img.shields.io/badge/PRs-Welcome-brightgreen.svg)](http://makeapullrequest.com)

Feel free to help contribute code or other work to this project by first looking at our [contributing guidelines](CONTRIBUTING.md) and then submitting a pull request with your changes.
