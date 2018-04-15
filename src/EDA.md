Geekiness Exploratory Data Analysis
================
Amy Goldlist, Maud Boucherit, Tyler Roberts
April 14, 2018

``` r
suppressPackageStartupMessages(library(tidyverse))
```

    ## Warning: package 'tidyverse' was built under R version 3.4.4

    ## Warning: package 'tidyr' was built under R version 3.4.4

    ## Warning: package 'purrr' was built under R version 3.4.4

Introduction
------------

Our project seeks to explore the relationship between self-reported geekiness and a person's preference of Star Wars or Star Trek.

Methodology
-----------

We collected data using an online survey asking users about their familiarity and knowledge of both series, as well as some basic demographic information, and how geeky they consider themselves. A more complete discussion of our project proposal and plans for analysis can be found [here](../proposal.md).

### Exploratory Data Analysis

![](results/figures/desert_island-age.png)
<p>
The above figure breaks down each age group's choice of series. Since the 20-30 age group was by far the largest group of respondents to this survey, they dominate each of the three choices. That being said, they seem to make up fewer of those who would choose Star Trek, decreasing by roughly the same amount that the 30-40 group increased for this choice.

While the "Less than 20" group is one of the smallest, they have a larger than usual proportion among those who chose neither.

Finally, *nobody* among the 40-50 group chose to stare at the sand. &lt;&gt;

![](results/figures/desert_island-continent.png)
<p>
The above plot breaks down each continent's choice of series if they were stuck on a desert island. Most people who chose Star Trek as their preferred series were located in North America, while Star Wars fans are highly concentrated in Europe relative to the other regions. Asia had the highest proportion of people who would prefer to stare at the sand for all eternity.

When looking at these results, it is important to keep in mind that this plot does not capture the differences in total number of people who selected each series, so while most of the people who chose Star Trek identify as North Americans, the absolute number of these people is still lower than those from North America who chose Star Wars, and so on. &lt;&gt;

![](results/figures/desert_island-familiarity.png)

<p>
An interesting result from the above plot is that very few people who are most familiar with Star Trek chose Star Wars as their desert island series, whereas a large number of those who were more familiar with Star Wars chose Star Trek. However, those who reported being equally familiar with both seemed evenly split between the two groups.

Those who were not familiar with either series were mostly the ones who preferred to stare at the sand for eternity, and there were *zero* of those who were most familiar with Star Trek in that category.

&lt;&gt;

![](results/figures/desert_island-geekiness.png)

<p>
These plots show the distribution of self-identified geekiness facetted by the respondent's choice in series to have on a desert island.

Unsurprisingly, those who chose neither, who would prefer to stare out to sea or at patterns in the sand, generally rated themselves lower on the geekiness scale; with nearly 40% of such respondents rating themselves 1 or 2 out of 5, although the mode here appears to be a 3 as well. It is surprising that at least one person who rated themselves 5/5 in geekiness chose to watch neither of the series if stuck for eternity on a desert island.

Over 50% of those who chose Star Wars rated themselves a 3/5 on the geekiness scale although the distribution appears to be left skewed, with more people in this group rating themselves 4 than those rating themselves 2.

The mode for the Star Trek distribution was 4, unlike the other two groups. This might suggest that on average, people who prefer Star Trek are geekier, or at least consider themselves to be geeks more often. One way that we could formalize this more would be to measure the kurtosis in these distributions.

&lt;&gt;
