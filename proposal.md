# Self-Identified Geekiness: How is that related to Star Wars or Star Trek fandom?
This project is investigating the influence of self-identified geekiness on Star Trek and Star Wars fandom.

## Methodology
We collected data using an online survey asking users about their familiarity and knowledge of both series, as well as some basic demographic information, and how geeky they consider themselves. The online survey can be found [here](https://goo.gl/forms/Jb3pCN6GVhqziVvt1), and the questions are summarised in this proposal:

### Self-Identified Geekiness
- How would you rate your degree of geekiness?
    - From (1) not geeky at all to (5) super geeky

### Star Wars-related
![](images/sw_logo.png)
- How would you rate your degree of fandom?
    - From (1) I hate it! to (5) I even love the prequels!
- How would you rate your degree of knowledge about the Star Wars universe?
    - From (1) no knowledge at all to (5) expert knowledge
    - If rated 5: People are redirected to a hardcore question about Star Wars:
        > Who first uttered the line "It's a trap!" and in what film?

### Star Trek-related
![](images/st_logo.png)
- How would you rate your degree of fandom?
    - From (1) I hate it! to (5) I even love Wrath of Khan!
- How would you rate your degree of knowledge about the Star Trek universe?
    - From (1) no knowledge at all to (5) expert knowledge
    - If rated 5: People are redirected to a hardcore question about Star Trek:
        > According to Klingon mythology, what is the place where all life began?

### Star Wars Vs. Star Trek
![](images/sw_vs_st.png)

- Overall, are you more familiar with Star Wars or Star Trek universe?
    - Answers are: Star Wars, Star Trek, Both, Neither
- You're stuck on a deserted island, with a TV and only one complete set of movies/TV episodes/books/games to entertain you for the rest of your life.  Which do you choose?
    - Answers are: Star Wars, Star Trek, Neither: I will stare at the sand for the rest of my life rather than choose a quality science fiction series to watch.

### Confounding Variables
- What is your age?
    - Below 20, In my 20s, In my 30s, In my 40s, 50 or older
- What is your gender?
    - Female, Male, Non-binary, Prefer not to say, Other…
- Which continent would you identify yourself with?
    - North America, South America, Asia, Europe, Africa, Oceania, Antarctica
- What is the main sector of your job/education background?
    - Tech, Finance/Economics/Business, A, ministration/Education, Biology/Medicine, Chemistry/Physics, Math/Statistics, Other…
- Are you currently enrolled in the MDS program at UBC?

## About confounding variables

We decided to incorporate confounding variables gender, age, continent and sector of activity because we want to have information about who answered our survey so we can identify any possible bias in the sample.

We plan to look at relationships between our response and explanatory variables and these confounding variables in order to decrease any bias. To do so, we want to stratify our survey's answers according to a propensity score. 

## Analysis Strategy

Our main interest is in identifying the effect of self-identified geekiness to how much of a fan each participant is of Star Trek and Star Wars. We hypothesize that Star Trek will have a strong correlation with geekiness, whereas Star Wars will be more universal.

We also think that regardless of the above effect, participant's knowledge of the two series will strongly correlate with geekiness as well.

We plan to perform a series of hypothesis tests on the above effects, and perform a power analysis. Depending on the distribution of our data, we will determine which sort of hypothesis test is appropriate. We will correct our p-values using the Bonferroni correction, because we are not too concerned with the type of error we make, and so controlling FWER should be sufficient.

For the analysis, the answers to the Desert Island question are our response Y. The explanatory variables X are: the self-identified geekiness, how familiar/knowledgable one is of Star Wars and how familiar/knowledgable one is of Star Trek. We are interested in exploring if propensity score matching would be a good way to mitigate the effect of our confounding variables C, particularly since we have uneven group sizes.

The final model should be an ordinal regression of Y on X and C.


## Aspects of Ethics

After reading the UBC ethics code, we feel that our survey has no sensitive information, and we will not ask any personally identifying questions.  To this end, for age we will have the respondent choose from 10 year ranges.  Because of this, we feel confident enough to use Google forms as a vehicle.  As per UBC policy, we will have a paragraph (copied verbatim from the UBC page) informing the respondent that the information will be stored in a US server subject to homeland security, and have them click to acknowledge this.
