library(readr)
library(glmnet)       
library(gglasso)

# import dataset, training only
train <- read_csv("data/derived/IranianChurn_cleaned_train_scaled.csv")

# These 3 vars are transformed already: SecondsofUse + Frequencyofuse + FrequencyofSMS 
# All continuous vars are scaled
fullmodel <- glm(Churn~CallFailure + Complains + poly(SubscriptionLength,3) + 
                   ChargeAmount + AgeGroup + TariffPlan + Status + DistinctCalledNumbers +
                   SecondsofUse + Frequencyofuse + FrequencyofSMS + 
                   AgeGroup:FrequencyofSMS + 
                   AgeGroup:SubscriptionLength+ 
                   ChargeAmount:Frequencyofuse, 
                 family=binomial(link="logit"), data=train)

## aic, bic modelling

# aic
aicmodel <- step(fullmodel, 
                 scope=list(upper=fullmodel), 
                 direction="both")

# Step:  AIC=832.2
# Churn ~ CallFailure + Complains + poly(SubscriptionLength, 3) + 
#   ChargeAmount + AgeGroup + Status + DistinctCalledNumbers + 
#   SecondsofUse + Frequencyofuse + FrequencyofSMS + AgeGroup:FrequencyofSMS + 
#   AgeGroup:SubscriptionLength + ChargeAmount:Frequencyofuse

# bic
bicmodel <- step(fullmodel, 
                 scope=list(upper=fullmodel), 
                 direction="both", 
                 k=log(nrow(train)))

# Step:  AIC=948.3
# Churn ~ CallFailure + Complains + poly(SubscriptionLength, 3) + 
#   ChargeAmount + AgeGroup + Status + DistinctCalledNumbers + 
#   Frequencyofuse + FrequencyofSMS + ChargeAmount:Frequencyofuse

summary(aicmodel)
summary(bicmodel)


## gglasso
y <- train$Churn
X <- model.matrix(fullmodel)[,-1] # [-1] removes intercept

groups <- c(1,2, 3,3,3, 4, 5,5,5,5, 6, 7, 8, 9, 10, 11, 
            12,12,12,12, 13,13,13,13,13, 14)

gglassocv <- cv.gglasso(x=X, y=y, group=groups, 
                        loss="ls", pred.loss="L2")
gglasso.model <- gglasso(X, y, group = groups,
                         lambda = gglassocv$lambda.1se)
gglassocoef <- coef(gglasso.model)
gglassocoef

par(mfrow=c(1,1))
# Assuming gglassocv is your cv.gglasso result
plot(gglassocv$lambda, gglassocv$cvm, type='o', log='x',
     xlab='Lambda', ylab='Cross-Validation Error',
     main='Group Lasso CV Error')

# Add a point and line for the lambda that gives minimum CV error
abline(v = gglassocv$lambda.min, col = 'red', lty = 1)
abline(v = gglassocv$lambda.1se, col = 'black', lty = 2)
