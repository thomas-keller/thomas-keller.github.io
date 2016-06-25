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

As the head outlines, there are two main ways to collect tweets. The streaming API any broadcast tweets that contain a word in the filter list. This makes it easy it filter for events with unique hashtags, as in my case for Evolution 16 which used #evol16. The [previous post](http://thomas-keller.github.io/articles/using-streamr-tidytext-to-conferences-with-twitter/) lays out how to set up a stream pretty pretty I feel. However, having got back from Evolution, I now realize that was only about 15 thousand tweets and maybe not actually needing the streaming infrastructure. Streaming insures you won't lose tweets, but doing a search after the conference might be easier some times.

