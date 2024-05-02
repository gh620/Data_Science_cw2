library(readr)
IranianChurn <- read_csv("data/derived/IranianChurn_cleaned.csv")

# Transform the 'Churn' variable from 'non-CHURN', 'CHURN' to 0, 1
IranianChurn <- IranianChurn %>%
  mutate(Churn = ifelse(Churn == "non-CHURN", 0, 1))

attach(IranianChurn)

png("outputs/figures/emplogit_init.png", width = 1000, height = 480, res=100)

# import myemplogit() function from the R file in scr diresctory
source("scr/myemplogit.R")

### plots
par(mfrow=c(2,3), mar=c(4,4,1,1))
myemplogit(Churn, CallFailure,            40,sc=6,
           xlab="Number of call failures")
myemplogit(Churn, SubscriptionLength,     40,sc=15,
           xlab="Total months of subscription")
myemplogit(Churn, SecondsofUse,           40,sc=20,
           xlab="Total seconds of calls")
myemplogit(Churn, Frequencyofuse,         40,sc=8,
           xlab="Total number of calls")
myemplogit(Churn, FrequencyofSMS,         40,sc=7,
           xlab="Total number of text messages")
myemplogit(Churn, DistinctCalledNumbers,  40,sc=2.5,
           xlab="total number of distinct phone calls")

dev.off()

detach(IranianChurn)