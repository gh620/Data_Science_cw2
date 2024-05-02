#################################################################################
##### Remember: Run all the modelling and performance testing scripts first! ####
##### (all scripts in modelling and evaluation sub-directory) ###################
#################################################################################

library(gglasso)
library(e1071)
library(pROC)
library(caret)

# import dataset, training only
test <- read_csv("data/derived/IranianChurn_cleaned_test_scaled.csv")

# Transform the 'Churn' variable from 'non-CHURN', 'CHURN' to 0, 1
test <- test %>%
  mutate(Churn = ifelse(Churn == "non-CHURN", 0, 1))

# Prepare predictions probabilities for ROC
# (ensure that svm.model is trained to output probabilities)
probs_gglasso <- exp(fittedresponse_gglasso)/(1+exp(fittedresponse_gglasso))
probs_gglasso <- probs_gglasso[, 1]

probs_svm <- predict(svm_model, test_scaled, probability=T)
probs_svm <- attr(probs_svm, "probabilities")[, 2]  # assuming the second column contains class 1 probabilities

probs_aic <- predict(aicmodel, newdata = test, type = "response")

probs_bic <- predict(bicmodel, newdata = test, type = "response")

# Calculate ROC for gglasso
roc_gglasso <- roc(test$Churn, fittedresponse_gglasso)
auc_gglasso <- auc(roc_gglasso)

# Calculate ROC for SVM
roc_svm <- roc(test$Churn, probs_svm)
auc_svm <- auc(roc_svm)

# Calculate ROC for AIC model
roc_aic <- roc(test$Churn, probs_aic)
auc_aic <- auc(roc_aic)

# Calculate ROC for BIC model
roc_bic <- roc(test$Churn, probs_bic)
auc_bic <- auc(roc_bic)

# Print AUC
print(paste("AUC for gglasso:", auc_gglasso))
print(paste("AUC for SVM:", auc_svm))
print(paste("AUC for AIC:", auc_aic))
print(paste("AUC for BIC:", auc_bic))

# saving figures
png("outputs/figures/roc.png", width = 480, height = 480, res=100)

plot(roc_gglasso, main="ROC Curves Comparison", col="pink", xlim=c(1,0))
lines(roc_svm, add=TRUE, col="skyblue")
lines(roc_aic, add=TRUE, col="lightgreen")
lines(roc_bic, add=TRUE, col="violet")
legend("bottomright", legend=c("gglasso: AUC=0.9314", "SVM: AUC=0.9649", 
                               "AIC: AUC=0.9427", "AIC: AUC=0.9444"), 
       col=c("pink", "skyblue", "lightgreen", "violet"), lwd=2)

dev.off()
