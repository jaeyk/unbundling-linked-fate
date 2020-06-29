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
    mutate(Measures = recode(Measures, 
                             "linked_fate" = "Linked fate",
                             "linked_progress" = "Linked progress",
                             "linked_hurt" = "Linked hurt")) %>%
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

reliability_boot_mean <- function(data){
  
    irr <- df %>%
        dplyr::select(linked_fate, 
                      linked_progress, 
                      linked_hurt) %>%
        ckap(R = 1000) # With bootstrapping 

    irr$est %>% as.numeric()

}

reliability_boot_ub <- function(data){
  
    irr <- df %>%
        dplyr::select(linked_fate, 
                      linked_progress, 
                      linked_hurt) %>%
        ckap(R = 1000) # With bootstrapping 

    irr$ub %>% as.numeric()
  
}

reliability_boot_lb <- function(data){
  
    irr <- df %>%
        dplyr::select(linked_fate, 
                      linked_progress, 
                      linked_hurt) %>%
    ckap(R = 1000) # With bootstrapping 
  
  irr$lb %>% as.numeric()
  
}

group_diff_in_means <- function(data, group_var, var1, var2){
  
    data %>%
        group_by({{group_var}}) %>%
        summarize(
            diff = mean({{var1}}) - mean({{var2}}),
            conf = ((
                t.test({{var1}}, {{var2}})$conf.int[2]) - 
                t.test({{var1}}, {{var2}})$conf.int[1])/2,
            boot.conf = ((
                MKinfer::boot.t.test({{var1}}, {{var2}}, R= 999)$boot.conf.int[2]) - 
                MKinfer::boot.t.test({{var1}}, {{var2}}, R= 999)$boot.conf.int[1])/2)
  
}

ols <- function(data){
  lm(difference ~ White + Black + Asian + Latinx + Male + Female + Democrat + Republican + for_born + edu_level, data = data)  
}
