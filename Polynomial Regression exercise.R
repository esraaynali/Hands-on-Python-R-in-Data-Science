# Loading the data

salary = read.csv("Position_Salaries.csv")

# No need to split the data into training and test sets because we have few observations
# No need to do any data preprocessing steps: no missing values, no categorical values etc.
# No need to use Position column

# Removing Position 
salary = salary[2:3] # use only column 2 (Level) and 3 (Salary)
print(salary)

# Training the Linear Regression Model: 
lin_reg = lm(formula = Salary ~ Level, data = salary)
summary(lin_reg)

# Training the Polynomial Regression Model:

# First add Polynomial features: (n = 4)
# Adding a column called Level2 (squares of levels)
salary$Level2 = salary$Level^2
# Adding new degrees 
salary$Level3 = salary$Level^3
salary$Level4 = salary$Level^4
print(salary)

# Training
poly_reg = lm(formula = Salary ~ ., data = salary)
summary(poly_reg)

# Visualizing the Linear Regression results:
# install.packages('ggplot2')
library(ggplot2)
ggplot() + 
# Adding real observation points (scatter point) with geom_point
geom_point(aes(x=salary$Level, y=salary$Salary),colour="blue") +
# Adding predictions component (regression line) with geom_line
geom_line(aes(x=salary$Level, y = predict(lin_reg,newdata = salary)), colour="red") + 
# Adding a title
ggtitle("Position vs Salaries (Linear Regression)") + 
# Adding labels
xlab("Level") + ylab("Salary")

# Visualizing the Polynomial Regression results:
ggplot() + 
# Adding real observation points (scatter point) with geom_point
geom_point(aes(x=salary$Level, y=salary$Salary),colour="blue") +
# Adding predictions component (regression line) with geom_line
geom_line(aes(x=salary$Level, y = predict(poly_reg,newdata = salary)), colour="red") + 
# Adding a title
ggtitle("Position vs Salaries (Polynomial Regression)") + 
# Adding labels
xlab("Level") + ylab("Salary")

# Predicting new values with Linear Regression:
# Predicting the salary of 6.5 level
lin_pred = predict(lin_reg, newdata = data.frame(Level = 6.5))
print(lin_pred)

# Predicting new values with polynomial Regression:
# Predicting the salary of 6.5 level
poly_pred = predict(poly_reg, newdata = data.frame(Level = 6.5,
                                                   Level2 = 6.5^2,
                                                   Level3 = 6.5^3,
                                                   Level4 = 6.5^4))
print(poly_pred)