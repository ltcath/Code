#HW 4
#STAT 571

#Pull in Data
library(readxl)
sweat = read_excel("C:/Users/Veteran/Documents/Luke's School/Terms/Winter 2019/STAT 571/sweatdata.xlsx")

#Calculate Confidence Intervals
sweat_rate = sweat$sweat
sodium = sweat$sodium
potassium = sweat$potassium

X = cbind(sweat_rate, sodium, potassium)

mean_sweat = sum(sweat_rate)/length(sweat_rate)
mean_sodium = sum(sodium)/length(sodium)
mean_potassium = sum(potassium)/length(potassium)

p = 3
n = 20

sd_sweat = sd(sweat_rate)
sd_sodium = sd(sodium)
sd_potassium = sd(potassium)

part1 = p*(n-1)/(n-p)

f= 3.2

var_sweat = sd_sweat^2
var_sodium = sd_sodium^2
var_potassium = sd_potassium^2

se_sweat = sqrt(var_sweat/n)
se_sodium = sqrt(var_sodium/n)
se_potassium = sqrt(var_potassium/n)

lower_ci_sweat = mean_sweat - sqrt(part1*f)*se_sweat
upper_ci_sweat = mean_sweat + sqrt(part1*f)*se_sweat
lower_ci_sodium = mean_sodium - sqrt(part1*f)*se_sodium
upper_ci_sodium = mean_sodium + sqrt(part1*f)*se_sodium
lower_ci_potassium = mean_potassium - sqrt(part1*f)*se_potassium
uppper_ci_potassium = mean_potassium + sqrt(part1*f)*se_potassium

#Bonferroni Confidence Intervals
t = 2.625
lbon_sweat = mean_sweat - t*se_sweat
ubon_sweat = mean_sweat + t*se_sweat
lbon_sodium = mean_sodium - t*se_sodium
ubon_sodium = mean_sodium + t*se_sodium
lbon_potassium = mean_potassium - t*se_potassium
ubon_potassium = mean_potassium + t*se_potassium




