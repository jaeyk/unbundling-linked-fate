# validating-two-linked-fates

**Identifying and validating multiple interpretations of linked fate**

## Overview

This project demonstrates that people interprete linked fate, a major measure of group consciousness in identity politics, in two distinct ways. One of the enduring questions in American politics is the relationship between race and class in the United States (US). Dawson's **[Behind the Mule](https://books.google.com/books?hl=en&lr=&id=0-I9DwAAQBAJ&oi=fnd&pg=PP11&ots=sEoMI1VStP&sig=NLmBqid3hZa2GKO1lpMvSPdYTQo#v=onepage&q&f=false)** (1994) argues that African Americans are a cohesive racial group despite the growing class inequality within the group. It is because for them an inseprable link exists between their group and individual utility due to centuries-long experience of racial discrimination. He named this concept of group conscioussness "linked fate" and since then linked fate has been widely applied to measure group consciousness across diverse racial and ethnic group contexts.

In this project, [Alan Yan](https://politics.princeton.edu/people/alan-yan) and I focus on the fact people can interpret the link between group and individual utility in two different ways: **linked progress** and **linked hurt**. Linked progress is a positive mechanism which indicates that an individual thinks that they make progress, when their group make progress. Linked hurt is a negative mechanism which indicates that an individual thinks that they get hurt, when their group gets hurt.

Using a California-wide survey data (N = 4,435) and nobel measures of linked fate, we demonstrate that these distinctions matter for the empirical study of identity politics.

1. Linked progress was on averge scored higher than linked hurt across all racial groups, though the differences were within margin of errors except for Latinx. Even though Dawson's original theory was more consistent with the interpretation of linked fate as linked hurt, that was not a prevailing interpretion even among African Americans.
2. People expressed stronger group consciousness when they were asked about it through the standard linked fate question. White group consciousness disappeared when we used more specific linked fate qustions. This finding raises a question about how white group politics is different from that of other racial groups.

## Research design

### Hypothesis

The standard way of measuring linked fate is asking the following question to the survey participants.

- **Linked fate**: Do you agree or disagree - What happens to (Latinos/ whites/ blacks and African Americans / Asians/ Pacific Islanders/ American Indians) in this country will have something to do with what happens in my life

In addition to this standard measure, we added two novel measures of linked fate that distinguish whether linked fate is interpreted in the context of a positive or a negative connection.

- **Linked progress**: Do you agree or disagree - When things get better for (Latinos/ whites/ blacks and African Americans/ Asians/ Pacific Islanders/ American Indians) in this country, then things will get better for me
- **Linked hurt**: Do you agree or disagree - When things get worse for (Latinos/ whites/ blacks and African Americans/ Asians/ Pacific Islanders/ American Indians) in this country, then things will get worse for me

Our main hypothesis is these measures will yield staitially different level of responses.

### Data collection

We tested this hypothesis by embedding these three questions in a California-wide survey (N = 4,435) carried out by the Institute of Government Studies at the University of California Berkeley in June 2019.

- Random sampling: Random sampling was used based on publicly availalbe email addresses in voter records as sampling frame (see this [link](https://www.latimes.com/politics/la-na-pol-2020-how-poll-was-done-20190613-story.html) for more information on their sampling methods and this [link](https://sda.berkeley.edu/sdaweb/docs/IGS_2019_02/DOC/hcbkfx0.htm) for list of itmes used in the survey).
- Random ordering: These questions were randomly ordered to get around the order effect.
- Multiple choices: The responses for these questions were collected using four multiple choices (1 - Agree strongly, 2 - Agree somewhat, 3 - Disagree somewhat, 4 - Disagree strongly).

## Workflow

In the rest of the document, I state how I have **cleaned**, **analyzed**, and **visualized** data. I shared the R code I used in each step.

### Data cleaning \[[Code](https://github.com/jaeyk/validating-two-linked-fates/blob/master/code/01_data_cleaning.Rmd)]

- Recoded linked fate related questions so that all positive responses are positive numbers (2- agree strongly, 1- agree somewhat) and all negative responses are negative numbers (-1 - disagree somewhat, - 2 disagree strongly). I did so because this scale was easier for me to interpret the results.
- Found 5-6% of missing responses from linked fate questions and imputed them using multiple imputations (the `mice` package in R).
- Only included participants whose ethnicity was identified either as whites, African Americans, Latinx and Asian Americans. Consequently, I dropped 150 participants (3% of the total number of participants) who were non-identified using these measures.

### Data analysis and visualization \[[Code](https://github.com/jaeyk/validating-two-linked-fates/blob/master/code/02_data_analysis.Rmd)]

#### Measures of Central Tendency

![](https://github.com/jaeyk/validating-two-linked-fates/blob/master/outputs/descriptive_stat_plot.png)
Figure 1. Descriptive analysis

Figure 1 shows the effects of estimated average treatment. We only find evidence of indirect bias toward North Korean refugees but not direct bias. Another noticeable fact is that the extent to which South Korean citizens hold a bias toward North Korean refugees is similar to their attitude toward Indonesian migrant workers.

#### Density plots

![](https://github.com/jaeyk/validating-two-linked-fates/blob/master/outputs/density_plot.png)
Figure 2. Descriptive analysis

#### Correlation tests

-   Pearson
-   Bootstrapped Pearson
-   Kendall
-   Spearman

![](https://github.com/jaeyk/validating-two-linked-fates/blob/master/outputs/cor_coeffs_plot.png)
Figure 3. Correlation tests results

Figure 2 compares the estimated effects of conditional average treatment with or without bootstrapped confidence intervals. Interestingly, no strong partisan difference exists concerning South Korean citizens' attitudes towards North Korean refugees. Bootstrapped confidence intervals made very marginal differences (they were slightly narrower than the non-bootstrapped confidence intervals).

#### Difference of means test

![](https://github.com/jaeyk/validating-two-linked-fates/blob/master/outputs/diff_in_means_plot.png)
Figure 4. Difference of means test results

-   In the additional analysis, we have found something interesting about how party ID interacts with responses. However, we are cautioned to make a strong claim about this pattern because we did not use party ID as a blocking variable. This relationship is an association.
-   Ideological moderates are not exactly positioned in the middle. They could be leaning towards either side of the ideological spectrum. If that is the case, replacing their responses with NAs and then imputing them using multiple imputations could be a more precise way to investigate the causal effect of ideology on ethnic relations in South Korea.
-   We would also note that list experiments have many limitations. As [this World Bank blog](https://dimewiki.worldbank.org/wiki/List_Experiments) nicely summarized, this design introduces noise to the data and potentially influences the treatment on the distribution of responses. [Blair and Imai](https://imai.fas.harvard.edu/research/files/listP.pdf) (2012) developed a set of statistical methods to address these problems.

## Conclusion remarks
