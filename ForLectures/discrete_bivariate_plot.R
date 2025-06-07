# 필요한 패키지 설치 및 로드
if (!require("plot3D")) {
  install.packages("plot3D")
  library(plot3D)
}

# 데이터 준비
# W 값 (X축, 합)
w_values <- c(2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
# U 값 (Y축, 곱)
u_values <- c(1, 2, 3, 4, 5, 6, 8, 9, 10, 12, 15, 16, 18, 20, 24, 25, 30, 36)

# 경우의 수 매트릭스 (Z값, 막대 높이)
# 행: U 값, 열: W 값
# 먼저 0으로 채워진 매트릭스를 생성합니다.
counts_matrix <- matrix(0, nrow = length(u_values), ncol = length(w_values),
                        dimnames = list(as.character(u_values), as.character(w_values)))

# 이미지에서 관찰된 데이터를 매트릭스에 입력합니다.
# 출처: 사용자 제공 이미지 (PDF 원본 페이지 5에 해당 표 존재)
counts_matrix["1", "2"] <- 1

counts_matrix["2", "3"] <- 2

counts_matrix["3", "4"] <- 2
counts_matrix["4", "4"] <- 1

counts_matrix["4", "5"] <- 2
counts_matrix["6", "5"] <- 2 # U=6, W=5

counts_matrix["5", "6"] <- 2
counts_matrix["8", "6"] <- 2
counts_matrix["9", "6"] <- 1

counts_matrix["6", "7"] <- 2 # U=6, W=7
counts_matrix["10", "7"] <- 2
counts_matrix["12", "7"] <- 2

counts_matrix["12", "8"] <- 2
counts_matrix["15", "8"] <- 2
counts_matrix["16", "8"] <- 1

counts_matrix["18", "9"] <- 2
counts_matrix["20", "9"] <- 2 # (예: 주사위 눈 (4,5) -> 합 W=9, 곱 U=20)

counts_matrix["10", "10"] <- 2 # 이미지에 U=10, W=10 경우의 수가 2로 표시되어 있습니다.
# (표준적인 두 주사위 합/곱으로는 이 값이 나오기 어렵지만, 이미지 데이터를 따릅니다.)
counts_matrix["24", "10"] <- 2 # (예: (4,6) -> W=10, U=24)
counts_matrix["25", "10"] <- 1 # (예: (5,5) -> W=10, U=25)

counts_matrix["30", "11"] <- 2 # (예: (5,6) -> W=11, U=30)

counts_matrix["36", "12"] <- 1 # (예: (6,6) -> W=12, U=36)




z_mtx = counts_matrix

# Define a function to add 3D bars
add_3Dbar <- function(p, x,y,z, width=0.4) {
  w <- width
  add_trace(p, type="mesh3d",
            x = c(x-w, x-w, x+w, x+w, x-w, x-w, x+w, x+w),
            y = c(y-w, y+w, y+w, y-w, y-w, y+w, y+w, y-w),
            z = c(0, 0, 0, 0, z, z, z, z),
            i = c(7, 0, 0, 0, 4, 4, 2, 6, 4, 0, 3, 7),
            j = c(3, 4, 1, 2, 5, 6, 5, 5, 0, 1, 2, 2),
            k = c(0, 7, 2, 3, 6, 7, 1, 2, 5, 5, 7, 6),
            facecolor = rep(toRGB(viridisLite::inferno(6)), each = 2)) 
}

# Draw the 3D histogram
fig <- plot_ly()
for (k1 in 1:nrow(z_mtx)) {
  for (k2 in 1:ncol(z_mtx)) {
    fig <- fig %>% add_3Dbar(k1,k2,z_mtx[k1,k2])
  }
}

fig <- fig %>% layout(title = list(text = "W와 U의 결합 분포 (Interactive 3D Bar Chart)", y = 0.95), # 제목 위치 조정
                      scene = list(
                        xaxis = list(
                          title = "W (합)",
                          tickvals = 1:length(u_values), # x축 눈금을 w_values로 설정
                          ticktext = as.character(u_values),
                          tickfont = list(size = 12) # X축 눈금 글자 크기 조절
                        ),
                        yaxis = list(
                          title = "U (곱)",
                          tickvals = 1:length(w_values), # y축 눈금을 u_values로 설정
                          ticktext = as.character(w_values),
                          tickfont = list(size = 12) # X축 눈금 글자 크기 조절
                        ),
                        zaxis = list(title = "경우의 수 (Frequency)"),
                        camera = list(eye = list(x=1.8, y=1.8, z=1.5))
                      ),
                      margin = list(l = 0, r = 0, b = 0, t = 50) # 상단 여백 조절
)


fig 


# 7. 플롯 출력
print(fig)

# 8. (선택 사항) 대화형 HTML 파일로 저장
file_name_continuous <- "discrete_bivariate_plot.html"
saveWidget(widget = fig, file = file_name_continuous, selfcontained = TRUE)
message(paste("대화형 표면도가 다음 파일로 저장되었습니다:", file_name_continuous))












png.bar3d <- function(counts_matrix){
  
  # Define a function to add 3D bars
  add_3Dbar <- function(p, x,y,z, width=0.4) {
    w <- width
    add_trace(p, type="mesh3d",
              x = c(x-w, x-w, x+w, x+w, x-w, x-w, x+w, x+w),
              y = c(y-w, y+w, y+w, y-w, y-w, y+w, y+w, y-w),
              z = c(0, 0, 0, 0, z, z, z, z),
              i = c(7, 0, 0, 0, 4, 4, 2, 6, 4, 0, 3, 7),
              j = c(3, 4, 1, 2, 5, 6, 5, 5, 0, 1, 2, 2),
              k = c(0, 7, 2, 3, 6, 7, 1, 2, 5, 5, 7, 6),
              facecolor = rep(toRGB(viridisLite::inferno(6)), each = 2)) 
  }
  
  # Draw the 3D histogram
  fig <- plot_ly()
  for (k1 in 1:nrow(z_mtx)) {
    for (k2 in 1:ncol(z_mtx)) {
      fig <- fig %>% add_3Dbar(k1,k2,z_mtx[k1,k2])
    }
  }

  fig
}
