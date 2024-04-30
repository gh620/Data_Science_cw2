# Univariate Anlaysis
library(readr)
IranianChurn <- read_csv("data/derived/IranianChurn_cleaned_train_scaled.csv")
attach(IranianChurn)

png("outputs/figures/univariate_analysis_scaled.png", width = 1000, height = 580)

par(mfrow=c(3,4), oma = c(4,1,1,1), mar = c(4, 4, 4, 1))

# Bar plot of Categorical Variables, Churn (outcome)
barplot(prop.table(table(IranianChurn$Churnf)), col="navy",
        main="Distributoin of Churn",
        ylab="Proportion", xlab="Churn", ylim=c(0,1), axis.lty=1)

# Bar plot of Complaints
barplot(prop.table(summary(factor(Complains))),col="navy",
        main="Distribution of Complains",
        ylab="Proportion",xlab=c("Complains"), 
        ylim=c(0,1),
        axis.lty=1)

# Bar plot of TariffPlan
barplot(prop.table(summary(factor(TariffPlan))),col="navy",
        main="Distribution of Tariff Plan",
        ylab="Proportion",xlab="type of Tariff Plan", ylim=c(0,1),
        axis.lty=1)

# Bar plot of Status
barplot(prop.table(summary(factor(Status))),col="navy",
        main="Distribution of Status",
        ylab="Proportion",xlab="status", ylim=c(0,1),
        axis.lty=1)

# Bar plot of AgeGroup
barplot(prop.table(table(AgeGroup)),col="navy",
        main="Distribution of AgeGroup",
        xlab="Age Group",ylab="Proportion",ylim=c(0,0.6),
        axis.lty=1)

# Bar plot of ChargeAmount
barplot(prop.table(summary(factor(ChargeAmount))),col="navy",
        main="Distribution of charge amount",
        xlab="Charge Amount",ylab="Proportion", ylim=c(0,0.6),
        axis.lty=1)

# Histogram of other variable

hist(CallFailure,breaks=40,col="navy",
     main="Distribution of Call Failure",
     probability = T, ylim = c(0,0.3))

hist(SubscriptionLength,breaks=40,col="navy",
     main="Distribution of Subscription Length",
     probability = T,ylim=c(0,0.1),
     xlab="total months of subscripition")

hist(SecondsofUse,breaks=40, col="navy",
     main="Distribution of Seconds of Use",
     probability = T,
     xlab="total seconds of calls")

hist(Frequencyofuse,breaks=40,col="navy",
     main="Distribution of Frequency of Use ",
     probability = T,ylim=c(0,0.015),
     xlab=expression(paste("total number of calls")))

hist(FrequencyofSMS,breaks=40,col="navy",
     main="Distribution of Frequency of SMS",
     probability = T,ylim=c(0,0.04),
     xlab=expression(paste("total number of SMS")))

hist(DistinctCalledNumbers,breaks=40,col="navy",
     main="Distribution of Distinct Called Numbers",
     probability = T,ylim=c(0,0.05),
     xlab="total number of distinct calls ")

# Close the graphics device
dev.off()

detach(IranianChurn)
