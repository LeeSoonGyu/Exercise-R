# 빅데이터 A조 이순규

# 데이터 가져오기
getwd()
setwd('E:/BigDate/R programing/dataset3/dataset3')
university <- read.csv('university.csv', header = T)
university

install.packages("ggmap")
library(ggmap)
library(stringr)

# 1. 서울 지역에 있는 주요대학교의 위치 정보를 이용하여 레이아웃 기법으로 다음과 같이 시각화하시오.
# 1) 지도 중심지역 Seoul, zoom=11, maptype = ‘watercolor’
# 2) 데이터 셋(“C:/Rwork/university.csv”)
# 3) 지도좌표: 위도(LAT), 경도(LON)
# 4) 학교명을 이용하여 포인터의 크기와 텍스트 표시
seoul <- c(left = 126.77, bottom = 37.40, 
           right = 127.17, top = 37.70)

map <- get_stamenmap(seoul, zoom = 11, maptype = 'watercolor')
ggmap(map)

layer1 <- ggmap(map)
layer1

layer2 <- layer1 + geom_point(data = university, 
                              aes(x = LON, y = LAT,
                                  color = 학교명, size = 3))
layer2

layer3 <- layer2 + geom_text(data = university, 
                             aes(x = LON, y = LAT,
                                 label = 학교명), size = 4)
layer3
# 5) 파일명을 “university.png” 로 하여 이미지 파일로 결과 저장. 
# 이미지의 가로/세로 픽셀 크기(width = 10.24, height=7.68)
ggsave('university.png', width = 10.24, height = 7.68)

# 2. diamonds 데이터 셋을 대상으로 x 축에 carat 변수, y 축에 price 변수를 지정하고, clarity 변수를
# 선 색으로 지정하여 미적 요소 맵핑 객체를 생성한 후 산점도 그래프 주변에 부드러운 곡선이
# 추가되도록 레이아웃을 추가하시오.
data("diamonds")
diamonds

plot_diamonds <- ggplot(diamonds, aes(carat, price, color = factor(clarity)))
plot_diamonds + geom_smooth(method = 'loess')
                           
# 3. latticeExtra 패키지에서 제공하는 SeatacWeather 데이터 셋에서 월별로 최저기온과 최고기온을
# 선 그래프로 플로팅 하시오
# (힌트. Lattice 패키지의 xyplot()함수 이용. 선그래프: type=”l”)
install.packages('latticeExtra')
library(latticeExtra)
data("SeatacWeather")
SeatacWeather
str(SeatacWeather)
head(SeatacWeather)

xyplot(min.temp + max.temp ~ day | month, data = SeatacWeather, type = 'l')

# 4. 다음 조건에 맞게 quakes 데이터 셋의 수심(depth)과 리히터 규모(mag)가 동일한 패널에 지진의 발생지를 산점도로 시각화하시오.
# 1) 수심(depth)을 3 개 영역으로 범주화
# 2) 리히터 규모(mag)를 2 개 영역으로 범주화
# 3) 수심과 리히터 규모를 3 행 2 열 구조의 패널로 산점도 그래프 그리기
# (힌트. Lattice 패키지의 equal.count()와 xyplot()함수 이용)
library(lattice)
data("quakes")
quakes
str(quakes)
head(quakes)

depthgroup <- equal.count(quakes$depth, number = 3, overlap = 0)
depthgroup
magnitudegroup <- equal.count(quakes$mag, number = 2, overlap = 0)
magnitudegroup

xyplot(lat ~ long | depthgroup * magnitudegroup, data = quakes, layout = c(3,2))
