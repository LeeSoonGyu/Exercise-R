# 빅데이터 A조(2차) 이순규

# 1. reshape2 패키지와 iris 데이터 셋 사용하여 실행하기
# 1-1 꽃 종류(Species) 기준 넓은 형식을 긴 형식으로
library(reshape2)
data("iris")
iris
spe_melt <- melt(iris, id = c('Species'), na.rm = TRUE)
head(spe_melt)

# 1-2 꽃의 종별로 나머지 4가지 변수 합계 구하기
sum_iris <- dcast(spe_melt, Species ~ variable, sum)
sum_iris

# 2. dplyr 패키지와 iris 데이터 셋 사용 실행
library(dplyr)
data("iris")
# 2-1 iris Petal.Length컬럼 대상으로 1.5이상 값만 필터링
soon <- iris %>% filter(Petal.Length >= 1.5)
soon
# 2-2 2-1 결과에서 1,3,5 칼럼만 추출
soon1 <- soon %>% select(1,3,5)
soon1
# 2-3 2-2 결과에서 1-3번 컬럼 값을 뺀 diff변수 생성 후 앞부분 6개 출력
soon2 <- soon1 %>% mutate(diff = Sepal.Length - Petal.Length)
head(soon2$diff, 6)
# 2-4 2-3 결과에서 Species별로 그룹화하여 Sepal.Length와Petal.Length변수 평균계산
soon3 <- soon2 %>% group_by(Species) %>% summarise(Sepal_mean = mean(Sepal.Length), Petal_mean = mean(Petal.Length))
soon3
