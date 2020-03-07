# ライブラリの読み込み
library(tidyverse)

# データの読み込み
setwd("~/2019-nCov/covid19/test")
getwd()
df <- read.csv("pcr_pref_data_daily_lerp_kenmonezumi.csv")
head(df, n = 3)

# 縦横変換、X削除、列並び変え
prefdf <- gather(df, key = date, value = testing, -pref)
prefdf <- dplyr::mutate_all(prefdf, ~gsub(.,pattern="X",replacement = ""))
prefdf <- prefdf[,c(2,1,3)]

# 数字ではas.Dateできないので文字列型に変換
prefdf$date <- as.character(prefdf$date) 
# 日付の型に変換
prefdf$date <- as.Date(prefdf$date, "%Y%m%d")
# 数値型（整数）、因子型に変換
prefdf$testing <- as.integer(prefdf$testing)
prefdf$pref <- as.factor(prefdf$pref)

# データフレームの確認
head(prefdf, n = 3)
sapply(prefdf, class)

# csvに保存
write.csv(prefdf, "./tidy_pcr_pref_daily_lerp.csv",row.names=FALSE)


