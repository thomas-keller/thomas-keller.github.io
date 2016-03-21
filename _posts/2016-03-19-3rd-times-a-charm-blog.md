---
layout: article
title: 3rd times a blog - and hyphens are a sin
comments: true
image:
    teaser: back-25.jpg
---

Well, as I mentioned yesterday I started diving into git and am already on the third version of a website, after going through pelican (after @wrightingapril), minimal mistakes (after @svscarpino), and now I'm at this dude's blog [Will Koehler](http://willkoehler.net/) . I did have a brief go with the most recent version of minimal mistakes, skinny bones, but that was giving me really janky jekyll build messages so vague that I didn't want to figure out how to debug it. 

Given that I

    1. Don't know anything about ruby, though I guess that's nothing new for a lot of people with this whole ruby on rails thing I'm finally part of.
    2. I made the critical mistake of trying to adding too many things at once, so it couldn't even fail gracefully enough to tell me where the problem was.
    
I will probably stick with this template at this point just to move forward with *something* and then start getting into April's workshop from last month.

Well, as I say this, the stupid thing just continues to fail because it relies on a weird plugin that of course is banned from github. Going back to the skinny bones is probably in the end the smartest thing because it doesn't have any plugin shit that's causing any problems. Anyway, I've now learned enough that the plugin problem is the cause of why I have to do this pre-compiled rake stuff.