

# VISUALIZING DATA WITH LATTICE

# to install ggplot2 and lattice
install.packages("ggplot2")
install.packages("lattice")

# to load ggplot2 into your session
library(ggplot2)

# to load lattice into your session
library(lattice) 

# The lattice package, written by Deepayan Sarkar, 
# attempts to improve on base R graphics by providing
# better defaults and the ability to easily display
# multivariate relationships. In particular, the
# package supports the creation of trellis graphs: 
# graphs that display a variable or the relationship
# between variables, conditioned on one or more 
# other variables.

# The typical format is
# graph_type(formula, data=) which include
# xyplot(x, data, ...)
# dotplot(x, data, ...)
# barchart(x, data, ...)
# stripplot(x, data, ...)
# bwplot(x, data, ...)
# where graph_type is selected from this list. 
# formula specifies the variable(s) to display 
# and any conditioning variables . For example ~x|A 
# means display numeric variable x for each level 
# of factor A. y~x | A*B means display the 
# relationship between numeric variables y and
# x separately for every combination of factor
# A and B levels. ~x means display numeric variable
# x alone.

### FUEL ECONOMY DATA (is in ggplot2 package)
data(mpg)
# View the Fuel Economy mpg data:
View(mpg)
# Take a look at the help screen for mpg
?mpg
# Examine the variables in mpg; Also note 
# that mpg is a 'tbl_df' which means that it
# has characteristics of both a data frame
# and a table
str(mpg)

#   QUESTION #1
# 1 Using the lattice function xyplot(), draw 
#   a scatterplot with 'displ' on the x-axis
#   and 'hwy' on the y-axis
(grid="displ",grid ="hwy",grid=TRUE)

# < >

#   Add a regression line to the plot by
#   including the argument: 
#   type = c("p", "r") inside your call
#   to xyplot().

# < Your R code goes here >

# What, if anything, can you conclude about
# the relationship of 'hwy' and 'displ'?
# Please describe in plain terms describing
# the relationship between the meaning (not
# the name) of the variables.

#   QUESTION #2
# 2 First draw a dotplot with 'displ' on the
#   x-axis and 'cty' on the y-axis. What can
#   you say in general about the relationship
#   between the displacement of the engine
#   and the city mileage achieved by the 
#   vehicle?

# < Your R code goes here >

#   Then draw a dotplot with 'displ' on the 
#   x-axis and 'cty' on the y-axis conditioned
#   by the 'class'. 

# < Your R code goes here >

#   Then add a regression line to each of the
#   panel displays by adding these lines of
#   code inside your call to xyplot:
#   panel = function(x, y, ...) {
#   panel.xyplot(x, y, ...)
#   panel.lmline(x, y, ...)
#   }

# < Your R code goes here >

# Which class of car seems to have the most
# noticeable relationship between these two
# variables? Why do you say this? What is 
# the relationship?

# QUESTIONS #3 through #5
# Tables form an important class of statistical data. 
# Popular visualization methods designed for tables
# include bar charts and Cleveland dot plots.

# For illustration, we use the VADeaths dataset, 
# which gives death rates in the U.S. state of Virginia 
# in 1941 among different population subgroups. 

# VADeaths is a matrix
str(VADeaths)
class(VADeaths)

# To use the lattice formula interface, we convert it 
# into a data frame
VADeathsDF <- as.data.frame.table(VADeaths, 
                                  responseName = "Rate")
class(VADeathsDF)
View(VADeathsDF)
VADeaths

?as.data.frame.table

# Bar charts are produced by the barchart() function, 
# and Cleveland dot plots by dotplot(). Both allow a
# formula of the form y ~ x (plus additional conditioning
# and grouping variables), where one of x and y
# should be a factor.

# Examine Var1 and Var2 in the VADeaths data frame:
VADeathsDF$Var1
VADeathsDF$Var2

# QUESTION #3
# 3
# Draw a bar chart of the deaths in each of the age
# groups in the VADeathsDF data conditioned by
# Rural Male, Rural Female, Urban Male, Urban Female:

# < Your R code goes here >

# What do you think is the highest age group
# death rate coupled with (that is, in conjunc-
# tion with) the highest of the four Var2 
# "people categories"?

# This plot is potentially misleading, because a strong
# visual effect in the plot is the comparison of the 
# areas of the shaded bars, which do not mean anything. 

# QUESTION #4
# 4
# This problem can be addressed by making the areas
# proportional to the values they encode. Do this
# by simply adding the argument "origin = 0" to
# your plot:

# < Your R code goes here >

# Does this alter the conclusion that you
# drew in question #3? Why or why not?

# QUESTION #5
# 5
# A better design is to forego the bars, which distract
# from the primary comparison of the endpoint positions.
# Do this instead using a dot plot:

# < Your R code goes here >

# For this example, this display is more effective if 
# we use Var2 as a grouping variable, and join the
# points within each group (I give you this one):
dotplot(Var1 ~ Rate, data = VADeathsDF, 
        groups = Var2, type = "o",
        auto.key = list(space = "right", 
                        points = TRUE, 
                        lines = TRUE))

# The plot more clearly shows that the pattern of 
# death rate by age. This interaction is difficult
# to see in the earlier plots.

# What conclusions can you draw about death rates
# and the 4 "people categories" while viewing
# this plot? Do you gain additional insights that
# were absent in the previous related plots?
# If so, what are they?