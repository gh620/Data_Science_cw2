# Load necessary libraries
library(e1071)
library(caret)

# Load the dataset
train <- read.csv("data/derived/IranianChurn_cleaned_train.csv")
test <- read.csv("data/derived/IranianChurn_cleaned_test.csv")

# factor Churn for classification 
train$Churn <- factor(train$Churn, levels=c("non-CHURN", 'CHURN'))
test$Churn <- factor(test$Churn, levels=c("non-CHURN", 'CHURN'))

# Standardize the features for SVM using training data stats
preproc <- preProcess(train[, -ncol(train)], method = "scale")
train_scaled <- predict(preproc, train[, -ncol(train)])
test_scaled <- predict(preproc, test[, -ncol(test)])

# Add the target variable back
train_scaled$Churn <- train$Churn
test_scaled$Churn <- test$Churn

# Train the SVM model
svm_model <- svm(Churn ~ ., data = train_scaled, type = "C-classification", 
                 probability = TRUE, kernel = "radial")

# Print the model summary
summary(svm_model)

# Make predictions on the test data
predictions <- predict(svm_model, test_scaled)

# Evaluate the model performance
confusion_matrix <- confusionMatrix(predictions, test_scaled$Churn)
print(confusion_matrix)


