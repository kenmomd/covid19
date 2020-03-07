# ライブラリの読み込み
library(tidyverse)
library(ggsci)
# データの読み込み

setwd("~/2019-nCov/covid19/test")
prefdf <- read.csv("tidy_pcr_pref_daily_lerp.csv")
head(prefdf, n = 3)


g <- ggplot(prefdf, aes(x = date, y = testing, color = pref))
g <- g + geom_line()
#g <- g + scale_color_jama()
plot(g)


p <- ggplot(data = prefdf, mapping = aes(x = date, y = testing)) +
  geom_line() + facet_wrap(~ pref, ncol=6)
plot(p)