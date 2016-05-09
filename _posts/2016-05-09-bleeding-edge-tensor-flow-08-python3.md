---
layout: article
title: Bleeding edge tensorflow 0.8 docker image python3 w/ pandas & fluff
comments: true
tags: python, docker, tensorflow, sideprojects
image:
    teaser: back-30.jpg
    
---

## Mountains out of what may be molehills

I wrote the other day that we as people in the scientific community should start moving over to python3 when we can, especially since we probably aren't beleaguered by legacy code like "real" programmers. However, I was immediately struck with a problem when I wanted to start playing around with Tensorflow, which only comes with a python2.7 solution for docker if want to use your gpu, which I have one so why not.

### Tensorflow: the new bees knees for deep learning (ie neural networks) 

First off, I have to say that deep learning is a pretty dumb name and just sounds like lame marketing, but hey, whatevs. I'm just getting into this field, so maybe they reveal to me how no, really deep learning is completely different from neural networks. Either way, Tensorflow has been the guts of a lot of Googles recommender systems (image specifically), and they recently open-sourced it. Its got a lot of the mind-share right now cause Google, and I hopped on cause it's in python and the syntax is friendly enough and it's moving FAST! 

It actually reminds me in a way of the SAGE math project, something I stumbled upon by accident early in graduate school when I was learning to program. That's actually where the the Jupyter notebook comes from (they wanted a free mathetica, it had all sorts of crazy math, rings and such). That's also where Cython comes from, in part. 

## Building my first docker image

Using Tensorflow with an Nvidia graphics card gpu on linux is...tricky. Using graphics cards has gotten much easier on linux in recent years, but it's still a delicate dance. In 16.04, thankfully if you just let the proprietary drivers go to work that's the way to go. Then:

```
apt-get install nvidia-361 nvidia-cuda-toolkit
```

Follow the one weird tip under **CUDA INSTALL** at [this guy's blog](https://www.pugetsystems.com/labs/articles/NVIDIA-CUDA-with-Ubuntu-16-04-beta-on-a-laptop-if-you-just-cannot-wait-775/) and that should get you a working symlink, everything complained before I had this in place, even though I had the toolkit installed.

Anyway, I wanted to try to use python3 as much as possible so I set about trying to get this set to python3. There were some other docker iamages floating around already with python3 and tensorflow, so I just scavanged off those as much as I could ([thanks grahama!])(http://neuralniche.com/post/tensorflow/). That image dumps you straight to a root terminal, which is I guess better suited for maybe amazon instances. I'm strictly just messing around on my laptop so this is all Ivery interactive based. 

There were a few needless hours of staring dumblessly at the computer, because I still don't really get how containers work very well, much less building them. And trying to convert one hacked together dockerfile and then my own...well, I eventually figured out what I needed to do! And fortunately it's quite easy to add more packages if you happen to want more for yourself. Just search for pip3 area where I've written ADD HERE, and uh... add there :).
    
Right now it's just got the main data science stalwarts, pandas, matplotlib, seaborn, and bokeh, plus statsmodels and scikit-learn. I haven't actually verified bokeh works in it because I've never touched bokeh before, but I'm reasonably certain it works. 
    
### Back to all my more important projects

This was important in some regards in that pretty much every job I'm really interested in right now are focused on machine-learning to at least some extent so I need to add that to my bag o' tricks. But, more importantly the giant twitter analysis from the fall has been 95% done for ages and I need to stop shuffling my feet and finish and add that to my portfolio. Balance in all things and all that.

TEK
