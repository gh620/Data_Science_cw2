library(readr)
library(dplyr)
library(corrplot)

IranianChurn <- read_csv("data/derived/IranianChurn_cleaned.csv")
attach(IranianChurn)

png("outputs/figures/multicollinearity.png", width = 480, height = 480)

corr <- cor(IranianChurn %>%
              dplyr::select(where(is.numeric)) %>% 
              dplyr::select(-matches(c("CustomerValue",
                                       "Churn"))),  
            use="pairwise.complete.obs")
corrplot.mixed(corr, tl.pos = 'lt', diag = 'l', upper = "circle")

# Close the graphics device
dev.off()