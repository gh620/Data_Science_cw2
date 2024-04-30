# Load necessary libraries
library(readr)
library(tidyr)

# for saving image
png("outputs/figures/mimic_checks_continuous.png", width = 1000, height = 380)

# Load the datasets
train <- read_csv("data/derived/IranianChurn_cleaned_train.csv")
test <- read_csv("data/derived/IranianChurn_cleaned_test.csv")

# Plotting setup
par(mfrow=c(2,4)) # 4 rows of variables, 2 columns for train and test

# Selected continuous variables
continuous_variables <- c('CallFailure', 'SecondsofUse', 'FrequencyofSMS', 'DistinctCalledNumbers')

# Plot histograms for each variable
for (var in continuous_variables) {
  hist(train[[var]], main=paste('Train -', var, 'Distribution'), 
       col='skyblue', xlab=var, breaks = 20)
  hist(test[[var]], main=paste('Test -', var, 'Distribution'), 
       col='pink', xlab=var, breaks = 20)
}

dev.off()

# for saving image
png("outputs/figures/mimic_checks_discrete.png", width = 1000, height = 280)

# Set up the plotting layout
par(mfrow=c(1,4)) # 5 variables, 2 columns for train and test

# Categorical variables
categorical_columns <- c('Churn', 'AgeGroup')

# Loop through each categorical column and plot the proportions
for (var in categorical_columns) {
  # Get proportions for train and test
  train_props <- prop.table(table(train[[var]]))
  test_props <- prop.table(table(test[[var]]))
  
  # Bar plot for train data
  barplot(train_props, main=paste('Train -', var), col="skyblue", xlab=var, ylim=c(0, 1))
  
  # Bar plot for test data
  barplot(test_props, main=paste('Test -', var), col="pink", xlab=var, ylim=c(0, 1))
}

dev.off()
