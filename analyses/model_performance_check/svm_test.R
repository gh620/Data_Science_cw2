########### Make sure to run the svm_modelling.R file first 
# to load the svm_model object

# Make predictions on the test data
predictions <- predict(svm_model, test_scaled)

# Evaluate the model performance
confusion_matrix <- confusionMatrix(predictions, test_scaled$Churn)
print(confusion_matrix)