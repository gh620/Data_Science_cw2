## Run the stepwise.r file first to load the model and the packages in the environment
library(hnp)
library(car)

# saving figures
png("outputs/figures/stepwiseAIC_diagnostics.png", width = 1080, height = 280, res=80)

## Model diagnostics 
par(mfrow=c(1,4), mar=c(4,4,3,1))
hnp(aicmodel, ylab="Deviance Residual", main="HNP AIC model",
    xlim=c(0,4),ylim=c(0,4))
plot(aicmodel, 5); plot(aicmodel, 4); influencePlot(aicmodel)

dev.off() 

# saving figures
png("outputs/figures/stepwiseBIC_diagnostics.png", width = 1080, height = 280, res=80)

## Model diagnostics 
par(mfrow=c(1,4), mar=c(4,4,3,1))
hnp(bicmodel, ylab="Deviance Residual", main="HNP BIC model",
    xlim=c(0,4),ylim=c(0,4))
plot(bicmodel, 5); plot(bicmodel, 4); influencePlot(bicmodel)

dev.off() 

## Test performance 
# import dataset, training only
test <- read_csv("data/derived/IranianChurn_cleaned_test_scaled.csv")

# Transform the 'Churn' variable from 'non-CHURN', 'CHURN' to 0, 1
test <- test %>%
  mutate(Churn = ifelse(Churn == "non-CHURN", 0, 1))

# Predict on test set
pred_aic <- predict(aicmodel, newdata = test, type = "response")
pred_class_aic <- ifelse(pred_aic > 0.5, 1, 0)
pred_class_aic <- factor(pred_class_aic, levels = c(0, 1))

# Confusion matrix
conf_matrix_aic <- confusionMatrix(pred_class_aic, as.factor(test$Churn))
print(conf_matrix_aic)

# Predict on test set
pred_bic <- predict(bicmodel, newdata = test, type = "response")
pred_class_bic <- ifelse(pred_bic > 0.5, 1, 0)
pred_class_bic <- factor(pred_class_bic, levels = c(0, 1))

# Confusion matrix
conf_matrix_bic <- confusionMatrix(pred_class_bic, as.factor(test$Churn))
print(conf_matrix_bic)