library(readr)
library(glmnet)       
library(gglasso)
library(dplyr)

# import dataset, training only
train <- read_csv("data/derived/IranianChurn_cleaned_train_scaled.csv")

# Transform the 'Churn' variable from 'non-CHURN', 'CHURN' to 0, 1
train <- train %>%
  mutate(Churn = ifelse(Churn == "non-CHURN", 0, 1))

# For model matrix
fullmodel <- glm(Churn~CallFailure + Complains + poly(SubscriptionLength,3) + 
                   ChargeAmount + AgeGroup + TariffPlan + Status + DistinctCalledNumbers +
                   SecondsofUse + Frequencyofuse + FrequencyofSMS, 
                 family=binomial(link="logit"), data=train)

## gglasso
y <- train$Churn
X <- model.matrix(fullmodel)[,-1] # [-1] removes intercept

groups <- c(1,2, 3,3,3, 4, 5,5,5,5, 6, 7, 8, 9, 10, 11)

gglassocv <- cv.gglasso(x=X, y=y, group=groups, 
                        loss="ls", pred.loss="L2")
gglasso_model <- gglasso(X, y, group = groups,
                         lambda = gglassocv$lambda.1se)
gglassocoef <- coef(gglasso_model)
gglassocoef

png("outputs/figures/gglasso_cv.png", width = 1000, height = 480, res=100)

# Visualise the cross validation result
plot(gglassocv)

dev.off()