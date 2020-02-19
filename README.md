# validating-two-linked-fates

**Identifying and validating multi-dimensions of linked fate**

## Overview

This project identifies and validates two distinct dimensions of linked fate, a major measure of group consciousness in identity politics. One of the enduring question in American politics is the relationship between race and class in the United States (US). Dawson argued in his _Behind the Mule_ (1994) that African Americans are a cohesive racial group despite the growing class inequality within the group because for them an inseprable link exists between their group and individual utility. He named this concept of group conscioussness "linked fate". His black utility heuristics theory explained that linked fate was formed and forged by the experience of discrimination that African Americans had to share. In practice, this concept was measured by the following survey question: "Do you agree or disagree - What happens to your group in this country will have something to do with happens in my life." Since the pulibication of Dawson's pioonering work, linked fate has been used in measuring group consciousness among diverse racial groups outside the original African American context. Scholars have debated whether the wide spread use of linked fate is extrapolation. The initial discussion has been focusing on the application of linked fate to Asian Americans and Latinx. The 2016 US Presidential Election has increased the interests of scholars in white group politics and whether linked fate is applicable to whites became a new source of debate.

In this project, [Alan Yan] and I focus on the measurement problem of linked fate especially its connection to the original theory. There are two specific ways to interpret the link between group and individual utility: **linked progress** and **linked hurt**. Linked progress is a positive mechanism which indicates that an individual thinks that they make progress, when their group make progress. Linked hurt is a negative mechanism which indicates that an individual thinks that they get hurt, when their group gets hurt. These two dimensions of linked fate illustrate two different situations under which linked fate can emerge and strengthen. The former stresses a situation when having a link with the group can bring more benefits. The latter emphasizes a situation when an individual was bound to suffer with the rest of their group members. For the sake of space, we do not intend to discuss the conceptual differences in detail. It is sufficient to say that the original theory was more aligned linked hurt than linked hurt given its focus on African Americans' collective experience of racial discrimination.

This progress report exclusively focuses on the data analysis. We embedded three linked fate questions: the standard linked fate question plus questions on linked progress and linked hurt in a California-wide survey carried out by the Institute of Government Studies at the University of California Berkeley in June 2019. These questions were randomly ordered to get around the order effect. The responses for these questions were collected using four multiple choices (1 - Agree strongly, 2 - Agree somewhat, 3 - Disagree somewhat, 4 - Disagree strongly).

- **Linked fate**: Do you agree or disagree - What happens to (Latinos/ whites/ blacks and African Americans / Asians/ Pacific Islanders/ American Indians) in this country will have something to do with what happens in my life
- **Linked progress**: Do you agree or disagree - When things get better for (Latinos/ whites/ blacks and African Americans/ Asians/ Pacific Islanders/ American Indians) in this country, then things will get better for me
- **Linked hurt**: Do you agree or disagree - When things get worse for (Latinos/ whites/ blacks and African Americans/ Asians/ Pacific Islanders/ American Indians) in this country, then things will get worse for me

The results demonstrate the followings.

1. Linked progress and linked hurt are two distinct dimensions of linked fate.
2. Linked progress was on averge scored higher than linked hurt across all racial groups, though the differences were within margin of errors except for Latinx.
3. People tend to indicate stronger group consciousness when they were asked about it through the standard linked fate question. White group consciousness disappeared when we used more specific linked fate qustions.

## Workflow

In the rest of the document, I state how I have **cleaned**, **analyzed**, and **visualized** data. I shared the R code I used in each step.

### Data cleaning \[[Code](https://github.com/jaeyk/validating-two-linked-fates/blob/master/code/01_data_cleaning.Rmd)]

-   There is nothing particular here. I dropped irrelevant columns from the survey data and changed key variable names to make them more intelligible.

### Data analysis and visualization \[[Code](https://github.com/jaeyk/validating-two-linked-fates/blob/master/code/02_data_analysis.Rmd)]

#### Mean and standard errors

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
