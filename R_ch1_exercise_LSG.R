# 이순규

# 1.

getwd()
setwd("C:/Temp")
getwd()


# 2.
name <- "이순규"
name
age <- 31
age
address <- "부평구"
address

is.character(name)
is.numeric(name)
is.character(age)
is.numeric(age)
is.character(address)
is.numeric(address)


# 3.
gender <- "women"
gender
mode(gender)
class(gender)

Ngender <- as.factor(gender)
table(Ngender)
plot(Ngender)


# 4.
r <- (1:100)
r
rm <- mean(r)
rm
sum(1:100)
5050/100
