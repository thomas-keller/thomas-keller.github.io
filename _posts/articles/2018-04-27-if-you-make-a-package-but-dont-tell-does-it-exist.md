---
layout: article
title: If you make a package but don't tell anyone about it, does it really exist?
excerpt: I somewhat recently went through the excercise of writing a simple R package based around the steamspy API.
comments: true
categories: articles
tags: philosphy, steamspy, one hand clapping, development, writing
image:
    teaser: float-7.jpg
---

## If you make a tool/package but don't tell anyone about it, that knowledge is locked away in your mind

I somewhat recently went through the excercise of writing a simple R package based around the [steamspy](https://steamspy.com/) API. If interested, the [R code lies here](https://github.com/thomas-keller/steamspyR). I chose this API because it was simple, short, and explicit; I had also never actually gone through the steps of gussying up my code into a proper package before, so this was a nice excercise for that was well.

*However*, I made the critical error of not finishing it up right away and pushing it out the door, warts and all. It then sat on my hard drive, forgotten and unwritten about, until the underlying API was dealt a more or less killer blow that made this silly package functionally useless for the moment.

This tweet from Amelia McNamara, of a slide from David Robinson, is something I am increasingly taking to heart.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">&quot;Things that are still on your computer are approximately useless.&quot; -<a href="https://twitter.com/drob?ref_src=twsrc%5Etfw">@drob</a> <a href="https://twitter.com/hashtag/eUSR?src=hash&amp;ref_src=twsrc%5Etfw">#eUSR</a> <a href="https://twitter.com/hashtag/eUSR2017?src=hash&amp;ref_src=twsrc%5Etfw">#eUSR2017</a> <a href="https://t.co/nS3IBiRHBn">pic.twitter.com/nS3IBiRHBn</a></p>&mdash; Amelia McNamara (@AmeliaMN) <a href="https://twitter.com/AmeliaMN/status/926509282874585089?ref_src=twsrc%5Etfw">November 3, 2017</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>




# usethis is prettygood

As stated, making a package was new territory to me. Thankfully, the combination of typing "how to make an R package" and pulling up [Hilary Parker's still excellent post](https://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/) from 2014, as well as the usethis package were enough to keep me from serious harm.

Seriously, the following few functions save a lot of legwork, especially if you a serial package creator, like [Mike Kearney](https://github.com/mkearney?tab=repositories)

```R

library(usethis)

create_package("~/pkg_ex")

use_package("dplyr", "Suggests")

use_roxygen_md()
use_readme_md()
```

Really, the only thing I found a bit annoying was the roxygen annotation. Adding the descriptions themselves was fine, I was just thrown initially by the fact that all functions are by default private unless you declare them with @export in the roxygen documentation. Of course, I think that is more a function of me not being use to the syntactic sugar that roxyen asks of you.

# There has to be a warning coming from this story, right?

So, if you don't play videogames, or maybe even if you do, these recent events may have passed under the radar. On the April 4, 2018, Valve changed [user accounts to make most details by default](https://arstechnica.com/gaming/2018/04/steam-spy-announces-its-shutting-down-blames-valves-new-privacy-settings/). This had the immediate effect of essentially killing Steamspy, which relied on that information being public to tally its game numbers.

While I had only spent a day or fiddling with the code to get the package set up, the ultimate plan in my mind was always to write some sort of blog post to show it off, but more to point to usethis. However, as things inevitably do, other things cropped up and this project was placed on the ultimate back-burner and ultimately forgotten about. Then, after the change to Steam's service that basically killed of the functionality of the package I lost even more motivation to write about it.

# Nurturing that writing feeling

I go through fits and starts of being struck by a writing mood. Since I'm back in an academic adjacent position again (yay), that's not exactly a great thing, since there's always a call to write a some point; writing only sporadically is not an academically survivable trait, I'm afraid. Part of what attracted me to started to blog was that it was a lower pressure environment style of writing compared to say, an academic paper. Of course, I'm pretty sure [ye olde advisor Claus Wilke](http://serialmentor.com/virtualbooks/) would say to just get over myself and start writing and forget about the style, "you can clean it up later." There is a reason for 2nd, 3rd, nth drafts. 

Along those lines, someone I follow, [Safia Abdalla](https://twitter.com/captainsafia) on twitter has been quite a prolific writer over the past few months, and [recently wrote about her process](https://blog.safia.rocks/post/172763173965/answering-how-do-i-write). I highly recommend it.

She mentions lots of good things, but I'll spoil what I think is really the key, by quoting a key line; "I think one of the hardest things to establish when writing is consistency and discipline" (her words).

The [post by David Robinson](http://varianceexplained.org/r/start-blog/) where that tweet came from is pretty good about motivations for writing a blog and how to push yourself.

# Push that project out of the nest

In the software development and biz-dev world it's hip to talk about the "minimum viable product" and I think for scientists it's definitely useful to graduate to more of a "f-it, we'll do it live" mind-set for getting some projects off the ground, especially if your inherent tendency is to fiddle with things in pursuit of some far off and likely unattainable bar of perfection.

Setting a lower bar that's "well, at least this part works, and I want to do x, y, and z" gets it out the door and gives you some momentum. 

**Update 05-01** And yet, even this post was 95% written on 04-27, and then I STILL sat on it for a few more days so I could update the R package (why???)

Well, I guess I can at least show off the proof of concept that you can grab data from it and do some plotting fairly easily.

```R

library(steamspyR)
library(forcats)
df=genre_games("Action")

df$owners=readr::parse_factor(df$owners,rev(unique(df$owners)))

library(ggplot)

library(cowplot)
ggplot(aes(price,median_2weeks),data=df)+facet_wrap(~owners)+geom_point()

``` 

<img src="https://thomas-keller.github.io/images/steamspy_ex.png" width="1024">

# The end (?)

In a bizarre twist of fate, on the day I decided to finally write this up, April 27, 2018, the creator of Steam Spy (Sergey Galyonkin) [announced in a blog post](https://galyonk.in/whats-going-on-with-steam-spy-deed5d699233) it might not actually be dead, by using fancy machine-learning methods estimating sales data from other sources. Parts of the API are coming back, but it's apparently incomplete right now. 

So, in the end this package's functionality has not totally died. Yay~







