# ライブラリの読み込み
library(tidyverse)

# データの読み込み
setwd("~/2019-nCov/covid19/test")
prefdf <- read.csv("tidy_pcr_pref_daily_lerp.csv")
# 一旦文字列型に変換
prefdf$date <- as.character(prefdf$date) 
# 日付の型に変換
prefdf$date <- as.Date(prefdf$date, "%Y-%m-%d")
head(prefdf, n = 3)
sapply(prefdf, class)

g <- ggplot(prefdf, aes(x = date, y = testing, color = pref))
g <- g + geom_line()
#g <- g + scale_color_jama()
plot(g)

# 県別 プロット
p <- ggplot(data = prefdf, mapping = aes(x = date, y = testing)) +
  geom_line() + facet_wrap(~ pref, ncol=5) + theme_minimal()
plot(p)

