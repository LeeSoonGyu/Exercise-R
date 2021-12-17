# 빅데이터A조(2차) 이순규

# 1. das의 직급컬럼 대상으로 1급->5급, 5급->1급 형식으로 역코딩
getwd()
setwd('E:/BigDate/R programing/dataset3/dataset3')

position <- das$position
cposition <- 6 - position
cposition
das$position1 <- cposition
head(das)

# 2. das의 resident 컬럼을 대상으로 NA값 제거 후 resident2 변수에 저장
print(das)
resident2 <- das$resident
resident2 <- na.omit(das$resident) # NA값 제거(결측치 제거) 함수 이용
resident2

# 3. das의 gender컬럼을 대상 1->'남자', 2->'여자' 코딩변경 gender2 추가 파이차트 결과확인
das$gender2[das$gender == 1] <- '남자'
das$gender2[das$gender == 2] <- '여자'
das[c('gender', 'gender2')]
pie(table(das$gender2), col = c('blue', 'red'))

# 4. das의 age컬럼을 대상 30세이하 -> 1, 30-50세 -> 2, 55이상 -> 3으로 리코딩하여 age3 추가 후 확인
print(das)
das$age3[das$age <= 30] <- '1'
das$age3[das$age > 30 & das$age <= 55] <- '2'
das$age3[das$age > 55] <- '3'
head(das)
das[c('age', 'age1', 'age3')]

# 5. 정제된 데이터를 대상 저장 후 파일 내용 읽기
print(das)
setwd('C:/rwork/')
write.csv(das, 'cleandata.csv', quote = F, row.names = F)
new_data <- read.csv('cleandata.csv', header = TRUE)
new_data

# 6. 파생변수 추가
library(reshape2)
library(plyr)
getwd()
setwd('E:/BigDate/R programing/dataset3/dataset3')
user_data <- read.csv('user_data.csv', header = T)
return_data <- read.csv('return_data.csv', header = T)
user_data
return_data

return_user <- dcast(return_data, user_id ~ return_code, length)
head(return_user)
names(return_user) <- c('user_id', '제품이상(1)', '변심(2)', '원인불명(3)', '기타(4)')
head(return_user)
user_return_data <- join(user_data, return_user, by = 'user_id')
user_return_data
user_return_data$반품사유코드 <- user_return_data$`제품이상(1)` +
  user_return_data$`변심(2)` + 
  user_return_data$`원인불명(3)` + 
  user_return_data$`기타(4)`
user_return_data$반품사유코드
head(user_return_data$반품사유코드)

# 7. iris데이터 이용 5겹2회 반복하는 교차 데이터 샘플링
install.packages('cvTools')
library(cvTools)
data('iris')
dim(iris)
str(iris)
cross2 <- cvFolds(n = 150, K = 5, R = 2, type = 'random')
cross2

r = 2
K = 1:5
for(i in K){
  datas_idx <- cross2$subsets[cross2$which == i,r]
  cat('K = ', i, '검정데이터 \n')
  print(iris[datas_idx, ])
  
  cat('K = ', i, '훈련데이터 \n')
  print(iris[-datas_idx, ])
}
