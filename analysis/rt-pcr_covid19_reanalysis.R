#PCR検査の偽陰性率は？下記論文の検証
#Kucirka, Lauren M et al. “Variation in False-Negative Rate of Reverse Transcriptase Polymerase Chain Reaction-Based SARS-CoV-2 Tests by Time Since Exposure.”
#Annals of internal medicine, M20-1495. 13 May. 2020, doi:10.7326/M20-1495

#データセット及び解析に使用されたコードはgithubで公開されている。
#https://github.com/HopkinsIDD/covidRTPCR

library(tidyverse)
library(scales)
library(ggsci)
library(ggrepel)

#csvファイルの読み込み
URL = "https://raw.githubusercontent.com/HopkinsIDD/covidRTPCR/master/data/antibody-test-data.csv"
df_pcr <- read_csv(URL)

#解析に使用する各研究のPCR検査感度をプロットする。
#y=(test_pos+nqp)/(n+nqp)なのは、論文著者らの方法に従った。 
#add non-quantified positives to other positives for Danis et al.だとか

p <- df_pcr %>% dplyr::filter(grepl("RT_PCR", test),study != "Danis_no_4") %>%
  ggplot(aes(x=day, y=(test_pos+nqp)/(n+nqp), color=study, label=n))+
  geom_point(size=2)+
  geom_line(linetype=1, size=1)+
  geom_text_repel(size = 5,show.legend = FALSE)+
  facet_grid(study~test)+
  scale_color_d3()+
  scale_x_continuous(breaks=seq(-5,30,5))+
  scale_y_continuous(labels=percent)+
  theme_bw(base_size = 13, base_family = "HiraginoSans-W4")+
  labs(x="Days since symptom onset", y="Raw sensitivity of the PCR test", caption = "Kucirka, Lauren M et al. “Variation in False-Negative Rate of Reverse Transcriptase Polymerase Chain Reaction-Based SARS-CoV-2 Tests by Time Since Exposure.”\nAnnals of internal medicine, M20-1495. 13 May. 2020, doi:10.7326/M20-1495\nhttps://github.com/HopkinsIDD/covidRTPCR")+
  ggtitle("各研究におけるPCR検査の感度（naso=鼻咽頭スワブ, oro=咽頭スワブ）", subtitle = "数字はその時点のサンプルサイズ")

ggsave(filename = "./img/RT-PCR_Sens_.png", plot=p, width=15, height=15, dpi = 180)