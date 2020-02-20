# validating-two-linked-fates

**Identifying and validating multiple interpretations of linked fate**

## Overview

This project investigates how people interpret linked fate, a major measure of group consciousness in identity politics. Dawson's [Behind the Mule](https://books.google.com/books?hl=en&lr=&id=0-I9DwAAQBAJ&oi=fnd&pg=PP11&ots=sEoMI1VStP&sig=NLmBqid3hZa2GKO1lpMvSPdYTQo#v=onepage&q&f=false) (1994) argues that African Americans remain a cohesive racial group despite the growing within-group economic inequality because centuries-long experience of racial discrimination ties their individual and group utility together. He called this connection "linked fate" and since then linked fate has become a popular measure of group solidarity across diverse group contexts (Google Scholar search yields [more than 2700 results](https://scholar.google.com/scholar?hl=en&as_sdt=0%2C5&q=%22linked+fate%22&btnG=)).In this project, [Alan Yan](https://politics.princeton.edu/people/alan-yan) and I argue the linked fate literature has a measure problem. Scholars have measured the expressed strength of linked fate by asking survey respondents to what extent they agree what happens to their group also influences their life. The issue is people may think about that connection in two different ways: **linked progress** and **linked hurt**. Linked progress is a positive mechanism which indicates that an individual thinks that they make progress, when their group make progress. Linked hurt is a negative mechanism which indicates that an individual thinks that they get hurt, when their group gets hurt. According to the black utility heuristics theory, the linked hurt interpretation is more plausible. But how do we know?

Using a California-wide survey data (N = 4,435) and novel measures of linked fate, we demonstrate how distinguishing these interpretations matter for the empirical study of identity politics.

1. Linked progress was on average scored higher than linked hurt across all racial groups including African Americans. This finding was inconsistent with what Dawson's original theory implied.
2. People expressed stronger group consciousness when they were asked about it through the standard linked fate question. White group consciousness disappeared when we used more specific linked fate questions. This finding raises a question about the foundations of how white group politics are different from that of other racial groups.

## Research design

### Hypothesis

The standard way of measuring linked fate is asking the following question to the survey participants.

- **Linked fate**: Do you agree or disagree - What happens to (Latinos/ whites/ blacks and African Americans / Asians/ Pacific Islanders/ American Indians) in this country will have something to do with what happens in my life

In addition to this standard measure, we added two novel measures of linked fate that distinguish whether linked fate is interpreted in the context of a positive or a negative connection between group and individual utility.

- **Linked progress**: Do you agree or disagree - When things get better for (Latinos/ whites/ blacks and African Americans/ Asians/ Pacific Islanders/ American Indians) in this country, then things will get better for me
- **Linked hurt**: Do you agree or disagree - When things get worse for (Latinos/ whites/ blacks and African Americans/ Asians/ Pacific Islanders/ American Indians) in this country, then things will get worse for me

Our main hypotheses are as follows:
1. Linked fate, linked progress, and linked hurt will yield statistically different level of responses.
2. If the measure is consistent with Dawson's theory, linked hurt will be more strongly correlated with linked hurt than linked progress responses especially among African Americans (convergent validity).

### Data collection

We tested this hypothesis by embedding these three questions in a California-wide survey (N = 4,435) carried out by the Institute of Government Studies at the University of California Berkeley in June 2019.

- Random sampling: Random sampling was used based on publicly available email addresses in voter records as sampling frame (see this [link](https://www.latimes.com/politics/la-na-pol-2020-how-poll-was-done-20190613-story.html) for more information on their sampling methods and this [link](https://sda.berkeley.edu/sdaweb/docs/IGS_2019_02/DOC/hcbkfx0.htm) for list of items used in the survey).
- Random ordering: These questions were randomly ordered to get around the order effect.
- Multiple choices: The responses for these questions were collected using four multiple choices (1 - Agree strongly, 2 - Agree somewhat, 3 - Disagree somewhat, 4 - Disagree strongly).

## Workflow

In the rest of the document, I state how I have **cleaned**, **analyzed**, and **visualized** data. I shared the R code I used in each step.

### Data cleaning \[[Code](https://github.com/jaeyk/validating-two-linked-fates/blob/master/code/01_data_cleaning.Rmd)]

- Recoded linked fate related questions so that all positive responses become positive numbers (2- agree strongly, 1- agree somewhat) and all negative responses become negative numbers (-1 - disagree somewhat, - 2 disagree strongly). I did so because this scale was easier for me to interpret the results.
- Found 5-6% of missing responses from linked fate questions and imputed them using multiple imputations (the `mice` package in R).
- Only included participants whose ethnicity was identified either as whites, African Americans, Latinx and Asian Americans. Consequently, I dropped 150 participants (3% of the total number of participants) who were non-identified using these measures.

### Data analysis and visualization \[[Code](https://github.com/jaeyk/validating-two-linked-fates/blob/master/code/02_data_analysis.Rmd)]

#### Measures of Central Tendency

![](https://github.com/jaeyk/validating-two-linked-fates/blob/master/outputs/descriptive_stat_plot.png)
Figure 1. Mean and Standard Errors

In Figure 1, X-axis indicates the average score of responses to linked fate related questions. Y-axis indicates different racial groups. Mean describes the central tendency of the responses. The limitation is it does not show how these data points are spread. For that reason, I also included standard errors, which are indicated by the error bars.

To begin with, Figure 1 clearly demonstrates using different measure for linked fate yields different level of responses. Overall, the standard linked fate question drew the stronget expressed support for linked fate. Linked progress was on average scored higher than linked hurt across all racial groups including African Americans. It does not mean that Dawson's theory is wrong becuase the data also provides evidence for the presence of linked hurt. What the theory has missed is the importance of linked progress mechanism and its prevalance.

#### Density plots

![](https://github.com/jaeyk/validating-two-linked-fates/blob/master/outputs/density_plot.png)
Figure 2. Descriptive analysis

In Figure 2, X-axix indicates those multi-choices used in the linked fate questions. Y-axis indicats their kernal density estimates (KDE). The smoothed line shows an estimated underlying data distribution. This more detailed look on the data reveals several interesting patterns.

The KDE pattern for the responses to the linked fate question among African American respondents is consistent with the prediction of the black utility heurisics theory. The distribution was left-skewed. It shows an almost unanimous support for the black solidarity.

However, the same respondents became more skeptical when they were asked about the specific connection between their group and indiivdual utility. We can see similar patterns across other racial groups. The case of whites was an extreme one. In that case, the respondents began to disagree the idea of white group consciousness more than they agreed with it.

#### Correlation tests

As the next step, I examine the correlation between the standard and nobel linked fate measures. Again, the theory predicts that the responses of the standard linked fate measure should covary with the responses of the linked hurt mesaure than those of the linked progress measure. This hypothesis is not correct across all racial groups except whites where the correlation coeffecients between these two relationsips are quite close. I calculated correlation coefficients using four different methods as they make slightly different assumptions about the distribution of data points. Pearson correlation coefficients tend to show the highest numbers. Using bootstrapping makes almost no difference. Spearman and Kendall correlation coefficietns provide smaller coefficients.

![](https://github.com/jaeyk/validating-two-linked-fates/blob/master/outputs/cor_coeffs_plot.png)
Figure 3. Correlation tests results

#### Reliability tests

- Conger's Kappa
- Bootstrapped Conger's Kappa

![](https://github.com/jaeyk/validating-two-linked-fates/blob/master/outputs/reliability_tests_plot.png)
Figure 4. Correlation tests results

#### Difference of means test

![](https://github.com/jaeyk/validating-two-linked-fates/blob/master/outputs/diff_in_means_plot.png)
Figure 5. Difference of means test results


## Conclusion remarks
