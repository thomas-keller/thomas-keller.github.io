---
layout: article
title: Glory to Keras, tensorflow autoencoders , the first Kaggle submission, and getting over forking/using using code (nearly) verbatim
comments: true
categories: articles
tags: reinventing wheels, tensorflow, keras, kaggle
image:
    teaser: back-10.jpg
---

# Summary

Now is a really good time to start exploring deep learning models with real data, especially if you want to do it with images instead of just the MNIST dataset over and over again! Check out this [deep-learning solution](https://github.com/jocicmarko/ultrasound-nerve-segmentation) to the most recent Kaggle competition -- [Ultrasound Nerve Segmentation](https://www.kaggle.com/c/ultrasound-nerve-segmentation) by cool guy [Marko Jocic](https://twitter.com/_jocicmarko). If you have a more recent Nvidia graphics card (compute >=3.0, to be specific) and are on Linux, you can try this [docker build](https://hub.docker.com/r/thomasekeller/tensorflow-py3-frills/) with all the required dependencies.

****

I've spent the last week or two digging more into tensorflow and how to actually, you know, do THINGS with it. As I described last time, I had managed to get the initial MNIST tutorial working by copying the code verbatim. The second tutorial is actually a bit of a doozy. The code as listed doesn't work with my lowly NVIDIA 755 with only 2GB of video RAM, which is at this point I guess pretty pathetic. After some googling around I found that some other example code they had actually used minibatches to deal with memory issues, but they wanted to kept the code as simple as possible so I guess hoped that the code wouldn't die for people.

It all seems like kind of a bad trade-off, but mostly because I realized that I had learned just enough of the inner workings of tensorflow (ha) to realize that I wanted something more high level to get going faster. I was running into a wall just trying to doing a fricking hello-world example. I'm not going to expend time arguing they should make things easier for my dumb brain, but I was glad to go really give some time and thought to [Keras](http://keras.io), which is a library front-end abstraction for deep-learning with Theano and Tensorflow as backends. When I was first getting my Docker image to work based off [Grahama's very nice cuda docker images](https://gitlab.com/besiktas/dockerbuilds/blob/master/cuda/tensorflow/Dockerfile), I noticed that he had Keras but didn't really know what it was, then decided that I didn't want some frontend if I didn't even understand what was going on in the backend. 

Anyway, I've learned a little more that I don't mind letting some (most) (all) of that busywork being taken care of, especially the net size and stuff. It is incredibly concise in Keras! Fortunately, it's also really easy to get back to the backend gory bits when you need to, which you will, a lot. That might be one of the next things I try to write up, is something where I actually do my own neural network model from Keras-style scratch and walk through what that means. It is quite impressive how much time it saves.
 
So, on to the meat of what I wanted to talk about, cool guy [Marko Jocic](https://twitter.com/_jocicmarko) made and opensourced a [deep-learning solution](https://github.com/jocicmarko/ultrasound-nerve-segmentation) to the most recent Kaggle competition -- [Ultrasound Nerve Segmentation](https://www.kaggle.com/c/ultrasound-nerve-segmentation). I was in the process of updating my docker cuda thing to includa openCV -- all 6GB of it, I suppose a consequence of CUDA stuff? (!) -- but after looking at Marko's code I added in Keras as well and got that working, which wasn't actually very hard. What's nice about the code is that it is pretty clearly intended to serve as a tutorial/jumping off point for others, and thus is well organized and makes a fair amount of sense even if you're not that familiar with Keras syntax yet (I'm not).

Anyway, if you have been thinking about testing the waters of deep-learning, his codebase is a pretty great place to start poking around, and makes a ~fair~ amount of sense, especially if you watch the U-net video that is linked somewhere for the academic paper that the NN structure is based off. I have no idea if the Theano backend if faster or using other compiles might be faster (probably) , but I'll just do a small plug and say that the updated version of my [tensorflow cuda docker whatever](https://hub.docker.com/r/thomasekeller/tensorflow-py3-frills/) ran this in I think 4-5 hours on a 755M which only has 2GB of video ram. So, odds are if you have a 3.0 compute gpu (required for tensorflow at least, dunno about theano) this will run reasonably fast, at least faster than mine.

I still have yet to really modify the base program at all, and I feel kind of crappy about not starting from scratch. And yet, there is something nice about starting with a functional thing, and being able to modify the bits that interest you. For example, there are all sorts of obvious bits that are ripe for being improved, like smarter pre-processing as well as the actual NN itself.

