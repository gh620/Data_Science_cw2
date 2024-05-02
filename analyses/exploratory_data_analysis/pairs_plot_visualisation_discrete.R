library(ggplot2)
library(GGally)
library(readr)

# Load the dataset
IranianChurn <- read_csv("data/derived/IranianChurn_cleaned.csv")

png("outputs/figures/pairs_plot_discrete.png", width = 680, height = 680, res=100)


# Selected continuous variables
discrete_variables <- c("Complains", "ChargeAmount", "AgeGroup", "TariffPlan", "Status")
categorical_variable <- "Churn"  # Replace with your categorical variable

# Create a custom function for displaying correlation coefficients on the plot
colours <- colorspace::adjust_transparency(
  col = c("skyblue", 'pink'),
  alpha = 0.6)

ggpairs(IranianChurn[, c(discrete_variables, categorical_variable)], 
        mapping = aes(col = Churn)) +
  scale_colour_manual(values = colours) +
  scale_fill_manual(values = colours) +
  theme_minimal() + 
  theme(axis.text = element_text(size = 6))

dev.off()
