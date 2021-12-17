# 빅데이터A조(2차) 이순규

dass <- read.csv('dataset.csv', header = T)
dass
head(dass) # 데이터 앞부분 보기
tail(dass) # 데이터 뒷부분 보기
dass <- subset(dass, price >= 2 & price <= 8)
dass <- subset(dass, age >= 20 & age <= 69)
dass$resident1[dass$resident == 1] <- '1.서울특별시'
dass$resident1[dass$resident == 2] <- '2.인천광역시'
dass$resident1[dass$resident == 3] <- '3.대전광역시'
dass$resident1[dass$resident == 4] <- '4.대구광역시'
dass$resident1[dass$resident == 5] <- '5.시구군'
dass$job1[dass$job == 1] <- '공무원'
dass$job1[dass$job == 2] <- '회사원'
dass$job1[dass$job == 3] <- '개인사업'
dass$age1[dass$age <= 30] <- "청년층"
dass$age1[dass$age > 30 & dass$age <= 55] <- "중년층"
dass$age1[dass$age > 55 ] <- "장년층"
survey <- dass$survey
csurvey <- 6 - survey
csurvey
dass$survey <- csurvey

# 1. dass의 직급컬럼 대상으로 1급->5급, 5급->1급 형식으로 역코딩
getwd()
setwd('E:/BigDate/R programing/dataset3/dataset3')

position <- dass$position
cposition <- 6 - position
cposition
dass$position1 <- cposition
head(dass)

# 2. dass의 resident 컬럼을 대상으로 NA값 제거 후 resident2 변수에 저장
print(dass)
resident2 <- dass$resident
resident2 <- na.omit(das$resident) # NA값 제거(결측치 제거) 함수 이용
resident2

# 3. dass의 gender컬럼을 대상 1->'남자', 2->'여자' 코딩변경 gender2 추가 파이차트 결과확인
dass$gender2[dass$gender == 1] <- '남자'
dass$gender2[dass$gender == 2] <- '여자'
dass[c('gender', 'gender2')]
pie(table(dass$gender2), col = c('blue', 'red'))

# 4. dass의 age컬럼을 대상 30세이하 -> 1, 30-50세 -> 2, 55이상 -> 3으로 리코딩하여 age3 추가 후 확인
print(dass)
dass$age3[dass$age <= 30] <- '1'
dass$age3[dass$age > 30 & dass$age <= 55] <- '2'
dass$age3[dass$age > 55] <- '3'
head(dass)
das[c('age', 'age1', 'age3')]

# 5. 정제된 데이터를 대상 저장 후 파일 내용 읽기
print(dass)
setwd('C:/rwork/')
write.csv(dass, 'cleandata.csv', quote = F, row.names = F)
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
