📄 Repository Description
Health Insurance Charges Analysis

This project explores the Healthcare Insurance dataset to identify the key drivers of annual medical insurance charges. Using R, the analysis applies both generalized linear models (GLM) and linear regression to estimate charges and evaluate model fit.

🔎 Key Features
Data Exploration: Summary statistics and visualizations (e.g., boxplots) highlight how smoking status impacts charges.

Modeling:

Full GLM including age, BMI, smoker status, children, sex, and region.

Reduced GLM excluding sex and region for parsimony.

Model Comparison: ANOVA, AIC, and pseudo R² used to assess fit and explanatory power.

Business Insights:

Smoking increases annual charges by ~23,800 units.

BMI and age steadily increase costs.

Children add modestly to charges.

Sex and region do not materially affect charges.

Prediction Accuracy: RMSE and MAE calculated on a train/test split to evaluate generalization.

Visuals: Predicted vs actual plots and diagnostic checks for model assumptions.

✅ Business Value
The analysis demonstrates that health behaviors (smoking, BMI) are the strongest predictors of insurance costs, while demographic factors like sex and region add little explanatory power. These insights can inform underwriting, pricing strategies, and risk management in insurance companies.
