# Load necessary libraries
library(readr)

# Load the datasets
train <- read_csv("data/derived/IranianChurn_cleaned_train.csv")
test <- read_csv("data/derived/IranianChurn_cleaned_test.csv")

# Applying square root transformations to 3 variables 
# (conclusion from transformation section, see plots transform.R)
train$SecondsofUse <- sqrt(train$SecondsofUse)
train$Frequencyofuse <- sqrt(train$Frequencyofuse)
train$FrequencyofSMS <- sqrt(train$FrequencyofSMS)

test$SecondsofUse <- sqrt(test$SecondsofUse)
test$Frequencyofuse <- sqrt(test$Frequencyofuse)
test$FrequencyofSMS <- sqrt(test$FrequencyofSMS)

# Identifying continuous variables
continuous_variables <- c("CallFailure", "SubscriptionLength", "ChargeAmount", 
                          "SecondsofUse", "Frequencyofuse", "FrequencyofSMS", 
                          "DistinctCalledNumbers", "CustomerValue")

# Calculate mean and standard deviation for each continuous variable in the training set
train_means <- sapply(train[, continuous_variables], mean, na.rm = TRUE)
train_sds <- sapply(train[, continuous_variables], sd, na.rm = TRUE)

# Scale the continuous variables in both datasets
train_scaled <- as.data.frame(sweep(sweep(train[, continuous_variables], 2, train_means, "-"), 2, train_sds, "/"))
test_scaled <- as.data.frame(sweep(sweep(test[, continuous_variables], 2, train_means, "-"), 2, train_sds, "/"))
colnames(train_scaled) <- continuous_variables  # Ensuring column names are maintained
colnames(test_scaled) <- continuous_variables

# Identify categorical variables (assuming the rest are categorical)
categorical_variables <- setdiff(names(train), continuous_variables)

# Combine scaled continuous and original categorical variables
train_combined <- cbind(train[categorical_variables], train_scaled)
test_combined <- cbind(test[categorical_variables], test_scaled)

# Ensure the combined dataset maintains the original column order
train_scaled <- train_combined[names(train)]
test_scaled <- test_combined[names(test)]

# Outputting the final datasets
write.csv(train_scaled, "data/derived/IranianChurn_cleaned_train_scaled.csv", row.names=F)
write.csv(test_scaled, "data/derived/IranianChurn_cleaned_test_scaled.csv", row.names=F)
