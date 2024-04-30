library(readr)
IranianChurn <- read_csv("data/derived/IranianChurn_cleaned_train_scaled.csv")
attach(IranianChurn)

png("outputs/figures/emplogit_scaled.png", width = 1080, height = 280, res=100)

# import myemplogit() function from the R file in scr diresctory
source("scr/myemplogit.R")

par(mfrow=c(1,4), mar=c(4,4,1,1))
myemplogit(Churn, SecondsofUse, 40,sc=15,
           xlab="Total seconds of calls")

myemplogit(Churn, Frequencyofuse, 40,sc=10,
           xlab="Total number of calls")

myemplogit(Churn, FrequencyofSMS, 40,sc=7,
           xlab="Total number of text messages")

myemplogit(Churn, DistinctCalledNumbers, 40,sc=3,
           xlab="Total number of distinct phone calls")

dev.off()

detach(IranianChurn)