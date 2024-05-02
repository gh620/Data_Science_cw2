################## Run data_cleaning.r first
library(readr)
IranianChurn <- read_csv("data/derived/IranianChurn_cleaned.csv")
library(sm)
attach(IranianChurn)

png("outputs/figures/conditional_density_plot.png", width = 1000, height = 480, res=100)

par(oma = c(4,1,1,1), mfrow = c(2, 4), mar = c(4, 4, 4, 1))

sm.density.compare(CallFailure,Churn, lwd=2)
title(main="Number of CallFailure")
sm.density.compare(SubscriptionLength,Churn, lwd=2)
title(main="Total months of subscription")
sm.density.compare(ChargeAmount,Churn, lwd=2)
title(main="Charge Amount")
sm.density.compare(SecondsofUse,Churn, lwd=2)
title(main="Total seconds of calls")
sm.density.compare(Frequencyofuse,Churn, lwd=2)
title(main="Total number of calls")
sm.density.compare(FrequencyofSMS,Churn, lwd=2)
title(main="Total number of text messages")
sm.density.compare(DistinctCalledNumbers,Churn, lwd=2)
title(main="Total number of distinct phone calls")
sm.density.compare(AgeGroupNum,Churn, lwd=2) #defined in data_clean.r
title(main="Age Group")

par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
plot(0, 0, type = 'l', bty = 'n', xaxt = 'n', yaxt = 'n')
legend('bottom', legend = c("non-CHURN", "CHURN"), 
       lty=c(2,1), col=c(3,2), lwd=2, horiz = TRUE, xpd = TRUE, 
       seg.len=2, cex = 1.5, inset = 0, bty = "o")

# Close the graphics device
dev.off()


# Calculate the counts for each category split by churn status
complains_table <- table(Complains, Churn)
tariff_table <- table(TariffPlan, Churn)
status_table <- table(Status, Churn)

# Set up the plotting area
png("outputs/figures/conditional_barplot_discrete.png", width = 1000, height = 380, res=100)
par(mfrow=c(1, 3), mar=c(5, 4, 2, 1))  # Adjust margins if necessary

# Plot for Complains
barplot(complains_table, beside = T, col = c("skyblue", "pink"), 
        main = "Complains", ylim = c(0, max(complains_table)*1.2),
        ylab = "Count")

# Plot for TariffPlan
barplot(tariff_table, beside = T, col = c("skyblue", "pink"),
        main = "Tariff Plan", ylim = c(0, max(tariff_table)*1.2))

# Plot for Status
barplot(status_table, beside = T, col = c("skyblue", "pink"),
        main = "Status", ylim = c(0, max(status_table)*1.2))

# Adding a legend
par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
plot(0, 0, type = 'l', bty = 'n', xaxt = 'n', yaxt = 'n')
legend('bottom', legend = c("non-CHURN", "CHURN"), 
       fill = c("skyblue", "pink"), col=c(3,2), horiz = TRUE, xpd = TRUE, 
       seg.len=2, cex = 1.5, inset = 0, bty = "o")

# Close the graphics device
dev.off()

detach(IranianChurn)
