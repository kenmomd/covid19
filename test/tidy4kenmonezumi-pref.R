# ライブラリの読み込み
library(tidyverse)

# データの読み込み
setwd("~/2019-nCov/covid19/test")
getwd()
df <- read.csv("pcr_pref_data_daily_lerp_kenmonezumi.csv")
head(prefts, n = 3)

# 縦横変換、X削除
prefdf <- gather(df, key = date, value = testing, -pref)
prefdf <- dplyr::mutate_all(prefdf, ~gsub(.,pattern="X",replacement = ""))

write.csv(prefdf, "./tidy_pcr_pref_daily_lerp.csv",row.names=FALSE)
