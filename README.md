# validating-two-linked-fates

**Identifying and validating multiple interpretations of linked fate**

## Overview

This project investigates how people interpret linked fate, a major measure of group consciousness in identity politics. Dawson's [*Behind the Mule*](https://books.google.com/books?hl=en&lr=&id=0-I9DwAAQBAJ&oi=fnd&pg=PP11&ots=sEoMI1VStP&sig=NLmBqid3hZa2GKO1lpMvSPdYTQo#v=onepage&q&f=false) (1994) argues that African Americans remain a cohesive racial group despite the growing within-group economic inequality, because the centuries-long experience of racial discrimination ties their individual and group utility together. He called this connection "linked fate", and since then, linked fate has become a popular measure of group solidarity across diverse group contexts (a Google Scholar search yields [more than 2700 results](https://scholar.google.com/scholar?hl=en&as_sdt=0%2C5&q=%22linked+fate%22&btnG=)).

In this project, [Alan Yan](https://politics.princeton.edu/people/alan-yan) and I argue the linked fate literature has a measure problem. Scholars have measured the expressed strength of linked fate by asking survey respondents to what extent they agree that what happens to their group also influences their life. The issue is people may think about that connection in two different ways: **linked progress** and **linked hurt**. Linked progress is a positive mechanism which suggests that an individual thinks they progress when their group progresses. Linked hurt is a negative mechanism which indicates that an individual thinks that they get hurt when their group gets hurt. According to Dawson's black utility heuristics theory, the linked hurt interpretation is more plausible because discrimination is the driving force. But how do we know?

Using a California-wide survey data (N = 4,435) and novel measures of linked fate, we demonstrated how distinguishing these interpretations matter for the empirical study of identity politics.

1. Linked progress, on average, scored higher than linked hurt across all racial groups, including African Americans. This finding was inconsistent with Dawson's original theory.
2. People expressed stronger group consciousness when they were asked about it through the standard linked fate question. White group consciousness disappeared when we used more specific linked fate questions. This finding raised a question about how white group politics are different from those of other racial groups.

## Research design

### Hypothesis

The standard way of measuring linked fate is to ask the following question to the survey participants:

- **Linked fate**: Do you agree or disagree? What happens to (Latinos/whites/blacks and African Americans/Asians/Pacific Islanders/American Indians) in this country will have something to do with what happens in my life.

In addition to using this standard measure, we added two novel measures of linked fate that determine whether linked fate is interpreted in the context of a positive or a negative relationship between group and individual utility.

- **Linked progress**: Do you agree or disagree? When things get better for (Latinos/whites/blacks and African Americans/Asians/Pacific Islanders/American Indians) in this country, then things will get better for me.
- **Linked hurt**: Do you agree or disagree? When things get worse for (Latinos/whites/blacks and African Americans/Asians/Pacific Islanders/ American Indians) in this country, then things will get worse for me.

Our main hypotheses were as follows:
1. Linked fate, linked progress, and linked hurt will yield statistically different levels of responses.
2. If the measure is consistent with Dawson's theory, linked hurt will be more strongly correlated with linked hurt than linked progress responses, especially among African Americans (convergent validity).

### Data collection

We tested this hypothesis by embedding the above three questions in a California-wide survey (n = 4,435), carried out by the Institute of Government Studies at the University of California Berkeley in June 2019.

- Random sampling: Random sampling was used based on publicly available email addresses in voter records as a sampling frame (see this [link](https://www.latimes.com/politics/la-na-pol-2020-how-poll-was-done-20190613-story.html) for more information on their sampling methods and this [link](https://sda.berkeley.edu/sdaweb/docs/IGS_2019_02/DOC/hcbkfx0.htm) for list of items used in the survey).
- Random ordering: These questions were randomly ordered to accout for order bias.
- Multiple choices: The responses to these questions were collected using four multiple choices (1 - Agree strongly, 2 - Agree somewhat, 3 - Disagree somewhat, 4 - Disagree strongly).

## Workflow

In the rest of the document, I describe how I have **cleaned**, **analyzed**, and **visualized** data. I have shared the R code I used in each step.

### Data cleaning \[[Code](https://github.com/jaeyk/validating-two-linked-fates/blob/master/code/01_data_cleaning.Rmd)]

- I recoded linked fate-related questions as follows: `4-strongly positive, 3-somewhat positive, 2- somewhat negative, 1-strongly negative`. This scale made it easier to interpret the results.
- I identified missing responses from linked fate questions, which represented 5–6% of the responses, and inputted them using multiple additions (the `mice` package in R).
- I only included participants who identified as white, African American, Latinx, and Asian American. Consequently, I dropped 150 participants (3% of the total number of participants) who were non-identified using these measures.

### Data analysis and visualization \[[Code](https://github.com/jaeyk/validating-two-linked-fates/blob/master/code/02_data_analysis.Rmd)]

#### Measures of Central Tendency

![](https://github.com/jaeyk/validating-two-linked-fates/blob/master/outputs/descriptive_stat_plot.png)
Figure 1. Mean and Standard Errors

In Figure 1, the x-axis indicates the average score of responses to linked fate-related questions. The y-axis charts different racial groups. The mean describes the central tendency of the responses. The limitation is that it does not show how these data points are spread. For that reason, I also included the standard errors, which are indicated by the error bars. One side of the error bar indicates two standard errors. 

Figure 1 clearly demonstrates how the use of a different measure for linked fate yields a different level of response. Overall, the standard linked fate question drew the strongest expressed support for linked fate. On average, linked progress scored higher than linked hurt across all racial groups, including African Americans. These results do not necessarily mean that Dawson's theory is wrong because the data also provides evidence for the presence of linked hurt. However, the theory has failed to include the importance of linked progress mechanisms and its prevalence.

#### Bar plots

![](https://github.com/jaeyk/validating-two-linked-fates/blob/master/outputs/bar_plot.png)
Figure 2. Descriptive analysis

In Figure 2, the x-axis indicates the multi-choices offered in the linked fate questions. The y-axis plots the count of these choices. This more detailed look at the data reveals several interesting patterns.

The pattern for the responses to the linked fate questions among African American respondents is consistent with the prediction of the black utility heuristics theory. The distribution is skewed left. It shows almost unanimous support for black solidarity.

However, the same respondents became more skeptical when they were asked about the specific connection between their group and individual utility. We can see similar patterns across other racial groups, with white respondents’ answers representing an extreme example. In that case, the respondents began to disagree with the idea of white group consciousness more than they agreed with it.

#### Correlation tests

As the next step, I examined the correlation between the standard and nobel linked fate measures. The theory predicts that the responses of the standard linked fate measure should covary more closely with the responses of the linked hurt measure than with those of the linked progress measure. This hypothesis was not true across all racial groups except whites, where the correlation coefficients between these two relationships were quite close.

I calculated the correlation coefficients using four different methods, as these methods made slightly different assumptions about the distribution of data points. The differences between them provided some additional insights into the data. The Pearson correlation coefficients assume that the two variables being measured have a linear relationship. These coefficients showed the highest numbers. The Spearman and Kendall correlation coefficients are non-parametric, specifically rank-based measures. These measures provide smaller coefficients. These numbers told us that the relationship between the two variables was not strictly monotonic. This was a pattern we had already observed in Figure 2.

![](https://github.com/jaeyk/validating-two-linked-fates/blob/master/outputs/cor_coeffs_plot.png)
Figure 3. Correlation tests results

#### Reliability tests

The other necessary step was checking reliability. Perhaps, the differences in responses in these three linked fate questions arose by chance. The questions were all related and their wording was similar. Thus, this was a legitimate concern. I addressed this problem by calculating Conger's kappa. Conger's kappa is a generalized version of Cohen's kappa and shows whether the raters have a perfect agreement (=1) or if their agreement is entirely a fluke (=0). This technique is often used to test the reliability of raters. Here, I employed this method to determine whether similarities in the responses of these three linked fate questions occurred by chance.

In Figure 4, the y-axis indicates Conger's kappa statistic, and the x-axis plots different racial groups. The top panel shows that the reliability score for whites is far lower than that of other groups. The bottom panel shows that weighting makes no difference. All kappa statistics are between 0.36 and 0.474.

![](https://github.com/jaeyk/validating-two-linked-fates/blob/master/outputs/reliability_tests_plot.png)
Figure 4. Correlation tests results

#### Difference of means test

Finally, I would like to revisit Figure 1 and stress the extent to which using the standard linked fate question creates more positive responses compared to the more specific question. Here, the left panel (Hurt - Fate) shows the mean difference between the responses of the linked hurt question and those of the standard linked fate question. Similarly, the right panel (Progress - Fate) displays the mean difference between the responses of the linked progress question and those of the standard linked fate question. The x-axis charts different racial groups. The y-axis indicates the difference in means. In both cases, it is clear that using a specific question decreases the ratio of positive responses. The ratio decreases faster in the case of the linked hurt than that of the linked hurt question. In that regard, white respondents showed the most extreme tendency.

![](https://github.com/jaeyk/validating-two-linked-fates/blob/master/outputs/diff_in_means_plot.png)
Figure 5. The difference in means test results

#### Regression analysis [TBD]

![](https://github.com/jaeyk/validating-two-linked-fates/blob/master/outputs/ols_coeffs.png)
Figure 6. OLS estimates

#### Concluding remarks

1. Why was the standard linked question able to generate the most positive responses? One possibility was because the wording was vague and general. Thus, it left room for respondents to interpret the question in whatever way they preferred.
2. Our study suggested two possible interpretations of the linked fate question and showed both supportive and not supportive evidence for the black utility heuristics theory. The negative mechanism was present, but the positive mechanism was prevailing, even for African Americans.
3. Researchers should use caution when directly applying the standard linked fate question to whites. The survey results showed that whites clearly interpreted and reacted to the idea of group consciousness differently compared to other racial groups.
