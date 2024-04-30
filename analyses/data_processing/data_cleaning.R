library(readr)
IranianChurn <- read_csv("data/raw/IranianChurn.csv")

# Remove spaces from column names
names(IranianChurn) <- gsub(" ", "", names(IranianChurn))

# Data cleaning
AgeGroupNum <- IranianChurn$AgeGroup
IranianChurn$Complains <- factor(IranianChurn$Complains,
                              labels=c("No Complains","Complains"))
IranianChurn$TariffPlan <- factor(IranianChurn$TariffPlan,
                               labels=c("Pay as you go","contractual"))
IranianChurn$Status <- factor(IranianChurn$Status,
                           labels=c("active","non-active"))
IranianChurn$AgeGroup <- factor(IranianChurn$AgeGroup,
                             labels=c( '<15', '15-30', '30-45', '45-60', '60-75'))
IranianChurn$Churn <- factor(IranianChurn$Churn, 
                           labels=c("non-CHURN", "CHURN"))

# Save the cleaned data to a CSV file
write.csv(IranianChurn, "data/derived/IranianChurn_cleaned.csv", row.names = F)

# Use 70% of dataset as training set and remaining 30% as testing set
set.seed(3) # make this example reproducible
sample <- sample(nrow(IranianChurn), floor(0.7*nrow(IranianChurn)))
train  <- IranianChurn[sample, ]
test   <- IranianChurn[-sample, ]

# Save the train and test set seperately
write.csv(train, "data/derived/IranianChurn_cleaned_train.csv", row.names = F)
write.csv(test, "data/derived/IranianChurn_cleaned_test.csv", row.names = F)
