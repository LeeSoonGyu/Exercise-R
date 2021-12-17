# 빅데이터 A조(2차) 이순규
# 1. product.csv 파일의 데이터를 이용하여 
# 다음의 단계별로 다중 회귀분석을 수행하시오
install.packages('car')
library(car)
install.packages('lmtest')
library(lmtest)

getwd()
setwd('E:/BigDate/R programing/dataset2/dataset2')
product <- read.csv('product.csv', header = TRUE)
str(product)
head(product)

# 1. 학습데이터(train), 검정데이터(test)를 7:3비율로 샘플링
# 변수모델링: y변수는 제품_만족도, x변수는 제품_적절성과 제품_친밀도
# 1-1. 변수 모델링
y = product$제품_만족도
x1 = product$제품_친밀도
x2 = product$제품_적절성
soongyu <- data.frame(x1, x2, y)
soongyu

# 1-2. 학습데이터(train), 검정데이터(test) 7:3 (홀드아웃)
lee <- sample(1:nrow(soongyu), 0.7*nrow(soongyu))
train <- soongyu[lee, ]
test <- soongyu[-lee, ]
head(train, 4)
head(test, 4)

# 1-3. 학습데이터 이용 회귀모델 생성
leesoongyu <- lm(formula = y ~ x1 + x2, data = train)
leesoongyu
summary(leesoongyu)

# 1-4. 검정데이터 이용 모델 예측치 생성
pred <- predict(leesoongyu, test)
pred

# 1-5. 모델 평가: cor()함수 이용
cor(pred, test$y) # 제품_만족도
cor(pred, test$x1) # 제품_친밀도
cor(pred, test$x2) # 제품_적절성

# 2. ggplot2 패키지에서 제공하는 diamonds 데이터 셋을 대상으로 carat, table, depth 변수 중에서
# 다이아몬드의 가격(price)에 영향을 미치는 관계를 다중회귀 분석을 이용하여 예측하시오
install.packages('ggplot2')
library(ggplot2)
data <- diamonds
data

# 2-1. 변수 모델링
data_price = data$price # 종속
data_carat = data$carat # 독립
data_table = data$table # 독립
data_depth = data$depth # 독립
data_result <- data.frame(data_carat, data_table, data_depth, data_price)
data_result

# 2-2. 회귀모델 생성
formula <- data_price ~ data_carat + data_table + data_depth
result.lm <- lm(formula = formula, data = data_result)
result.lm
dwtest(result.lm)
summary(result.lm)

# 조건1: 다이아몬드 가격 결정에 가장 큰 영향을 미치는 변수는?
# data_carat 변수가 가장 큰 영향을 미친다.

# 조건2: 다중회귀 분석 결과를 정(+)과 부(-)관계로 해설
# data_carat 7858.771 (+) data_price 정의 관계
# data_table -104.473 (-) / data_depth -151.236 (-) 부의 관계
# 순으로 data_price 종속변수와의 관계를 볼 수 있다.