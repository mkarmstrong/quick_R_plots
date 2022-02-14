# Custom R plots for exploratory analyses

The functions herein are for drawing plots with accompanying stats, which may be particularly useful in the exploratory phase of data analysis.


```R
# Scatter plot
Splot(mtcars$wt, mtcars$mpg,
      ylb = "Miles per gallon",
      xlb = "Weight")

# Boxplot
Bplot(as.factor(mtcars$cyl), mtcars$disp,
      ylb = "Displacment",
      xlb = "Cylinders")

# Bland-Altman plot
BAplot(iris$Sepal.Length, iris$Sepal.Width)
```
