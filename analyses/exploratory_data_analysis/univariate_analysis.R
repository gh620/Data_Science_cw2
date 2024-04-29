# Univariate Anlaysis
library(readr)
IranianChurn <- read_csv("data/derived/IranianChurn_cleaned.csv")
attach(IranianChurn)

par(mfrow=c(3,4))

# Bar plot of Churn
barplot(prop.table(table(IranianChurn$Churnf)), col="skyblue",
        main="Bar Chart of Churn",
        ylab="Proportion", xlab="Churn", ylim=c(0,1), axis.lty=1)

# Bar plot of Complaints
barplot(prop.table(summary(factor(Complains))),col="skyblue",
        main="Bar Chart of Complains",
        ylab="Proportion",xlab=c("Complains"), 
        ylim=c(0,1),
        axis.lty=1)

# Bar plot of TariffPlan
barplot(prop.table(summary(factor(TariffPlan))),col="skyblue",
        main="Bar Chart of TariffPlan",
        ylab="Proportion",xlab="type of Tariff Plan", ylim=c(0,1),
        axis.lty=1)

# Bar plot of Status
barplot(prop.table(summary(factor(Status))),col="skyblue",
        main="Bar Chart of Status",
        ylab="Proportion",xlab="status", ylim=c(0,1),
        axis.lty=1)

# Bar plot of AgeGroup
barplot(prop.table(table(AgeGroup)),col="skyblue",
        main="Bar Chart of AgeGroup",
        xlab="Age Group",ylab="Proportion",ylim=c(0,0.6),
        axis.lty=1)

# Bar plot of ChargeAmount
barplot(prop.table(summary(factor(ChargeAmount))),col="skyblue",
        main="Bar Chart of charge amount",
        xlab="Charge Amount",ylab="Proportion", ylim=c(0,0.6),
        axis.lty=1)

# Histogram of other variable

hist(CallFailure,breaks=40,col="skyblue",
     main="Histogram of Call Failure",
     probability = T, ylim = c(0,0.3))

hist(SubscriptionLength,breaks=40,col="skyblue",
     main="Histogram of Subscription Length",
     probability = T,ylim=c(0,0.1),
     xlab="total months of subscripition")

hist(SecondsofUse,breaks=40, col="skyblue",
     main="Histogram of Seconds of Use",
     probability = T,
     xlab="total seconds of calls")

hist(Frequencyofuse,breaks=40,col="skyblue",
     main="Histogram of Frequency of Use ",
     probability = T,ylim=c(0,0.015),
     xlab=expression(paste("total number of calls")))

hist(FrequencyofSMS,breaks=40,col="skyblue",
     main="Histogram of Frequency of SMS",
     probability = T,ylim=c(0,0.04),
     xlab=expression(paste("total number of SMS")))

hist(DistinctCalledNumbers,breaks=40,col="skyblue",
     main="Histogram of Distinct Called Numbers",
     probability = T,ylim=c(0,0.05),
     xlab="total number of distinct calls ")

# hist(CustomerValue,breaks=100,col="skyblue",
#      main="Histogram of Customer Value",
#      probability = T,ylim=c(0,0.0035),
#      xlab="Customer Value ")

detach(IranianChurn)
