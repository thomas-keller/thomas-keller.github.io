---
layout: article
title: Live-tweeting Evolution 2016 was pretty cool. Here are some figures and advice on how to do the same for your own upcoming conference.
excerpt: 
comments: true
categories: articles
tags: twitteR, waterhose, streaming, evol2016, R, streamR, tidytext
image:
    teaser: back-17.jpg
---

# Summary

I just got back from the Evolution 2016 meeting in Austin, Texas; it was amazing. I'm of course biased because I did my Phd there and basically everyone who graduated in the last 10 years tried to find a reason to be here for this meeting so it was basically a grand reunion party. The science was also fantastic, so now I'm now vacilating about doing yet another postdoc in evolutionary biology or continuing my attempts at getting a data science job in industry without any biology. However, what I'll be talking about is how to do some simple analysis of tweets, collected either via streaming API or just after a conference via their search API.

# Getting tweets, streaming (setup beforehand, all relevant tweets) or search (last 7 days, not exhaustive) 

As the head outlines, there are two main ways to collect tweets. The streaming API any broadcast tweets that contain a word in the filter list. This makes it easy it filter for events with unique hashtags, as in my case for Evolution 16 which used #evol16. The [previous post](http://thomas-keller.github.io/articles/using-streamr-tidytext-to-conferences-with-twitter/) lays out how to set up a stream pretty pretty I feel. However, having got back from Evolution, I now realize that was only about 15 thousand tweets and maybe not actually needing the streaming infrastructure. Streaming insures you won't lose tweets, but doing a search after the conference might be easier some times. See [this website](http://www.r-bloggers.com/playing-with-twitter-data/) for details, it's pretty good.

# Making those sweet figures

Insert exposition

```R
library(tidytext)
library(ggplot2)
library(tm)
library(wordcloud)
library(streamR)
library(dplyr)
library(smappR)

setwd('~/tweet-pol')
df<-parseTweets('merged_evol2016.json')
#from http://www.r-bloggers.com/playing-with-twitter-data/
#because I am no good at constructing regexes
#removes http links
df$text<-gsub(' http[^[:blank:]]+', '', df$text)

tidy_tw<-df %>% unnest_tokens (word,text)
#some of these stop words are unneccessary now that I got a regex working that doesn't core dump
tw_stop<-data.frame(word=c('amp','gt','t.c', 'evol2016','rt','https','t.co','___','1','2','3','4','5','6','7','8','9',"i\'m",'15','30','45','00','10'),lexicon='whatevs')
data("stop_words")

#removes uninformatives words / ones that oversaturate wordcloud (conference hashtag)
tidy_tw <- tidy_tw %>%
  anti_join(tw_stop)
tidy_tw <- tidy_tw %>%
  anti_join(stop_words)

print(tidy_tw %>% count(word, sort = TRUE)) 

fig<-tidy_tw %>%
  count(word) %>%
  with(wordcloud(word, n,remove=c("evol2016"),max.words = 100,colors=brewer.pal(8,'Dark2')))

png('evol2016_wordcloud_day3_real.png',width=12,height=8,units='in',res=300)
fig<-tidy_tw %>%
  count(word) %>%
  with(wordcloud(word, n, remove=c("i'm"),max.words = 100,colors=brewer.pal(8,'Dark2')))
dev.off()

gah<-tidy_tw %>% count(word)
gah2<-as.data.frame(gah[order(gah$n,decreasing=T),])
print(head(gah2,30))

print(nrow(df))
hm<-sort(table(df$screen_name),reversed=T)
outdf<-data.frame(screen_name=names(hm),num_tweets=hm)[,c(1,3)]
outdf<-outdf[order(outdf[,2],decreasing=T),]
write.csv(outdf,file='evol2016_tweetrank.csv',quote=F)http://www.r-bloggers.com/playing-with-twitter-data/
print(head(outdf))

tidy_tw$created_at<-formatTwDate(tidy_tw$created_at)
df$created_at<-formatTwDate(df$created_at)

library(tidyr)
bing <- sentiments %>%
  filter(lexicon == "bing") %>%
  select(-score)

evol2016sentiment <- tidy_tw %>%
  inner_join(bing) %>%
  count(id_str, sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative) %>%
  inner_join(df[,c(6,10)])

library(cowplot)
library(scales)
library(lubridate)
df_labels<-data.frame(times=strptime(c("2016-06-15 18:00:00","2016-06-17 12:00:00","2016-06-18 7:30:00","2016-06-19 18:30:00","2016-06-21 0:00:00","2016-06-21 18:00:00","2016-06-23 0:00:00"),"%Y-%m-%d %H:%M:%S"),
                      labels=c("anticipation","pre-conf\nworkshops",'conference\ntalks begin','film festival\nsocializing','oh god\nmore talks',"super social!",'bitter\nreality\nintrudes'),
                      y=c(-.1,.7,-.1,.85,0,.55,1.05))
p<-ggplot(evol2016sentiment, aes(created_at, sentiment)) +
  geom_smooth() + xlab("tweet time") + ylab("tweet sentiment")+
  scale_x_datetime(breaks = date_breaks("day")) + background_grid(major = "xy", minor = "none") +
  theme(axis.text.x=element_text(angle=315,vjust=.6)) +
  coord_cartesian(ylim=c(-.5,1.2))+geom_text(data=df_labels,aes(x=times,y=y,label=labels),size=4)
print(p)

save_plot("evol2016_sentiment_time.png",p)

p2<-qplot(outdf$num_tweets.Freq)+scale_x_log10()+xlab("number #evol2016 tweets")+ylab("number of tweeters")
print(p2)
save_plot("evol2016_numtweets_user.png",p2)
```

The end
yep that's it

