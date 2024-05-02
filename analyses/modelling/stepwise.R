library(readr)
library(stats)
library(dplyr)

# import dataset, training only
train <- read_csv("data/derived/IranianChurn_cleaned_train_scaled.csv")

# Transform the 'Churn' variable from 'non-CHURN', 'CHURN' to 0, 1
train <- train %>%
  mutate(Churn = ifelse(Churn == "non-CHURN", 0, 1))

# These 3 vars are transformed already: SecondsofUse + Frequencyofuse + FrequencyofSMS 
# All continuous vars are scaled
fullmodel <- glm(Churn~CallFailure + Complains + poly(SubscriptionLength,3) + 
      ChargeAmount + AgeGroup + TariffPlan + Status + DistinctCalledNumbers +
      SecondsofUse + Frequencyofuse + FrequencyofSMS, 
    family=binomial(link="logit"), data=train)

## aic, bic modelling

# aic
aicmodel <- step(fullmodel, 
                 scope=list(upper=fullmodel), 
                 direction="both")

# Step:  AIC=889.24
# Churn ~ CallFailure + Complains + poly(SubscriptionLength, 3) + 
#   ChargeAmount + AgeGroup + Status + DistinctCalledNumbers + 
#   Frequencyofuse + FrequencyofSMS

# bic
bicmodel <- step(fullmodel, 
                 scope=list(upper=fullmodel), 
                 direction="both", 
                 k=log(nrow(train)))

# Step:  AIC=967.33
# Churn ~ CallFailure + Complains + poly(SubscriptionLength, 3) + 
#   ChargeAmount + Status + Frequencyofuse + FrequencyofSMS

summary(aicmodel)
summary(bicmodel)

