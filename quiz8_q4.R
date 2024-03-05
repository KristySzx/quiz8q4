# Load necessary libraries
install.packages("ggplot2")
install.packages("rstanarm")
library(ggplot2)
library(rstanarm)

# Assuming 'data' is a data frame with the following columns:
# 'age_group', 'gender', 'income_group', 'highest_education', 'support'

# For demonstration, let's create a random dataset with 100 observations
set.seed(0)
data <- data.frame(
  age_group = sample(c('18-24', '25-34', '35-44', '45-54', '55+'), size=100, replace=TRUE),
  gender = sample(c('Male', 'Female'), size=100, replace=TRUE),
  income_group = sample(c('Low', 'Medium', 'High'), size=100, replace=TRUE),
  highest_education = sample(c('High School', 'Bachelor', 'Master', 'PhD'), size=100, replace=TRUE),
  support = sample(c('Yes', 'No'), size=100, replace=TRUE)
)

# Convert support to a binary variable
data$support_binary <- ifelse(data$support == 'Yes', 1, 0)

# Build the model using rstanarm
# The formula will be 'support_binary ~ age_group + gender + income_group + highest_education'
model <- stan_glm(support_binary ~ age_group + gender + income_group + highest_education, 
                  data = data, family = binomial, chains = 2, iter = 1000, seed = 123)

# Summary of the model
print(summary(model))

# Create the bar graph using ggplot2
ggplot(data, aes(x = age_group, fill = support)) +
  geom_bar(position = 'dodge') +
  labs(x = 'Age Group', y = 'Count', title = 'Support for Political Party by Age Group')

