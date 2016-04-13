---
layout: article
title: dirdf is way better than crafting some ghastly regex to get your artisinal, bespoke tweet filenames
comments: true
tags: data, Rstats, mongodb, twitter, bespoke
image:
    teaser: back-11.jpg
---

## How does one easily date-restrict file ranges in R (I know how in Python)?
This is something of a short precurser post to a series of longer analyses where I will be digging in to a bunch of tweets that I archived from the twitter public API in the fall on a couple different topics. These were sitting around unused for months but I finally have time to mess around with them, which is exciting. However, the total size of the collected tweets is ~400gb, which is more than I want to mess with right now for computing and other reasons. 

So, how do I restrict the date ranges? I'll explain the project more at length in later posts, but it uses a really nice R package called [smappR](https://github.com/SMAPPNYU/smappR/) by Pablo Barbera who is/will be an Assistant Professor at the University of Southern California. smappR actually wraps one of his other packages, twitteR, that polls the twitter waterhose. I had it dump out all the recorded tweets to a json file once an hour with the date and time, down to the hour and minute in the filename.

As I said, this operation is pretty clean in python. Say I only wanted tweets from the actual day of the September republican primary (the 16th). Then I just


```python
    import glob
    #sample full filename republican_primary_2015_09_14_15_22.json
    fnames=glob.glob('repub*.json')
    for f in fnames:
        fs=f.split('_')
        if fs[4]=='16':
            #do stuff
```

This probably just reflects my tendency to just restrict the use of R to the endpoint of analysis where I'm not even messing around with files, but in this case it's necessary because I need to use R to read the json files into a mongodb server that's running in the background (also pretty sweet, I had never used a database before...csv 4 life...I guess feather 4 life?).

In R the steps would be somewhat similar normally. What I figured out, and actually ended up having to do on the cluster, was do a list.files and then doing because I was dumb and just realized now would have been a better way, would have been to do

```R
    #I was actually insane and had counted out which files in the vector corresponded to the hours I wanted
    files<-list.files(pattern='republican_primary_2015_09_.*json')[30:85]
```

A better way I guess would have would have been to use strsplit, but I always feel slightly betrayed by R's behavior by returning a list; it just feels alien to me. Also, sometimes i'll forget that it's a regex and doesn't like periods whereas split in python is cool with it (because it's not using a regex underneath). I really shouldn't, as its one of the examples in the stinking docs for strsplit, but here we are.

Anyway, Dr. Jenny Bryan, who I recently discovered on Twitter (humane describer of R stats, follor her!), linked me to a recent cool project called [dirdf](https://github.com/ropenscilabs/dirdf). From what I could discern it seems like this mostly came together during the most recent #rstatsnyc unconf, so the docs are sparse, etc. But it works in my limited use of it. I will never understand how people can achieve these Herculean feats, but kudos to these peoples : [Henrik Bengtsson](https://twitter.com/henrikbengtsson), [Joe Cheng](https://twitter.com/jcheng),[Sean Kross](https://twitter.com/seankross). There were probably others, maybe Dr. Bryan herself? Again, I don't really know the details.

The idea is basically to read in a directory of files with some kind of naming structure (exact or fuzzy) and turns the files into a data frame for you or me to round around with.

 It is pretty bleeding edge, as I couldn't get it to build under less than 3.2 and thus not on the cluster I use, since for some reason I can't install devtools on 3.2.4, which is really dumb and frustrating (openssl linkage issues).

If you CAN install devtools and have R >= 3.2, it's pretty easy to install.
```R
devtools::install_github('ropenscilabs/dirdf')
```

```R
    library(dirdf)
    dirdf('')
```
### Horrible record scratch

I just realized that I put underscores in the dates instead of dashes. Looking back at my filenames, it actually would have been really annoying to parse. However, dirdf is a Cool and Neat Thing and I will use it more in the future. Had I named things properly I could just do something like

```R
    dirdf("./", template="date_experiment.ext")
```

