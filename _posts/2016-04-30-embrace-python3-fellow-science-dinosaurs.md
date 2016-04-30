---
layout: Article
title: Embrace python3 ye fellow scientific dinosaurs, the gilded age of 2.7 is finally past (It's the default in **Ubuntu 16.04 LTS**)
tags: python, data science, bike sheds
comments: true
image:
    teaser: back-37.jpg
    
---

## The "is the python3 hump over?" question has sort of been answered

I've been using python for a long time in my scientific career, and I imagine for a lot of other scientists it's a tossup between python and R (or they use both, like me). I taught myself python in my second year, after a series of particularly discouraging lab experiments. Jim Bull, my original advisor had strongly encouraged me to be co-advised by Claus Wilke, which turned out to be great advice because he's great at pretty much everything, just like Jim, but is excusively computational. Anyway, python was much easier for me to pick up than my later foray into R, which was like running straight into a brick wall for several years. I hated it for a time, and the community is frankly much less nice to newbies than python (seeing professors write replies to people who can't figure out the arcane regression structure or something similar and just reply with a single line "?lm" as if the help docs are helpful to a newcomer compared to a seasoned statistician who knows what they are doing infuriates me to this day). But I digress...

Anyway, it was around this time that python3 got released (5-6 years ago). Adoption has been glacial, as Guido van Rossum the Godfather of python said he didn't want to force people and split the community. The changes aren't *huge*, but it *will* break your code, even if you use the python2to3 translater included with python3. 

So who cares? For the first couple years, many of the really big, important numerical/scientific packages and other python packages didn't have python3 equivalants, so there was a real reason not to upgrade. However, if you look at Anaconda python3  2.7 stack now, you'll see about 90-95% of packages are in both or have equivilant functionality (some packages got split for *reasons*).

I'm actually interested to hear of any large, commonly used packages that **don't** have a python3 version (most I've seen have a 2.7 and a 3.3+). In the data science realm where I'm hanging right now, things like nltk, scikit-learn, tensor-flow, pandas, numpy, scipy all have versions for 3.

# Please start telling new students to learn python3, not 2.7

I'm not really one for prognosicating or lecturing, but I do think it's time for peeps in the scientific community to start moving off from the security blanket of 2.7. I understand, really I do. We all like things that just work, and probably don't *really* want to be out on the bleeding edge. However, I think at this point advising newcomers to start with 2.7 vs 3.0 is verging on bad advise.

