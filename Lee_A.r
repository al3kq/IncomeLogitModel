library(tidyverse)

setwd('/Users/andrewlee/Documents/Advanced_Econ')
incomeData <- readRDS('Lee_A.rds')
#Full Dataset summary
summary(incomeData)

library(dplyr)
#New X variable after removing rows
X <- filter(incomeData, education != "Preschool" & education != "1st-4th" & marital.status != "Married-AF-spouse" & occupation != "Armed-Forces" & occupation != "Priv-house-serv")
#added dummy variable for Y
X$income_Y <- as.numeric(X$income == ">50K")
#Train model on entire dataset
fit.logit <- glm(income_Y ~ education + sex + age + hours.per.week + marital.status + occupation, data = X, family = binomial(link = 'logit'))
summary(fit.logit)
#predictions and graphing
perd.p1 <- predict(fit.logit, data.frame('education'= 'HS-grad','sex' = 'Male', 'age' = 37, 'marital.status' = 'Married-civ-spouse', 'hours.per.week' = 40, 'occupation' = 'Prof-specialty'), type = 'response')
perd.gender <- predict(fit.logit, newdata = data.frame('education'= 'HS-grad','sex' = 'Female', 'age' = 37, 'marital.status' = 'Married-civ-spouse', 'hours.per.week' = 40, 'occupation' = 'Prof-specialty'), type = 'response')
perd.education <- predict(fit.logit, newdata = data.frame('education'= 'Doctorate','sex' = 'Male', 'age' = 37, 'marital.status' = 'Married-civ-spouse', 'hours.per.week' = 40, 'occupation' = 'Prof-specialty'), type = 'response')
perd.age <- predict(fit.logit, newdata = data.frame('education'= 'HS-grad','sex' = 'Male', 'age' = 48, 'marital.status' = 'Married-civ-spouse', 'hours.per.week' = 40, 'occupation' = 'Prof-specialty'), type = 'response')
perd.occ <- predict(fit.logit, newdata = data.frame('education'= 'HS-grad','sex' = 'Male', 'age' = 37, 'marital.status' = 'Married-civ-spouse', 'hours.per.week' = 40, 'occupation' = 'Exec-managerial'), type = 'response')
perd.hours <- predict(fit.logit, newdata = data.frame('education'= 'HS-grad','sex' = 'Male', 'age' = 37, 'marital.status' = 'Married-civ-spouse', 'hours.per.week' = 45, 'occupation' = 'Prof-specialty'), type = 'response')
perd.marry <- predict(fit.logit, newdata = data.frame('education'= 'HS-grad','sex' = 'Male', 'age' = 37, 'marital.status' = 'Never-married', 'hours.per.week' = 40, 'occupation' = 'Prof-specialty'), type = 'response')

pred <- c(perd.p1,perd.gender, perd.education, perd.age, perd.occ, perd.hours, perd.marry)
print(perd.p1)
print(perd.gender)
print(perd.education)
print(perd.age)
print(perd.occ)
print(perd.hours)
print(perd.marry)
plot(pred, xaxt = "n", xlab = "Feature Changed")
axis(1,at=1:7, labels = c("Control", "Female", "Doctorate", "age 48", "ExecServ", "45hours", "Nevrmarry"))

#Marginal effect graphs
library(sjPlot)
plot_model(fit.logit, type = "pred", terms = "age")
plot_model(fit.logit, type = "pred", terms = "hours.per.week")
plot_model(fit.logit, type = "pred",axis.labels = "", terms = "occupation")
plot_model(fit.logit, type = "pred",axis.labels = "", terms = "marital.status")
plot_model(fit.logit, type = "pred",axis.labels = "", terms = "education")
plot_model(fit.logit, type = "pred", terms = "sex")

