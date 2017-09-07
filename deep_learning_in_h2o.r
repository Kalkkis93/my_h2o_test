# Start H2O.
library(h2o)
localH2O <- h2o.init()

# Use the iris data.
summary(iris)

# Create training and test sets.
train <- data.frame(rbind(iris[ 1:40,], iris[51: 90,], iris[101:140,]))
test  <- data.frame(rbind(iris[41:50,], iris[91:100,], iris[141:150,]))

# Import data sets to H2O.
train.hex <- as.h2o(train)
test.hex  <- as.h2o(test)

# Fit the neural network.
neuralNet <- h2o.deeplearning(x = 1:4, y = 5, training_frame = train.hex, variable_importances = TRUE)

# Variable importances.
neuralNet@model$variable_importances
h2o.varimp_plot(neuralNet)

# Predict the classes in the test data.
predictions <- h2o.predict(neuralNet, test.hex)
(classes_pred <- as.data.frame(predictions)[,1]) #Predicted classes.
(classes_true <- test[,5])                       #True classes.

# Accuracy rate.
sum(classes_pred == classes_true) / nrow(test)
