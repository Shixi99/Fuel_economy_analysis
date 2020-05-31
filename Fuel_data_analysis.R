install.packages('h2o')

options(repos='http://cran.rstudio.com/')


library(dplyr)
library(h2o)
library(ggplot2)

h2o.init()

df<-as.h2o(ggplot2::mpg)
df %>% glimpse()

predictors <- c("year", "displ", "cyl")
response <- "cty"

glm1 <- h2o.glm( x= predictors, 
                 y=response,
                 training_frame=df, 
                 lambda = 0, 
                 compute_p_values = TRUE)

# Coefficients that can be applied to the non-standardized data
h2o.coef(glm1)

# Coefficients fitted on the standardized data (requires standardize=TRUE, which is on by default)
h2o.coef_norm(glm1)

# coefficients table
glm1@model$coefficients_table
# or show(prostate.glm@model$coefficients_table)

# standard error
glm1@model$coefficients_table$std_error

# p values
glm1@model$coefficients_table$p_value

# model performence
h2o.performance(glm1)

# There is high RMSE in the data, so that, it means model is not quite good
# 0.67 r2 is moderate 