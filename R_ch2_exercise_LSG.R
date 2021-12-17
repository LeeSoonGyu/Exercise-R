# 1.

#1)
Vec1 <- c("R")
rep(Vec1, 10)
#2)
Vec2 <- c(1:10)
Vec2
Vec2 <- seq(1, 10, 3)
Vec2
#3)
Vec3 <- c(1:10)
Vec3
Vec3 <- rep(Vec2, 3)
Vec3
#4)
Vec4 <- c(Vec2, Vec3)
Vec4
#5)
seq(15, 25, 5)
# seq(25, 15, -5)
#6)
Vec4
Vec5 <- Vec4[c(1,7)]
Vec5

# 2.

name <- c("최민수","유관순","이순신","김유신","홍길동")
age <- c(55, 45, 45, 53, 15) #연령
gender <- c(1, 2, 1, 1, 1) #1: 남자, 2: 여자
job <- c("연예인", "주부", "군인", "직장인", "학생")
sat <- c(3, 4, 2, 5, 5)
grade <- c("C", "C", "A", "D", "A")
total <- c(44.4, 28.5, 43.5, NA, 27.1) #총구매액(NA:결측치)
#1)
user <- data.frame(name, age, gender, job, sat, grade, total)
user
#2)
lgender <- as.factor(gender)
lgender
plot(lgender)
hist(gender)
#3)
user
u1 <- c(user[2,])
u1
u2 <- c(user[4,])
u2
user2 <- rbind(u1,u2)
user2
# user3 <- user[seq(2, nrow(user), 2),]
# user3
# 3.
  
Kor <- c(90, 85, 90)
Eng <- c(70, 85, 75)
Mat <- c(86, 92, 88)
#1)
subject <- data.frame(Kor, Eng, Mat)
subject
#2)
apply(subject,1,max)
apply(subject,2,max)
#3)
round(subject)
apply(subject,1,mean)
apply(subject,2,mean)
# round(apply(subject,1,mean), 2)
# round(apply(subject,2,mean), 2)
#4)
apply(subject,1,var)
apply(subject,1,sd)

# 4.
# library(stringr)
Data2 <- c("2017-02-05 수입3000원",
           "2017-02-06 수입4500원",
           "2017-02-07 수입2500원")
#1)
str_length(Data2)
str_sub(Data2, 14, 18)
# income <- str_extract_all(Data2, "[0-9]{4}[가-힣]")
# income
# unlist(income)
#2)
str_extract_all(Data2, "[^0-9]")
# str_replace_all(Data2, "[0-9]{2}", ",")
#3)
string_rep <- str_replace_all(Data2, "-", "/")
string_rep
#4)
paste(Data2, collapse = ",")
