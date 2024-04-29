library(readr)
IranianChurn <- read_csv("data/derived/IranianChurn_cleaned.csv")
library(sm)
attach(IranianChurn)

par(oma = c(4,1,1,1), mfrow = c(2, 4), mar = c(4, 4, 4, 1))  # then block 2
sm.density.compare(CallFailure,Churn, lwd=2)
title(main="Number of CallFailure by CHURN")
sm.density.compare(SubscriptionLength,Churn, lwd=2)
title(main="Total months of subscription by CHURN")
sm.density.compare(ChargeAmount,Churn, lwd=2)
title(main="Charge Amount by CHURN")
sm.density.compare(SecondsofUse,Churn, lwd=2)
title(main="Total seconds of calls by CHURN")
sm.density.compare(Frequencyofuse,Churn, lwd=2)
title(main="Total number of calls by CHURN")
sm.density.compare(FrequencyofSMS,Churn, lwd=2)
title(main="Total number of text messages by CHURN")
sm.density.compare(DistinctCalledNumbers,Churn, lwd=2)
title(main="Total number of distinct phone calls by CHURN")
sm.density.compare(AgeGroupNum,Churn, lwd=2)
title(main="Age Group by CHURN")

par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
plot(0, 0, type = 'l', bty = 'n', xaxt = 'n', yaxt = 'n')
legend('bottom', legend = c( 'CHURN','non-CHURN'), 
       lty=c(2,1), col=c(3,2), lwd=2, horiz = TRUE, xpd = TRUE, 
       seg.len=2, cex = 1.5, inset = 0, bty = "o")

detach(IranianChurn)
