df_jobseconomy<-read.fwf("Jobs_Ed_every100", widths = c(4,2,8,10,1,4,10,1,3,1,2,3,2,3,1,2,1,4,3,3,4,2,2,2,1,1), header=FALSE)

names(df_jobseconomy)[1]<-"YEAR"
names(df_jobseconomy)[2]<-"DATANUM"
names(df_jobseconomy)[3]<-"SERIAL"
names(df_jobseconomy)[4]<-"HHWT"
names(df_jobseconomy)[5]<-"GQ"
names(df_jobseconomy)[6]<-"PERNUM"
names(df_jobseconomy)[7]<-"PERWT"
names(df_jobseconomy)[8]<-"SEX"
names(df_jobseconomy)[9]<-"AGE"
names(df_jobseconomy)[10]<-"SCHOOL"
names(df_jobseconomy)[11]<-"HIGRADE"
names(df_jobseconomy)[12]<-"HIGRADED"
names(df_jobseconomy)[13]<-"EDUC"
names(df_jobseconomy)[14]<-"EDUCD"
names(df_jobseconomy)[15]<-"EMPSTAT"
names(df_jobseconomy)[16]<-"EMPSTATD"
names(df_jobseconomy)[17]<-"LABFORCE"
names(df_jobseconomy)[18]<-"OCC"
names(df_jobseconomy)[19]<-"OCC1950"
names(df_jobseconomy)[20]<-"OCC1990"
names(df_jobseconomy)[21]<-"OCC2010"
names(df_jobseconomy)[22]<-"WKSWORK1"
names(df_jobseconomy)[23]<-"HRSWORK1"
names(df_jobseconomy)[24]<-"UHRSWORK"
names(df_jobseconomy)[25]<-"LOOKING"
names(df_jobseconomy)[26]<-"AVAILBLE"


df_educ_freq=count(df_jobseconomy,"df_jobseconomy$EDUC")
df_occu_freq=count(df_jobseconomy,"df_jobseconomy$OCC")

df_occaggr_educmean=aggregate(df_jobseconomy$EDUC, by=list(df_jobseconomy$OCC), FUN=mean)

df_occaggr_hrswrkmean=aggregate(df_jobseconomy$UHRSWORK, by=list(df_jobseconomy$OCC), FUN=mean)

df_quantile_educ=quantile(na.omit(df_jobseconomy$EDUC))

df_quantile_occ=quantile(na.omit(df_jobseconomy$OCC))

df_decile_occ=quantile(na.omit(df_jobseconomy$OCC), prob = seq(0, 1, length = 11), type = 5)

*** Quantile Plot

x = na.omit(df_jobseconomy$OCC)

n = length(x)

plot((1:n - 1)/(n - 1), sort(x), type="l",
main = "Quantiles for OCC Data",
xlab = "Sample Fraction",
ylab = "Sample Quantile")






