# 1. 필요한 패키지 설치 및 로드
if (!require("plotly")) {
  install.packages("plotly")
  library(plotly)
}
if (!require("htmlwidgets")) { # HTML 저장을 위해 필요
  install.packages("htmlwidgets")
  library(htmlwidgets)
}

# 2. 이변량 정규분포의 확률 밀도 함수(PDF) 정의
bivariate_normal_pdf <- function(x, y, mu_x = 0, mu_y = 0, sigma_x = 1, sigma_y = 1, rho = 0) {
  term1 <- 1 / (2 * pi * sigma_x * sigma_y * sqrt(1 - rho^2))
  z <- ((x - mu_x)^2 / sigma_x^2) - (2 * rho * (x - mu_x) * (y - mu_y) / (sigma_x * sigma_y)) + ((y - mu_y)^2 / sigma_y^2)
  term2 <- exp(-z / (2 * (1 - rho^2)))
  return(term1 * term2)
}

# 3. X축과 Y축의 값 범위 설정
x_values <- seq(-3, 3, length.out = 100)
y_values <- seq(-3, 3, length.out = 100)

# 4. Z값 (확률 밀도) 계산
# 예시 파라미터: mu_x=0, mu_y=0, sigma_x=1, sigma_y=1, rho=0.6 (상관관계가 있는 경우)
# outer 함수는 x_values의 각 원소와 y_values의 각 원소에 대해 함수를 적용하여 행렬을 생성합니다.
z_matrix <- outer(x_values, y_values, FUN = function(x, y) {
  bivariate_normal_pdf(x, y, mu_x = 0, mu_y = 0, sigma_x = 1, sigma_y = 1, rho = 0.6)
})
# 만약 rho = 0 (상관관계가 없는 경우)로 설정하면 대칭적인 종 모양이 됩니다.
# z_matrix_no_corr <- outer(x_values, y_values, FUN = function(x, y) {
#   bivariate_normal_pdf(x, y, mu_x = 0, mu_y = 0, sigma_x = 1, sigma_y = 1, rho = 0)
# })


# 5. plotly를 사용하여 3D 표면도 생성
fig <- plot_ly(
  x = ~x_values, 
  y = ~y_values, 
  z = ~z_matrix, 
  type = "surface",
  colorscale = "Viridis", # 다양한 색상 스케일 사용 가능: "Blues", "Greens", "YlGnBu", etc.
  contours = list( # 등고선 추가
    z = list(
      show = TRUE,
      usecolormap = TRUE,
      highlightcolor = "#ff0000", # 등고선 하이라이트 색상
      project = list(z = TRUE) # z축 평면에 등고선 투영
    )
  )
)

# 6. 레이아웃 설정
fig <- fig %>% layout(
  title = list(text = "연속형 이변량 확률분포 (이변량 정규분포 예시)", y = 0.95),
  scene = list(
    xaxis = list(title = "X 값"),
    yaxis = list(title = "Y 값"),
    zaxis = list(title = "확률 밀도 f(x,y)"),
    camera = list(eye = list(x = 1.8, y = -1.8, z = 1.5)) # 카메라 시점 조절
  ),
  margin = list(l = 0, r = 0, b = 0, t = 50)
)

# 7. 플롯 출력
print(fig)

# 8. (선택 사항) 대화형 HTML 파일로 저장
file_name_continuous <- "continuous_bivariate_surface_plot.html"
saveWidget(widget = fig, file = file_name_continuous, selfcontained = TRUE)
message(paste("대화형 표면도가 다음 파일로 저장되었습니다:", file_name_continuous))
