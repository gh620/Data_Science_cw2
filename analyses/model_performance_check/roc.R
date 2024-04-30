library(gglasso)
library(e1071)
library(pROC)
library(caret)

######## Run the modelling scripts first
mus_gglasso <- exp(fittedresponse_gglasso)/(1+exp(fittedresponse_gglasso))
mus_gglasso <- mus_gglasso[, 1]

# Prepare SVM predictions (ensure that svm.model is trained to output probabilities)
svm_probs <- predict(svm_model, test_scaled, probability=T)
svm_probs <- attr(svm_probs, "probabilities")[,2]  # assuming the second column contains class 1 probabilities

# Calculate ROC for gglasso
roc_gglasso <- roc(test$Churn, mus_gglasso)
auc_gglasso <- auc(roc_gglasso)

# Calculate ROC for SVM
roc_svm <- roc(test$Churn, svm_probs)
auc_svm <- auc(roc_svm)

# Print AUC
print(paste("AUC for gglasso:", auc_gglasso))
print(paste("AUC for SVM:", auc_svm))

# saving figures
png("outputs/figures/roc.png", width = 480, height = 480, res=100)

plot(roc_gglasso, main="ROC Curves Comparison", col="pink", xlim=c(1,0))
lines(roc_svm, add=TRUE, col="skyblue")
legend("bottomright", legend=c("gglasso: AUC=0.9314", "SVM: AUC=0.9649"), 
       col=c("pink", "skyblue"), lwd=2)

dev.off()
