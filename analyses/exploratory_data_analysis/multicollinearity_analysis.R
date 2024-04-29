library(readr)
IranianChurn <- read_csv("data/derived/IranianChurn_cleaned.csv")
library(sm)
library(dplyr)
library(corrplot)
attach(IranianChurn)

png("outputs/figures/multicollinearity.png", width = 480, height = 480)

corr <- cor(IranianChurn[,-1] %>%
              dplyr::select(where(is.numeric)) %>% 
              dplyr::select(-matches(c("CustomerValue",
                                       "Churn"))),  
            use="pairwise.complete.obs")
corrplot.mixed(corr, tl.pos = 'lt', diag = 'l', upper = "circle")

# Close the graphics device
dev.off()