# Reading the full data excel into a data frame

install.packages("xlsx")

library("xlsx")

df_datafull <- read.xlsx("data_full.xlsx", sheetIndex = 1)

# Reading the team status excel into a data frame

df_teamstatus <- read.xlsx("team_status.xlsx", sheetIndex = 1)

# Converting the date format according to 24 hours british format

df_datafull$t.dateuk<-format(as.POSIXct(df_datafull$t.tade,format = "%m/%d/%Y %I:%M%p"), "%d/%m/%Y %H:%M")

# Converting the date format according to 24 hours british format

df_datafull$r.dateuk<-format(strptime(df_datafull$r.date, "%b %d %Y %I:%M%p"),"%d/%m/%Y %H:%M")

# Creating a function to filter records between date range

fn_dfdaterangefilter <- function(x,y){df_datafull[as.Date(df_datafull$r.dateuk) >= x & as.Date(df_datafull$r.dateuk) <= y,]}

# Accepting the values for date range in variable

DATE1 <- as.Date("24/10/2017")
DATE2 <- as.Date("26/10/2017")

# calling the function and storing the result in a data frame

df_datefilter <- fn_dfdaterangefilter(DATE1,DATE2) 

# Setting a column to store compared value of rdate and tdate.

df_datefilter$comparetdaterdate<-ifelse(df_datefilter$t.dateuk<=df_datefilter$r.dateuk,"tdate<rdate","tdate>rdate")

# Creating a status column and updating it based on match value of team name from teamstatus data

df_datefilter$status<-with(df_teamstatus, status[match(df_datefilter$team.name, team.name)])

# Trimming trailing spaces in status values

df_datefilter$status<-trimws(df_datefilter$status)

# creating data frame for storing values which status = "permitted"

df_permitted<-df_datefilter[which(df_datefilter$status=="permitted"),]

# creating data frame for storing values which status = "not permitted"

df_notpermitted<-df_datefilter[which(df_datefilter$status=="not permitted"),]

# Calculating sum of amount for status "permitted" data frame

df_sum_permitted=aggregate(df_permitted$amount, by=list(df_permitted$team.name), FUN=sum)

# Calculating sum of amount for status "not permitted" data frame

df_sum_notpermitted=aggregate(df_notpermitted$amount, by=list(df_notpermitted$team.name), FUN=sum)








