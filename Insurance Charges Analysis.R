## Load Data
insurance <- read.csv("~/Thuthukani/Personal project/Health insurance prediction/insurance.csv")
summary(insurance)

## Visualize Charges by Smoking Status
library(ggplot2)
ggplot(insurance, aes(x = smoker, y = charges)) +
  geom_boxplot(fill = "skyblue") +
  labs(title = "Insurance Charges by Smoking Status",
       x = "Smoker Status", y = "Annual Charges")

cat("Insight: Smokers clearly incur higher annual charges compared to non-smokers.\n\n")

## Fit Full GLM Model
glm_full <- glm(charges ~ age + bmi + smoker + children + sex + region,
                data = insurance,
                family = gaussian(link = "identity"))
summary(glm_full)

## Reduced GLM (dropping sex and region)
glm_red <- glm(charges ~ age + bmi + smoker + children,
               data = insurance,
               family = gaussian(link = "identity"))
summary(glm_red)

## Compare Models
anova(glm_full, glm_red, test = "Chisq")

cat("Insight: Sex and region do not significantly improve model fit, so they can be excluded.\n\n")

## Goodness of Fit Summary for Reduced Model
pseudo_r2 <- 1 - (glm_red$deviance / glm_red$null.deviance)
model_aic <- AIC(glm_red)

cat("Goodness of Fit for Reduced Model (glm_red)\n")
cat("=========================================\n")
cat("Pseudo R² (Deviance Explained):", round(pseudo_r2, 3), "\n")
cat("AIC:", model_aic, "\n")
cat("Residual Deviance:", glm_red$deviance, "\n")
cat("Null Deviance:", glm_red$null.deviance, "\n\n")

## Business Interpretation of Coefficients
coef_red <- coef(glm_red)
cat("Business Insights:\n")
cat("- Each year of age adds ~", round(coef_red["age"], 0), "units to charges.\n")
cat("- Each unit increase in BMI adds ~", round(coef_red["bmi"], 0), "units.\n")
cat("- Being a smoker increases charges by ~", round(coef_red["smokeryes"], 0), "units.\n")
cat("- Each child adds ~", round(coef_red["children"], 0), "units.\n\n")

## Train/Test Split for Prediction Accuracy
set.seed(123)
train_index <- sample(1:nrow(insurance), 0.7*nrow(insurance))
train <- insurance[train_index, ]
test  <- insurance[-train_index, ]

glm_red_train <- glm(charges ~ age + bmi + smoker + children,
                     data = train,
                     family = gaussian(link = "identity"))

pred_red <- predict(glm_red_train, newdata = test)

rmse_red <- sqrt(mean((test$charges - pred_red)^2))
mae_red  <- mean(abs(test$charges - pred_red))

cat("Prediction Accuracy (Test Set)\n")
cat("RMSE:", round(rmse_red, 2), "\n")
cat("MAE:", round(mae_red, 2), "\n\n")

## Visualize Predicted vs Actual
ggplot(data.frame(actual = test$charges, predicted = pred_red),
       aes(x = actual, y = predicted)) +
  geom_point(alpha = 0.6, color = "darkblue") +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "red") +
  labs(title = "Predicted vs Actual Insurance Charges",
       x = "Actual Charges", y = "Predicted Charges")

cat("Conclusion:\n")
cat("Smoking status is the single strongest driver of insurance costs, followed by BMI and age.\n")
cat("Sex and region do not materially affect charges.\n")
cat("This suggests underwriting should focus on health behaviors and BMI management rather than demographic factors.\n")
