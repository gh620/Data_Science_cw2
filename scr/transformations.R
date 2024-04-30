library(readr)
IranianChurn <- read_csv("data/derived/IranianChurn_cleaned.csv")
attach(IranianChurn)

png("outputs/figures/emplogit.png", width = 1200, height = 780, res=100)

# import myemplogit() function from the R file in scr diresctory
source("scr/myemplogit.R")

par(mfrow=c(4,4), mar=c(4,4,2,1))
myemplogit(Churn, SecondsofUse, 40,sc=20,
           xlab="Total seconds of calls")
myemplogit(Churn, sqrt(SecondsofUse), 40,sc=20,
           xlab="sqrt(Total seconds of calls)")
myemplogit(Churn, log(SecondsofUse+1), 40,sc=20,
           xlab="log(Total seconds of calls+1)")
myemplogit(Churn, 1/(SecondsofUse+1), 20,sc=80,
           xlab="1/(Total seconds of calls+1)")

myemplogit(Churn, Frequencyofuse, 40,sc=8,
           xlab="Total number of calls")
myemplogit(Churn, sqrt(Frequencyofuse), 40,sc=8,
           xlab="sqrt(Total number of calls)")
myemplogit(Churn, log(Frequencyofuse+1), 40,sc=8,
           xlab="log(Total number of calls+1)")
myemplogit(Churn, 1/(Frequencyofuse+1), 20,sc=80,
           xlab="1/(Total number of calls+1)")

myemplogit(Churn, FrequencyofSMS, 40,sc=7,
           xlab="Total number of text messages")
myemplogit(Churn, sqrt(FrequencyofSMS), 40,sc=7,
           xlab="sqrt(Total number of text messages)")
myemplogit(Churn, log(FrequencyofSMS+1), 40,sc=7,
           xlab="log(Total number of text messages+1)")
myemplogit(Churn, 1/(FrequencyofSMS+1), 20,sc=250,
           xlab="1/(Total number of text messages+1)")


myemplogit(Churn, DistinctCalledNumbers,  40,sc=2.5,
           xlab="Total number of distinct phone calls")
myemplogit(Churn, sqrt(DistinctCalledNumbers),  40,sc=2.5,
           xlab="sqrt(Total number of distinct phone calls)")
myemplogit(Churn, log(DistinctCalledNumbers+1),  40,sc=2.5,
           xlab="log(Total number of distinct phone calls+1)")
myemplogit(Churn, 1/(DistinctCalledNumbers+1),  20,sc=100,
           xlab="1/(Total number of distinct phone calls+1)")

dev.off()

detach(IranianChurn)