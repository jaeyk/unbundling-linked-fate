# Create a function to rescale linked fate related questions
rescale <- function(data) {
  data %>%
    as.character() %>%
    recode(
      "4" = "1",
      "3" = "2",
      "2" = "3",
      "1" = "4"
    ) %>%
    as.factor()
}
