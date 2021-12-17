# 빅데이터A(2차) 이순규

# 1. 시계열 자료를 대상으로 다음과 같은 단계별로 시계열 모형을 생성하고 예측하시오
data(EuStockMarkets)
EuStock <- data.frame(EuStockMarkets) 
head(EuStock)
Second <- 1:500
DAX <- EuStock$DAX[1001:1500]
EuStock_df <- data.frame(Second, DAX)

# 1단계: 시계열 자료 생성: EuStock_df$DAX 컬럼 대상 2017년 1월 기준 12개월
ts_data <- ts(EuStock_df$DAX, start = c(2017, 1), frequency = 12)
ts_data

# 2단계: 단위 시계열 자료 분석
# (1) stl()함수 이용 시계열 분해요소 시각화
plot(stl(ts_data, s.window = 'periodic'))

# (2) decomosed()함수 이용 분해 시각화와 불규칙요인 시각화
ts_data3 <- decompose(ts_data)
plot(ts_data3)

windows()
plot(ts_data3$random) # 불규칙요인 시각화

# (3) 계절요인, 추세요인 제거 그래프 - 불규칙 요인만 출력
windows()
par(mfrow = c(3,1))
plot(ts_data - ts_data3$seasonal, main = '계절요인제거그래프', col = 'red')
plot(ts_data - ts_data3$trend, main = '추세요인제거그래프', col = 'blue')
plot(ts_data - ts_data3$seasonal - ts_data3$trend, main = '불규칙요인그래프', col = 'black')

# 3단계: ARIMA 시계열 모형 생성
library(forecast)
ts_arima <- auto.arima(ts_data)
ts_arima

model <- arima(ts_data, c(2,1,2), seasonal = list(order = c(1,0,2)))
model

# 4단계: 시계열 예측: 향후 3년, 95% 신뢰수준으로 예측 및 시각화
ts_fore <- forecast(model, h = 36)
windows()
plot(ts_fore)

ts_fore2 <- forecast(model, level = 95, h = 36) # level = 신뢰수준
plot(ts_fore2)

# 2. Sales.csv 자료르르 대상으로 시계열 자료를 생성하고, 단계별로 시계열 모형을 생성하여 예측하시오.
getwd()
setwd('E:/BigDate/R programing/dataset4/dataset4')
sales <- read.csv('Sales.csv', header = T)
sales
head(sales)
str(sales)

# 1단계: 시계열 자료 생성: sales$Goods 컬럼으로 2015년 1월 기준 12개월 단위
sales_ts <- ts(sales$Goods, start = c(2015, 1), frequency = 12)
sales_ts

# 2단계: 시계열 모형 추정과 모형 생성
sales_arima <- auto.arima(sales_ts)
sales_arima

sales_model <- arima(sales_ts, c(0,1,0), seasonal = list(order = c(1,1,0)))
sales_model

# 3단계: 시계열 모형 진단
windows()
tsdiag(sales_model)
# Box-Ljung에 의한 잔차항 모형 진단
Box.test(sales_model$residuals, lag = 1, type = 'Ljung')

# 4단계: 향후 7개월 예측
sales_fore <- forecast(sales_model, h = 7)
sales_fore

# 5단계: 향후 7개월 예측결과 시각화
windows()
plot(sales_fore)