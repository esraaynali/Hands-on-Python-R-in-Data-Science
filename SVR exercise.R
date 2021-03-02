# Loading the data
salary = read.csv("Position_Salaries.csv")


# No need to split the data into training and test sets because we have few observations
# No need to use Position column
# Removing Position 
salary = salary[2:3] # use only column 2 (Level) and 3 (Salary)
print(salary)

# Feature scaling is prior to SVM model training - but no need to do scaling because we are using e1071 library - it includes scaling.

# Training
# Installing e1071 package for SVR
# install.packages('e1071')
library(e1071)
svr = svm(formula=Salary ~ ., data=salary, type="eps-regression")
summary(svr)

# Visualizing the SVR results:
# install.packages('ggplot2')
library(ggplot2)
ggplot() + 
  # Adding real observation points (scatter point) with geom_point
  geom_point(aes(x=salary$Level, y=salary$Salary),colour="blue") +
  # Adding predictions component (regression line) with geom_line
  geom_line(aes(x=salary$Level, y = predict(svr,newdata = salary)), colour="red") + 
  # Adding a title
  ggtitle("Position vs Salaries (SVR)") + 
  # Adding labels
  xlab("Level") + ylab("Salary")

# Predicting new values with SVR:
# Predicting the salary of 6.5 level
svr_preds = predict(svr, newdata = data.frame(Level = 6.5))
print(svr_preds)

