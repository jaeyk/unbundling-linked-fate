# Create a function to rescale linked fate related questions
rescale <- function(data) {
  data %>%
    as.character() %>%
    recode(
      "4" = "-2",
      "3" = "-1",
      "2" = "1",
      "1" = "2"
    ) %>%
    as.factor()
}
