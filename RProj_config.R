setwd( dirname(rstudioapi::getSourceEditorContext()$path) )

rm(list = ls())

# 과학적 표기법(e.g., 1e+06) 대신 일반 숫자 표기법 사용
options(scipen = 0) # default (1e-04)
# options(scipen = 999)
# options(scipen = -4) # always for the number less than 1



## 1. 데이터 핸들링 및 가공 (Data Wrangling & Transformation)
## - 다양한 형태의 데이터를 불러오고, 빠르고 유연하게 가공하는 도구들

library(data.table) # 대용량 데이터(1GB 이상)를 매우 빠르고 효율적으로 처리 (dplyr과 함께 양대산맥)
library(DBI)        # R과 데이터베이스(MySQL, PostgreSQL, BigQuery 등)를 연결하는 표준 인터페이스
library(RPostgres)  # DBI를 통해 PostgreSQL 데이터베이스에 연결하는 드라이버 (DB 종류에 따라 교체)
library(rvest)      # 웹 페이지의 HTML을 파싱하여 데이터를 수집 (웹 스크레이핑)
library(jsonlite)   # API 통신 등에서 주로 사용하는 JSON 데이터를 R에서 다루기 쉽게 변환

## 2. 탐색적 데이터 분석 및 시각화 (EDA & Visualization)
## - 데이터의 패턴과 인사이트를 빠르고 효과적으로 파악하는 도구들

library(plotly)     # ggplot2 그래프를 반응형/인터랙티브 웹 그래프로 변환 (마우스 오버 시 정보 표시)
library(esquisse)   # 코딩 없이 마우스 드래그앤드랍만으로 ggplot2 그래프를 생성 (빠른 EDA용)
library(skimr)      # 데이터프레임의 기술통계량을 깔끔하고 포괄적으로 요약 (summary()의 상위 호환)
library(GGally)     # 여러 변수 간의 관계를 한 번에 시각화 (산점도 행렬, 평행 좌표 그림 등)

## 3. 모델링 (Modeling)
## - 예측, 분류, 군집화 등 통계 및 머신러닝 모델을 구축하고 평가하는 도구들

# --- 모델링 프레임워크 ---
library(tidymodels)   # 회귀, 분류 등 모델링의 전 과정을(데이터 분할, 전처리, 학습, 평가) 통합된 문법으로 관리

# --- 주요 알고리즘 ---
library(glmnet)       # 라쏘(Lasso), 릿지(Ridge) 등 정규화 회귀 모델 (수많은 변수 중 중요한 변수 선택)
library(randomForest) # 분류와 회귀 문제 모두에서 강력한 성능을 내는 대표적인 앙상블 모델
library(xgboost)      # 캐글(Kaggle) 등 경진대회에서 성능으로 입증된 그래디언트 부스팅 모델
library(prophet)      # 페이스북에서 개발한 시계열 데이터 예측 모델 (비즈니스 데이터에 최적화)
library(forecast)     # ARIMA 등 전통적인 시계열 분석 및 예측을 위한 필수 패키지

## 4. 보고 및 소통 (Reporting & Communication)
## - 분석 결과를 보고서, 대시보드 등 공유하기 쉬운 형태로 만드는 도구들

library(rmarkdown)  # R 코드와 분석 결과를 하나의 문서(HTML, PDF, Word)로 통합하여 재현 가능한 보고서 생성
library(knitr)      # rmarkdown의 핵심 엔진, R 코드 청크를 실행하고 결과를 문서에 포함
library(kableExtra) # kable() 함수로 만든 기본 테이블을 매우 미려하고 전문적으로 꾸며주는 패키지
library(shiny)      # R 코드만으로 동적인 웹 애플리케이션 및 인터랙티브 대시보드를 제작

## 5. 프로젝트 워크플로우 및 생산성 (Workflow & Productivity)
## - 프로젝트 관리, 재현성 확보, 코드 성능 향상을 돕는 유틸리티들

library(here)       # setwd() 없이도 항상 프로젝트 최상위 폴더를 기준으로 파일 경로를 안전하게 관리
library(renv)       # 프로젝트별로 독립된 패키지 라이브러리를 만들어 패키지 버전 충돌 문제를 해결
library(Rcpp)       # 반복문 등 R에서 느린 코드를 C++로 작성하여 압도적인 속도 향상을 꾀할 때 사용

## By PNG
# detach("package:png.utils", unload=TRUE)
library(R.utils)
library(png.utils)
library(tidyverse)
library(tableone)
library(readxl)
library(gtsummary)

conflicted::conflict_prefer("select", "dplyr")
conflicted::conflict_prefer("filter", "dplyr")





