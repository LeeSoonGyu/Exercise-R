# descriptive.csv 대상으로 빈도분석 및 기술통계량 분석
setwd('C:/Temp/Rwork/dataset2/dataset2')
data <- read.csv("descriptive.csv",header = TRUE)
head(data)
# 1) 학교유형(type), 합격여부(pass) 빈도분석 수행
# 막대그래프와 파이차트로 시각화
table(data$type)

tp <- subset(data, type == 1 | type == 2)
x <- table(tp$type)
print(x)
barplot(x)
pie(x)

table(data$pass)
ps <- subset(data, pass == 1 | pass == 2)
y <- table(ps$pass)
print(y)
barplot(y)
pie(y)
# 2) 비율척도 변수인 나이 변수를 요약치(평균,표준편차)
# 비대칭도(왜도와 첨도)통계량을 구하고 히스토그램 작성
install.packages('moments')
library(moments)

length(data$age)
summary(data$age)
plot(data$age)
ag <- subset(data, data$age >= 40 & data$age <= 70)
a <- ag$age
mean(a)
median(a)
sd(a)
# 왜도 첨도 및 나이 변수 밀도분포,정규분포 곡선 검정
b <- data$age
skewness(b)
kurtosis(b)
hist(b, freq = F)
lines(density(b), col = 'blue')
x <- seq(40, 70, 0.02)
curve(dnorm(x, mean(b), sd(b)), col = 'red', add = T)

# 2. MASS패키지에 있는 Animals 데이터셋 기술통계량
install.packages('MASS')
library(MASS)

leesoongyu <- Animals
leesoongyu

dim(leesoongyu)  # 데이터셋 차원보기
summary(leesoongyu)  # 요약통계량
# brain 컬럼 기술 통계량
mean(leesoongyu$brain)  # 평균
median(leesoongyu$brain)  # 중위수
sd(leesoongyu$brain)  # 표준편차
var(leesoongyu$brain)  # 분산
max(leesoongyu$brain)  # 최대값
min(leesoongyu$brain) # 최소값
