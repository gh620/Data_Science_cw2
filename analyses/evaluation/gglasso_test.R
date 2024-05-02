## Run the regression_modelling.r file first to store the models in environment
library(gglasso)
library(caret)

# import dataset, training only
test <- read_csv("data/derived/IranianChurn_cleaned_test_scaled.csv")

# Transform the 'Churn' variable from 'non-CHURN', 'CHURN' to 0, 1
test <- test %>%
  mutate(Churn = ifelse(Churn == "non-CHURN", 0, 1))

full <- glm(Churn~CallFailure + Complains + poly(SubscriptionLength,3) + 
                  ChargeAmount + AgeGroup + TariffPlan + Status + DistinctCalledNumbers +
                  SecondsofUse + Frequencyofuse + FrequencyofSMS, 
                family=binomial(link="logit"), data=test)

testX <- model.matrix(full)[,-1]

## mus gglasso
# link gives fitted response according to documentation
fittedresponse_gglasso <- predict(gglasso_model, newx=testX, type="link") 
predicted_classes <- factor(ifelse(fittedresponse_gglasso > 0.5, 1, 0))

# Calculate the confusion matrix
conf_mat <- confusionMatrix(predicted_classes, factor(test$Churn))
print(conf_mat)
