library(ggplot2)
library(GGally)
library(readr)

# Load the dataset
IranianChurn <- read_csv("data/derived/IranianChurn_cleaned.csv")

png("outputs/figures/pairs_plot.png", width = 1000, height = 680, res=100)


# Selected continuous variables
continuous_variables <- c('CallFailure', 'SecondsofUse', 'FrequencyofSMS',
                          'SubscriptionLength', 'ChargeAmount', 'DistinctCalledNumbers')
categorical_variable <- "Churn"  # Replace with your categorical variable

# Create a custom function for displaying correlation coefficients on the plot
colours <- colorspace::adjust_transparency(
  col = c("skyblue", 'pink'),
  alpha = 0.6)

ggpairs(IranianChurn[, c(continuous_variables, categorical_variable)], 
        mapping = aes(col = Churn)) +
        scale_colour_manual(values = colours) +
        scale_fill_manual(values = colours) +
        theme_minimal() + 
        theme(axis.text = element_text(size = 6))

dev.off()
