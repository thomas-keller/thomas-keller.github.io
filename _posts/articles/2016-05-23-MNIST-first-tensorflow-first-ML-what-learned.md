---
layout: article
title: Completing the tensorflow beginner's MNIST tutorial is 23 lines of code, but what did I learn? 
comments: true
categories: articles
tags: python, tensorflow
image:
    teaser: back-28.jpg
    
---

# The hello-world of tensorflow and machine-learning is still kinda hard-core

It took another week, but I finally got around to implimenting the first round of the tensorflow tutorial of [MNIST training](https://github.com/thomas-keller/tensorflow-nb-scripts/blob/master/MNiST-tf-trainer.ipynb). And by impliment I mean copy and paste the code sprinkled throughout the tensorflow [tutorial webpage](https://www.tensorflow.org/versions/r0.8/tutorials/mnist/beginners/index.html). I appreciate that these problems are complicated enough that it probably is best to have hello world come with a fully working code base that explains each section, and it remains fairly concise at 23 lines.

# Still, copy and pasting isn't quite enough

I'm struck by not being satisfied by having copy and pasted the code, where I feel like I'm cheating, but I also don't really know enough yet to NOT copy and paste code yet. This is ESPECIALLY true in the tensorflow framework. I have seen rather more of scikit-learn code thus far. 

I'm looking forward to doing a few more of these, where by then hopefully the framework will have gotten through my thick skull and I can start messing around with the toolset or at least skflow to actually build some of my own models, instead of just repeating known results.

# My dumb docker file does indeed work fine and runs tensorflow models

I was reasonably certain this was going to be the case when I could actually import tensorflow last time, but successfully running a model (I have no idea whether it's fast or slow) did feel really good. I should just get a regular docker and compare cpu to gpu speeds. 
