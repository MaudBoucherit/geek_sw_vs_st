# Self-Identified Geekiness: How is that related to Star Wars or Star Trek fandom?
This project is investigating the influence of self-identified geekiness on Star Trek and Star Wars fandom.

## Survey
- How would you rate your degree of geekiness?

### Star Wars-related
![](images/sw_logo.png)
- How would you rate your degree of fandom?
- How would you rate your degree of knowledge about the Star Wars universe?
    - If rated 9: HARDCORE QUESTION

### Star Trek-related
![](images/st_logo.png)
- How would you rate your degree of fandom?
- How would you rate your degree of knowledge about the Star Trek universe?
    - If rated 9: HARDCORE QUESTION

### Star Wars Vs. Star Trek
- Overall, are you more familiar with Star Wars or Star Trek universe?
- You're stuck on a deserted island, with a TV and only one complete set of movies/TV episodes/books/games to entertain you for the rest of your life.

### Confounding Variables
- What is your age?
- What is your gender?
- Which continent would you identify yourself with?
- What is the main sector of your job/education background?
- Are you currently enrolled in the MDS program at UBC.

## About confounding variables
We decided to incorporate confounding variables gender, age, continent and sector of activity because we want to have information about who answered our survey so we can identify any possible bias in the sample.

## Analysis Strategy
Our main interest is in identifying the effect of self-identified geekiness to how much of a fan each participant is of Star Trek and Star Wars. We hypothesize that Star Trek will have a strong correlation with geekiness, whereas Star Wars will be more universal.

We also think that regardless of the above effect, participant's knowledge of the two series will strongly correlate with geekiness as well.

We plan to perform a series of hypothesis tests on the above effects, and perform a power analysis. Depending on the distribution of our data, we will determine which sort of hypothesis test is appropriate. We will correct our p-values using the Bonferroni correction, because we are not too concerned with the *type* of error we make, and so controlling FWER should be sufficient.

Finally, we are interested to see if geekiness correlates with a preference to a particular series. In order to test this we will try to fit some form of generalized linear model on a binary response (setting one series to 1 and the other to 0).

## Aspects of Ethics

After reading the UBC ethics code, we feel that our survey has no sensitive information, and we will not ask any personally identifying questions.  To this end, for age we will have the respondent choose from 10 year ranges.  Because of this, we feel confident enough to use Google forms as a vehicle.  As per UBC policy, we will have a paragraph (copied verbatim from the UBC page) informing the respondent that the information will be stored in a US server subject to homeland security, and have them click to acknowledge this.
