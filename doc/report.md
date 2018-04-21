---
title: "Report"
author: "Amy Goldlist, Maud Boucherit, Tyler Roberts"
date: "April 16, 2018"
output:
  html_document: 
    keep_md: yes
---



## Introduction

The series "Star Wars" and "Star Trek" attract a lot of comparison, possibly because they both start with the word "Star", the series "Star Wars" and "Star Trek".  In our personal experience, we feel that the geekier a person

## Methodology

We collected data using an [online survey](https://goo.gl/forms/Jb3pCN6GVhqziVvt1) asking users about their familiarity and knowledge of both series, as well as some basic demographic information, and how geeky they consider themselves.

### survey study design

The main question we were concerned with was whether a person's choice of Star Wars or Star Trek is correlated with their self-reported geekiness.  In order to tease out whether the choice had to do with how familiar they were with the series, we also asked respondents to rank their knowledge and familiarity about the series on a scale from 1 to 5.  In order to differentiate if the 5s were truly fans, we had a separate skill testing question that was only triggered if respondents answered 5 to the knowledge questions.

As well, we asked basic demographic questions, such as age, gender, employment sector, continent and whether or not they were an MDS student.

Finally, we used humour in our questions in order to keep respondents engaged and forwarding the survey.  


### data collection methods

We collected data by distributing an online survey.  We ditributed the survey through three main channels:

- 1 All UBC MDS students completed the survey during designated class time

- 2 We sent the survey to all [Maud put program name in here].  Since this program is in France, we hoped to get a more multicultural sample.

- 3 We posted it on Facebook and let Facebook's algorithm ahare as it would.  We later found that our survey was circulated around a Vancouver Game company.  In order to get it to the top of Facebook feeds, we attempted to game their algorithm using the following text: "She said yes! It's twins!!! Here's one little trick, Congrats!! (now that I've hopefully gamed the algorithm enough to get to the top of your feed). Feel like filling out a survey? I promise not to steal your data, and you'd be having fun and helping me with a project."  

It should be noted that this method of sampling falls squarely under the header of "convenience sampling", and our sample is skewed towards the tech community.  

### Aspects of Ethics

After reading the UBC ethics code, we feel that our survey has no sensitive information, and we will not ask any personally identifying questions.  To this end, for age we will have the respondent choose from 10 year ranges.  Because of this, we feel confident enough to use Google forms as a vehicle.  As per UBC policy, we will have a paragraph (copied verbatim from the UBC page) informing the respondent that the information will be stored in a US server subject to homeland security, and have them click to acknowledge this.


### the survey

#### Self-Identified Geekiness
- How would you rate your degree of geekiness?
    - From (1) not geeky at all to (5) super geeky

#### Star Wars-related
![](../images/sw_logo.png)
- How would you rate your degree of fandom?
    - From (1) I hate it! to (5) I even love the prequels!
- How would you rate your degree of knowledge about the Star Wars universe?
    - From (1) no knowledge at all to (5) expert knowledge
    - If rated 5: People are redirected to a hardcore question about Star Wars:
        > Who first uttered the line "It's a trap!" and in what film?

#### Star Trek-related
![](../images/st_logo.png)


- How would you rate your degree of fandom?
    - From (1) I hate it! to (5) I even love Wrath of Khan!
- How would you rate your degree of knowledge about the Star Trek universe?
    - From (1) no knowledge at all to (5) expert knowledge
    - If rated 5: People are redirected to a hardcore question about Star Trek:
        > According to Klingon mythology, what is the place where all life began?

#### Star Wars Vs. Star Trek
![](../images/sw_vs_st.png)

- Overall, are you more familiar with Star Wars or Star Trek universe?
    - Answers are: Star Wars, Star Trek, Both, Neither
- You're stuck on a deserted island, with a TV and only one complete set of movies/TV episodes/books/games to entertain you for the rest of your life.  Which do you choose?
    - Answers are: Star Wars, Star Trek, Neither: I will stare at the sand for the rest of my life rather than choose a quality science fiction series to watch.

#### Confounding Variables
- What is your age?
    - Below 20, In my 20s, In my 30s, In my 40s, 50 or older
- What is your gender?
    - Female, Male, Non-binary, Prefer not to say, Other…
- Which continent would you identify yourself with?
    - North America, South America, Asia, Europe, Africa, Oceania, Antarctica
- What is the main sector of your job/education background?
    - Tech, Finance/Economics/Business, A, ministration/Education, Biology/Medicine, Chemistry/Physics, Math/Statistics, Other…
- Are you currently enrolled in the MDS program at UBC?


### analysis methods
We decided to incorporate confounding variables gender, age, continent and sector of activity because we want to have information about who answered our survey so we can identify any possible bias in the sample.

We plan to look at relationships between our response and explanatory variables and these confounding variables in order to decrease any bias. To do so, we want to stratify our survey's answers according to a propensity score. 

Methods we explored are logistic regression, both binomial and multinomial, and propensity score matching.

## results and analysis


### Exploratory Data Analysis

If you would like to see the R analysis to produce there plots, please see [this Rscript](../src/image_ag.R).  As part of our analysis, we looked at relationships between our response and explanatory variables and various other responses.  Here are teh highlights of that analysis.  All of the analysis below is based on a sample of 174 respondants to our survey.  


#### Age and Desert Island Choice

![](../results/figures/desert_island-age.png)
<p>
The above figure breaks down each age group's choice of series. Since the 20-30 age group was by far the largest group of respondents to this survey, they dominate each of the three choices. That being said, they seem to make up fewer of those who would choose Star Trek, decreasing by roughly the same amount that the 30-40 group increased for this choice.

While the "Less than 20" group is one of the smallest, they have a larger than usual proportion among those who chose neither.

Finally, *nobody* among the 40-50 group chose to stare at the sand.

Given these results, we feel that it would be prudent to include age as a confounding variable in our analysis.
<\p>

#### Continent and Desert Island Choice

![](../results/figures/desert_island-continent.png)
<p>
The above plot breaks down each continent's choice of series if they were stuck on a desert island.  Most people who chose Star Trek as their preferred series were located in North America, while Star Wars fans are highly concentrated in Europe relative to the other regions. Asia had the highest proportion of people who would prefer to stare at the sand for all eternity. 

When looking at these results, it is important to keep in mind that this plot does not capture the differences in total number of people who selected each series, so while most of the people who chose Star Trek identify as North Americans, the absolute number of these people is still lower than those from North America who chose Star Wars, and so on.

Given this effect, continent is another confounder that will be included in our analysis.
<\p>

#### Familiarity and Desert Island Choice

![](../results/figures/desert_island-familiarity.png)

<p>
It makes intuitive sense that a person's familiarity with various series would influence their choice of series, and indeed it seems to be so.

An interesting result from the above plot is that very few people who are most familiar with Star Trek chose Star Wars as their desert island series, whereas a large number of those who were more familiar with Star Wars chose Star Trek. However, those who reported being equally familiar with both seemed evenly split between the two groups. 

Those who were not familiar with either series were mostly the ones who preferred to stare at the sand for eternity, and there were *zero* of those who were most familiar with Star Trek in that category.  Familiarity is another confounder which we choose to include in our analysis.

<\p>

#### Geekiness and Desert Island Choice

![](../results/figures/desert_island-geekiness.png)

<p>
These plots show the distribution of self-identified geekiness facetted by the respondent's choice in series to have on a desert island.

Unsurprisingly, those who chose neither, who would prefer to stare out to sea or at patterns in the sand, generally rated themselves lower on the geekiness scale; with nearly 40% of such respondents rating themselves 1 or 2 out of 5, although the mode here appears to be a 3 as well. It is surprising that at least one person who rated themselves  5/5 in geekiness chose to watch neither of the series if stuck for eternity on a desert island.

Over 50% of those who chose Star Wars rated themselves a 3/5 on the geekiness scale although the distribution appears to be left skewed, with more people in this group rating themselves 4 than those rating themselves 2.

The mode for the Star Trek distribution was 4, unlike the other two groups. This might suggest that on average, people who prefer Star Trek are geekier, or at least consider themselves to be geeks more often. One way that we could formalize this more would be to measure the kurtosis in these distributions.

This is where we will focus our attention in our analysis, in explaining the differing shapes of these distributions.

<\p>


## discussion of  results

## discussion of  survey/study design

In our original survey, we did not leave a space for "the arts" under employment sector.  As a result, we had a lot of write in "other" categories, thus making analysis difficult. We also chose to narrow our focus to Star Trek vs Star Wars, and not include other science fiction series, such as "Doctor Who".  This did annoy some of our respondents, who did not want to choose.  As well, some respondents felt that we should have dealt with the "geek vs nerd" dichotomy, which is not something we have an opinion on, but apprantly people do.