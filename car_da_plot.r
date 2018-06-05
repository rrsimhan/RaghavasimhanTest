xyplot(hwy~displ,mpg,grid=TRUE)
xyplot(hwy~displ,mpg,grid=TRUE,type = c("p", "r"))

#Highway mileage decreases with increasing displacement

dotplot(cty~displ,mpg,grid=TRUE,type = c("p", "r"))

#city mileage decreases with increasing displacement

dotplot(cty~displ|class,mpg,grid=TRUE)

xyplot(cty~displ|class,mpg,
xlab = "Displacement", ylab = "City",
panel = function(x, y) {
           panel.xyplot(x, y)
           panel.lmline(x, y)
            })

#Compact and Subcompact cars have more significant relationship between 
#Mileage and Displacement. We can see a steep decline between the two factors in these classes.


#Questions 3 to 5

VADeathsDF <- as.data.frame.table(VADeaths, 
                                  responseName = "Rate")

barchart(Rate~Var1|Var2,VADeathsDF)

#Highest deaths happen in Male category during highest age in both urban and rural


barchart(Rate~Var1|Var2,VADeathsDF,origin=0)

#Including the origin does not change my earlier conclusion.

dotplot(Var1 ~ Rate, data = VADeathsDF, 
        groups = Var2, type = "o",
        auto.key = list(space = "right", 
                        points = TRUE, 
                        lines = TRUE))

# The dot plot shows there is a steep increase in death rates with age for urban and rural males when compared with
# their female counterparts. Therefore Male life is more healthier since the death rates are more for the younger females.


