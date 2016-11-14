---
layout: article
title: A personal hedonometric analysis of my tweets, a perspective on self-care and looking forward
excerpt: tidytext 4 life, ggplot, self-care!
comments: true
categories: articles
tags: twitter, R, tidytext, ggplot, introspection, self-care
image:
    teaser: back-42.jpg
---

## Incorporation of Hedonometer lexicon to Tidytext

The paper by [Dodds et al. in 2011](http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0026752) introduced the concept of the Hedonemeter, which measures one specific gradient of emotion, happiness - on twitter. 

They mentioned that the day of the election was the third saddest day on twitter (the others being the Pulse and Dallas shootings).

I wanted to be a cool kid like [Keith Turner](http://twitter.com/kay_aych) and his analysis of ISME2016, which included lots of tweet embeds, but I think that only works if the document is a shiny app?

As a small project of introspection and self-care, I wanted to see how the sentiment in my Twitter time-line has changed in and around the election using this metric. 

At first I thought I would be limited to the last 3200 tweets (the API limit for user timelines), but reading Silge and Robinson's book (see the next section), you can get your full twitter archive by going to [your twitter setting](https://twitter.com/settings/account) and clicking on archive and waiting for the email.

# Twitter Usage (Frequency)

The first few graphs I want to show are some simple ones I have (or haven't) used Twitter over the years

```R 
library(twitteR)
library(tidytext)
library(ggplot2)
library(wordcloud)
library(dplyr)
library(stringr)
library(tm)
library(readr)
library(lubridate)
library(cowplot)

load('twitter-secrets.Rdata')
setup_twitter_oauth(cons_key,cons_sec, acc_tok, acc_sec)

# will leave in for posterity - can use to get other user timelines - 
#mytweets=userTimeline('tek_keller',n=3200,includeRts=T)
#tw_df<-twListToDF(mytweets)
#write.csv(tw_df,file='tek_timeline11-12-16.csv',row.names=F)
tw_df=read_csv('tek_tweets_all6k.csv')

confname='TEK'

tw_df$timestamp=with_tz(ymd_hms(tw_df$timestamp),"EST")

ggplot(tw_df, aes(x = timestamp)) + geom_histogram(position = "identity")
ggsave(file='tek_hist_alltweets.png',width=7,height=7,dpi=100)

tw_df2=filter(tw_df,timestamp>= "2016-01-01" & timestamp <= "2016-12-31")

ggplot(tw_df2, aes(x = timestamp)) + geom_histogram(position = "identity")
ggsave(file='tek_hist_just2016.png',width=7,height=7,dpi=100)

```


![image](http://thomas-keller.github.io/images/tek_hist_alltweets.png)

The histogram of tweets through time is pretty hilarious, but also reflective of about how I have used social media in recent years (I haven't, generally; my Facebook is similarly spartan). However, when I finished up my last postdoc in December of last year I realized I needed some way of staying connected to people and science in the larger world while I was figuring out what to do next and I wasn't physically connected to a university. Hence you can see me dusting off ye olde Twitter account in the spring of 2016.

In fact, I made a total of 15 tweets in the prior 4 years so it's simpler to just cut that time out and focus on my more recent "shit-posting", I mean science-posting!

![image](http://thomas-keller.github.io/images/tek_hist_just2016.png)

The summer months were heavily elevated (conferences and my attempts at #scicomm), but otherwise I seem to have a somewhat regular state of tweeting.


# Regex Monstrosties and unnesting tokens

The beginning of this code comes from Julia and Dave's wonderful new book [TidyText Mining with R](http://tidytextmining.com). Specifically, the section on [Twitter](http://tidytextmining.com). Twitter has certain weird characteristics that make the default unnesting unpalatable-namely stripping the # and @ from words, which are quite important features for downstream analyses! Therefore, we have go to some horrific regex lengths to work around these default assumptions in the unnesting framework.

Part of my TODO is to figure out how this REGEX (either the first or second part) is working.

```R

library(tidytext)
library(stringr)

reg <- "([^A-Za-z_\\d#@']|'(?![A-Za-z_\\d#@]))"
tidy_tweets <- tw_df2 %>% 
  mutate(text = str_replace_all(text, "https://t.co/[A-Za-z\\d]+|https://[A-Za-z\\d]+|http://[A-Za-z\\d]+|&amp;|&lt;|&gt;|RT", "")) %>%
  unnest_tokens(word, text, token = "regex", pattern = reg) %>%
  filter(!word %in% stop_words$word,
         str_detect(word, "[a-z]"))

tidy_tweets2 = tidy_tweets %>% filter(!str_detect(word, "@"))

frequency <- tidy_tweets2 %>%
  count(word, sort = TRUE) %>% 
  mutate(total = n(), freq=n/total)

filename='tek_twitter_words.png'
png(filename, width=12, height=8, units="in", res=300)  
wordcloud(frequency$word,frequency$n,max.words = 100,colors=brewer.pal(8,'Dark2'))
dev.off()
frequency

```

