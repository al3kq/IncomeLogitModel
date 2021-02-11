# IncomeLogitModel
This binomial logit model using education, sex, age, hours per week, marital status, and occupation as independent variables and income of greater than $50,000 as dependent variable gives a training set accuracy greater than the dependent variable ratio. 

# Highest Coefficent Prediction
* Control: education = HS-grad, sex = Male, age = 37, marital status = Married-civ-spouse, hours per week = 40, occupation = Prof-specialty
* Female: sex = Female
* Doctorate: education = Doctorate
* age 48: age = 48
* ExecServ: occupation = Exec-managerial
* 45hours: hours per week = 45
* Nevrmarry: marital status = Never-married

# Marginal Effects Graphs
With so many categorical features it’s difficult to capture the marginal effect of each feature. The sjPlot package was used to graph the marginal effect of each feature. The marginal effects of these numeric features were much easier to visualize. These graphs also show a 95% confidence interval of the marginal effect. The other plots also show a 95% confidence interval of marginal effect of each categorical feature. However, with so many categories they are hard to read. They can still help show the intuition behind which features are important. 

# Model Accuracy Tests
Various functions were calculated to determine the accuracy of this model. First, a simple count R2 was calculated. This uses the model to create a prediction of income_Y for each individual in the dataset and compares the model predictions to the true income_Y value. A count R2 of 0.8193 was found, this model correctly classified 81.93% of individuals. 
<br>
Next, a McFadden R2 was calculated. This creates a “dummy” model for which all the feature coefficients are zero. This model will always return a probability of 0.2431, or the percentage of the dataset earning greater than 50,000. This gives all individuals an income_Y of 0. The log likelihood of the multinomial logistic regression model and this dummy model are both calculated. The McFadden R2 is defined using the ratio between these two log likelihoods. A McFadden R2 of 0.3509 was found. This pseudo R2 calculation can be difficult to interpret, but it shows a significant difference between the calculated model and the dummy model.
<br>
Finally, the likelihood-ratio test was used to determine the significance between the two models. The chi squared test was used between the log likelihood of these two models which a null hypothesis of the models being equivalent. A p-value equivalent to zero was found, the null hypothesis can be rejected. There is significance between these two tests.
