mean_group_key <- function(data, group_var, key_var) {
  data %>%
    group_by({{ group_var }}) %>%
    summarise(
      mean = mean({{ key_var }}),
      se = std.error({{ key_var }})
    )
}

partial_cor <- function(data, group_var) {
  data %>%
    dplyr::filter(race == {{group_var}}) %>%
    dplyr::select(contains("linked")) %>%
    rename("Hurt" = "linked_hurt",
           "Progress" = "linked_progress",
           "Fate" = "linked_fate") %>%
    correlation(partial = TRUE)}
    
draw_ggm <- function(data, group_var) {
  data %>%
    dplyr::filter(race == {{group_var}}) %>%
    dplyr::select(contains("linked")) %>%
    rename("Hurt" = "linked_hurt",
           "Progress" = "linked_progress",
           "Fate" = "linked_fate") %>%
    correlation(partial = TRUE) %>%
    plot() +
    labs(edge_width = "Coefficient",
         title = {{group_var}}) +
    theme(legend.position = "bottom")
}

create_table <- function(data) {
  data.frame(
    "Types" = c("Linked fate", "Linked progress", "Linked hurt"),
    "Averages" = round(as.numeric(data[1, c(1, 3, 5)]), 2),
    "SEs" = round(as.numeric(data[1, c(2, 4, 6)]), 2)
  ) %>%
    kable(format = "latex", booktabs = TRUE) %>%
    kable_styling(position = "center")
}

mean_group_key_weight <- function(data, group_var, key_var) {
  data %>%
    group_by({{ group_var }}) %>%
    summarise(
      mean = survey_mean({{ key_var }})
    )
}

bar_plot <- function(data) {
  data %>%
    pivot_longer(
      cols = c(linked_fate, linked_progress, linked_hurt),
      names_to = "Measures",
      values_to = "Responses"
    ) %>%
    mutate(Responses = as.character(Responses)) %>%
    mutate(Responses = recode(Responses,
      "4" = "Strongly agree",
      "3" = "Somewhat agree",
      "2" = "Somewhat disagree",
      "1" = "Strongly disagree"
    )) %>%
    mutate(Measures = recode(Measures,
      "linked_fate" = "Linked fate",
      "linked_progress" = "Linked progress",
      "linked_hurt" = "Linked hurt"
    )) %>%
    group_by(Measures) %>%
    count(Responses) %>%
    mutate(Responses = factor(Responses, levels = c("Strongly disagree", "Somewhat disagree", "Somewhat agree", "Strongly agree"))) %>%
    ggplot(aes(x = Responses, y = n)) +
    geom_col() +
    labs(
      x = "Responses",
      y = "Count"
    ) +
    facet_wrap(~Measures) +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) +
    coord_flip()
}

bar_plot_weights <- function(data) {
  data %>%
    pivot_longer(
      cols = c(linked_fate, linked_progress, linked_hurt),
      names_to = "Measures",
      values_to = "Responses"
    ) %>%
    mutate(Responses = as.character(Responses)) %>%
    mutate(Responses = recode(Responses,
      "4" = "Strongly agree",
      "3" = "Somewhat agree",
      "2" = "Somewhat disagree",
      "1" = "Strongly disagree"
    )) %>%
    mutate(Measures = recode(Measures,
      "linked_fate" = "Linked fate",
      "linked_progress" = "Linked progress",
      "linked_hurt" = "Linked hurt"
    )) %>%
    as_survey_design(weights = WEIGHT) %>%
    group_by(Measures) %>%
    survey_count(Responses) %>%
    mutate(Responses = factor(Responses, levels = c("Strongly disagree", "Somewhat disagree", "Somewhat agree", "Strongly agree"))) %>%
    ggplot(aes(x = Responses, y = n, ymax = n + 2 * n_se, ymin = n - 2 * n_se)) +
    geom_col() +
    labs(
      x = "Responses",
      y = "Count"
    ) +
    facet_wrap(~Measures) +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) +
    coord_flip()
}

summarise_ci <- function(data, group_var, var1, var2) {
  data %>%
    group_by({{ group_var }}) %>%
    bootstrapify(300) %>%
    summarise(
      Pearson = cor.test(
        {{ var1 }}, {{ var2 }},
        method = c("pearson")
      )$estimate %>%
        as.numeric()
    ) %>%
    group_by(race) %>%
    summarise(
      ci_upper = as.numeric(gmodels::ci(Pearson))[3],
      ci_lower = as.numeric(gmodels::ci(Pearson))[2],
      mean = mean(Pearson)
    )
}

summarise_rci <- function(data, group_var, var1, var2, method){
  
  cor <- data %>% 
    group_by({{group_var}}) %>% 
    select({{ var1 }}, {{ var2 }}) %>% 
    correlation(method = {{ method }}) %>% 
    data.frame()
  
  data.frame("type" = rep(paste({{var1}}, {{var2}}), times = 4),
             "race" = cor$Group,
             "r" = cor$r, 
             "ci_upper" = cor$CI_high,
             "ci_lower" = cor$CI_low,
             "Test" = paste(method))
  
}

summarise_coeff <- function(data, group_var, var1, var2) {
  data %>%
    group_by({{ group_var }}) %>%
    summarise(
      Pearson = cor.test(
        {{ var1 }}, {{ var2 }},
        method = c("pearson")
      )$estimate %>%
        as.numeric(),

      Spearman = cor.test(
        {{ var1 }}, {{ var2 }},
        method = c("spearman"),
        exact = F
      )$estimate %>%
        as.numeric()
    )
}

reliability_test <- function(data) {
  irr <- data %>%
    dplyr::select(
      linked_fate,
      linked_progress,
      linked_hurt
    ) %>%
    ckap(R = 0) # Conger's kappa, No bootstrapping

  irr$est %>%
    as.numeric()
}

reliability_weight_test <- function(data) {
  irr <- data %>%
    dplyr::select(
      linked_fate,
      linked_progress,
      linked_hurt
    ) %>%
    ckap(R = 0, weight = "quadratic") # Conger's kappa, linear weighting

  irr$est %>%
    as.numeric()
}

reliability_boot_mean <- function(data) {
  irr <- df %>%
    dplyr::select(
      linked_fate,
      linked_progress,
      linked_hurt
    ) %>%
    ckap(R = 1000) # With bootstrapping

  irr$est %>% as.numeric()
}

reliability_boot_ub <- function(data) {
  irr <- df %>%
    dplyr::select(
      linked_fate,
      linked_progress,
      linked_hurt
    ) %>%
    ckap(R = 1000) # With bootstrapping

  irr$ub %>% as.numeric()
}

reliability_boot_lb <- function(data) {
  irr <- df %>%
    dplyr::select(
      linked_fate,
      linked_progress,
      linked_hurt
    ) %>%
    ckap(R = 1000) # With bootstrapping

  irr$lb %>% as.numeric()
}

group_diff_in_means <- function(data, group_var, var1, var2) {
  data %>%
    group_by({{ group_var }}) %>%
    summarize(
      diff = mean({{ var1 }}) - mean({{ var2 }}),
      conf = ((
        t.test({{ var1 }}, {{ var2 }})$conf.int[2]) -
        t.test({{ var1 }}, {{ var2 }})$conf.int[1]) / 2,
      boot.conf = ((
        MKinfer::boot.t.test({{ var1 }}, {{ var2 }}, R = 999)$boot.conf.int[2]) -
        MKinfer::boot.t.test({{ var1 }}, {{ var2 }}, R = 999)$boot.conf.int[1]) / 2
    )
}

ols <- function(data) {
  lm(difference ~ edu_level + income_level + Female + Democrat + Republican + for_born + edu_level + income_level, data = data)
}
