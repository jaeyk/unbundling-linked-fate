# validating-two-linked-fates

**Identifying and validating multi-dimensions of linked fate**

## Motivation

This project identifies and validates two distinct dimensions of linked fate, a major measure of group consciousness in identity politics.

## Research design

### Random ordering
The order of the two experiments is rotated so that we can circumvent the possible contamination effects of question order.

## Data collection: Mobile Survey Using Matched Random Sampling
To reduce the cost of survey collection, we used a smartphone app-based survey. The mobile survey is good as increasingly more people only use mobile phones. The 2015 National Health Interview Survey conducted by the National Center for Health Statistics reports that nearly one-half of American homes (47.4%) use only wireless telephones. Using a smartphone app-based survey is particularly relevant in South Korea as the country is the most wired in the world. The South Korean smartphone ownership rate is the world's highest according to the 2016 Pew Research Center report. Among the 18–34 age group, the rate was 100%. Even for the 35+ age group, the rate was still impressive at 83%.

One problem with the smartphone app approach is the non-representativeness of the sample. The online panel provided by the survey firm we hired uses an opt-in sample. As such, it does not guarantee a representative sample. To tackle that problem, we used a matched sampling method advocated by previous studies ([Rivers 2007](https://static.texastribune.org/media/documents/Rivers_matching4.pdf)). The survey firm and I matched the firm's online survey pool with a randomly chosen subset of a nationally representative sample. We then recruited participants from the online survey pool from that list. The step by step procedure is as follows.

1. I created a target sample by randomly choosing a sample of 2,303 from the 2015 Korea Welfare Panel Study (KOWEPS), the Korean equivalent of the U.S. Panel Study of Income Dynamics (PSID). The KOWEPS sample size is N=16,664.

2. After creating the target sample, I helped the survey firm to match the target sample with their survey pool based on age, gender, income, education level, occupation, and region. Since the survey pool data is proprietary, most of the matching process was carried out by the survey firm with technical assistance from me.

3. The survey firm recruited participants using this matched sample as a sampling list. We did a pre-survey, as the survey pool data did not include political ideology and other covariates of interest. I randomly created five groups (one control and four treatment groups) blocking on ideology. Overall, 1,543 people agreed to participate in the pre-survey (67% response rate). Of them, 1,418 participated in the main survey (92% retention rate).

## Workflow

In the rest of the document, I state how I have **wrangled**, **analyzed**, and **visualized** data. I shared the R code I used in each step.

### Data cleaning [[Code](https://github.com/jaeyk/validating-two-linked-fates/blob/master/code/01_data_cleaning.Rmd)]

- There is nothing particular here. I dropped irrelevant columns from the survey data and changed key variable names to make them more intelligible.

### Data analysis [[Code](https://github.com/jaeyk/validating-two-linked-fates/blob/master/code/02_data_analysis.Rmd)]

**Mean and standard errors**

![](https://github.com/jaeyk/validating-two-linked-fates/blob/master/outputs/descriptive_stat_plot.png)
Figure 1. Descriptive analysis

Figure 1 shows the effects of estimated average treatment. We only find evidence of indirect bias toward North Korean refugees but not direct bias. Another noticeable fact is that the extent to which South Korean citizens hold a bias toward North Korean refugees is similar to their attitude toward Indonesian migrant workers.

**Density plots**

![](https://github.com/jaeyk/validating-two-linked-fates/blob/master/outputs/density_plot.png)
Figure 2. Descriptive analysis

**Correlation tests**

- Pearson
- Bootstrapped Pearson
- Kendall
- Spearman

![](https://github.com/jaeyk/validating-two-linked-fates/blob/master/outputs/cor_coeffs_plot.png)
Figure 3. Correlation tests results

Figure 2 compares the estimated effects of conditional average treatment with or without bootstrapped confidence intervals. Interestingly, no strong partisan difference exists concerning South Korean citizens' attitudes towards North Korean refugees. Bootstrapped confidence intervals made very marginal differences (they were slightly narrower than the non-bootstrapped confidence intervals).

**Difference of means test**

![](https://github.com/jaeyk/validating-two-linked-fates/blob/master/outputs/diff_in_means_plot.png)
Figure 4. Difference of means test results

- In the additional analysis, we have found something interesting about how party ID interacts with responses. However, we are cautioned to make a strong claim about this pattern because we did not use party ID as a blocking variable. This relationship is an association.
- Ideological moderates are not exactly positioned in the middle. They could be leaning towards either side of the ideological spectrum. If that is the case, replacing their responses with NAs and then imputing them using multiple imputations could be a more precise way to investigate the causal effect of ideology on ethnic relations in South Korea.
- We would also note that list experiments have many limitations. As [this World Bank blog](https://dimewiki.worldbank.org/wiki/List_Experiments) nicely summarized, this design introduces noise to the data and potentially influences the treatment on the distribution of responses. [Blair and Imai](https://imai.fas.harvard.edu/research/files/listP.pdf) (2012) developed a set of statistical methods to address these problems.
