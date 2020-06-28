mean_group_key <- function(data, group_var, key_var){
  data %>%
  group_by({{group_var}}) %>%
  summarise(mean = mean({{key_var}}),
            se = std.error({{key_var}}))
}

corr_plot <- function(data){
  data %>%
    pivot_longer(cols = c(linked_fate, linked_progress, linked_hurt),
                 names_to = "Measures", 
                 values_to = "Responses") %>%
    ggplot(aes(x = Responses)) + 
        geom_density() +  
        labs(y = "Density") + 
        facet_wrap(~Measures)
}

summarise_coeff <- function(data, group_var, var1, var2){

    data %>%
        group_by({{group_var}}) %>%
            summarise(
              
            Pearson = cor.test(
                {{var1}}, {{var2}}, 
                method = c("pearson"))$estimate %>% 
                as.numeric(),
        
            Kendall = cor.test(
                {{var1}}, {{var2}}, 
                method = c("kendall"),
                exact = F)$estimate %>% 
                as.numeric(),
        
            Spearman = cor.test(
                {{var1}}, {{var2}}, 
                method = c("spearman"),
                exact = F)$estimate %>% 
                as.numeric())
  
}

reliability_test <- function(data){
  
    irr <- data %>%
        dplyr::select(linked_fate, 
                  linked_progress, 
                  linked_hurt) %>%
        ckap(R = 0) # Conger's kappa, No bootstrapping 
  
    irr$est %>% 
        as.numeric()
  
}

reliability_weight_test <- function(data){
  
    irr <- data %>%
        dplyr::select(linked_fate, 
                      linked_progress, 
                      linked_hurt) %>%
        ckap(R = 0, weight = "quadratic") # Conger's kappa, linear weighting 
    
    irr$est %>% 
        as.numeric()
}

reliability_boot_test <- function(data){
  
    irr <- df %>%
        dplyr::select(linked_fate, linked_progress, linked_hurt) %>%
        ckap(R = 1000) # With bootstrapping 
  
    kappa <- irr$est %>% as.numeric()
    ub <- irr$ub %>% as.numeric()
    lb <- irr$lb %>% as.numeric()
  
    c(kappa, ub, lb)

}

