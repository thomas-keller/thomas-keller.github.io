---
layout: article
title: Using R, ggplot2, and cowplot to datamine and determine things you already knew about your photography habits
comments: true
categories: articles
tags: data science, photography, dataviz, ggplot, cowplot
image:
    teaser: back-15.jpg
---

Aside: if you're here you probably already know about the book, but Nicholas Felton's new book [Photoviz](http://www.amazon.com/gp/product/3899556453/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=3899556453&linkCode=as2&tag=feltroncom-20&linkId=LBM6JFKJD56LWEA5) looks wicked cool.

## Photography background (garbage if you just want the R i guess??)

I got a decently fancy digital [SLR](https://en.wikipedia.org/wiki/Single-lens_reflex_camera) from Pentax (K-5) in grad school that I more or less immediately mothballed as I went into crunch-mode trying to get shit together to try to graduate in some sort of reasonable fashion. Pentax made a legendary intro-level SLR back in the film days, the K-1000, that I inherited from my dad. Since then I have de facto been a fan. They are, however way behind in popularity compared to the big dogs in the photography world, Nikon and Canon. 

# The photography holy trinity

Photographers generally talk about three key concepts that you can control on your camera to get a proper exposure (not too dark, not too bright) for your pictures, which is basically how much light is reaching the film or sensor. These are the aperture, shutterspeed, and ISO. [This webpage goes into better detail than I will](www.digital-photo-secrets.com/tip/1462/photographers-trinity/). 

The lens aperture is a contraption (if you are interested in this stuff at all, you should really go look at a video of how it works, it's wicked cool) that controls how much light is let through to the film/sensor. This opening is measured in f-stops, where smaller numbers paradoxically means a larger, more open aperture (more light is coming in) while larger f-stops mean less light is coming through to the sensor or film. 

The aperture also has a secondary affect that determines your depth of field, or how much of the picture will be in focus. Low f-stops have shallow depths of field. My particular passion of late is macrophotography, so almost everything is comically out of focus due to being extremely close to the subject and has the minimum f-stop possible.

The second way to control exposure is pretty simple. It's your shutter speed, or how long the film or sensor is exposed to light. The [K-1000](https://en.wikipedia.org/wiki/Pentax_K1000) was so named because it's maximum shutter speed was 1/1000 of a second, which was really fast at the time. These days a pro-sumer camera (which pains me to type, but here we are), which basically means people like me who are willing to dump 500-1500 on a nice but not ludicrous camera, can get over 1/8000, at which point it probably stops mattering very much.

Like aperture, shutter speed has a secondary affect once you start wanting to get fancy where it can freeze or blur objects in motion. People get really awesome shots of streams and waterwalls with slow shutters speeds, and action shots of people playing sports or birds with high shutter speeds.

The final way to control exposure is with [ISO digital sensitivity](https://en.wikipedia.org/wiki/ISO_digital_speed). In ye days of olde, changing this would entail either using different cameras or changing the roll of film and using a different film sensitivity. However, with the advent of digital cameras this is just another knob or button that you fiddle with. It used to be much harder to adjust compared to aperture/shutter speed, but auto ISO and faster access to ISO settings have become more common in recent years. Definitely don't get stuck to only using 100/200 ISO all the time, it really limits you!

### FREE TIP INCOMING

<img src="https://thomas-keller.github.io/images/moorhen_leg.jpg" width="800">

This ended up being somewhat amusing, as it illustrates the objects in motion at least. I have this nasty habit that has stuck with me since the old film days and I was a cheapskate or who knows why, but it's ISO 100 obsession. For a long time digital cameras did have problems at high ISO, but we are fast past that now. 800 and 1600 ISO is fine, and even my ancient camera of 5 years has "artistic" grain or whatever at 3200 ISO.

When digital cameras were first getting started the difference between 100 ISO and 400 ISO was a really big deal, but today even 1600 is really not that bad even up to 8X10, and if you're just sending stuff around on Facebook or Instagram, don't worry. Or more accurately, get used to your camera and figure out your own tolerance. 

But definitely be aware that camera blur caused by taking a picture in low light at ISO 100 at a long shutter speed will probably get you a worse picture than a faster shutter speed at a higher ISO. It's hard to beat that habit out of myself, but at least it's easier than changing film. Hooray for technological advances!


### Why in the world aren't you talking about R yet?
I'm glad you asked! Keeping track of [EXIF](https://en.wikipedia.org/wiki/Exchangeable_image_file_format) is certainly not a new idea in the R literature, see this cool [Rpub](https://rpubs.com/yoke2/focal-length-with-exiftool-and-r) by Yoke Keong Wong that explored photography tendencies they had over three years. I, sadly, only have one month's data to go by with. I got my EXIF data by writing a terrible python 3 [script](http://thomas-keller.github.io/exif_datamine.py). You can see the Rpub for a probably less painful method using exiftool.

However, there are already a few cool things to talk about. First, over the last month I kept 137 pictures out of 663 shutter clicks, so an acceptance rate of about 21%. Get used to throwing away photos and keeping the better ones! Fortunately, all digital ink wastes is your time, etc, etc. One feature most fancier cameras have that I still don't use as much as I should, especially for birds and stuff, is continuous shooting for when you expect action.

Anyway, to plots:


```R
#figures for post about photography
df<-read.csv('tek_sweet_photodat.csv',header=T)
library(ggplot2)
library(cowplot)

df<-cbind(df,flen2=df$flength*1.5) # account from crop factor in camera
df<-cbind(df,lens=cut(df$flen2,breaks=c(0,80,300),labels=c('Wide/Normal','telephoto')))
p1<-ggplot(df,aes(x=df$flength*1.5,fill=lens))+geom_bar()
#p1<-p1+text("text", x = 225, y = 40, label = "150mm=Macro lens")
p1<-p1+xlab('Cropped Focal Length') + ylab('Count')
p2<-ggplot(df,aes(x=df$aperture))+geom_bar()
p2<-p2+xlab('Aperture')+ylab('Count')
p3<-ggplot(df,aes(x=-log10(df$exposure)))+geom_bar()+xlab('-log10(Shutter Speed)')+ylab('Count')
p4<-ggplot(df,aes(x=df$iso))+geom_bar()+xlab('ISO')+ylab('Count')

tekphoto<-plot_grid(p1,p2,p3,p4,align='h',nrow=2,ncol=2,labels=c('A','B','C','D'))
save_plot('tek_photodat.jpg',tekphoto,ncol=2,nrow=2)
``` 
![image](http://thomas-keller.github.io/images/tek_photodat.png)
So before digging into each panel I should explain what lens I have for the camera a bit. The Pentax K-5, like most of the digital cameras that aren't stupidly expensive have a 1.5 crop factor that basically automatically zooms into whatever lens you are using even more. so a 35mm lens actually shoot like a ~50-52mm lens. Because of this crop factor, none of my lens are actually very wide in the end. 

The most interesting thing about panel A is the huge peak at 150mm. This corresponds to the 100mm lens I have, which is actually a macrophotography lens. Macro lens let you take photos of things up to a 1:1 scale, which just means life size, as below. Well, also I use the max telephoto range a fair bit to peep on birds and such.

<img src="https://thomas-keller.github.io/images/lichen.jpg" width="800">

As the obsesso macro spiral begins and you get more xxtreme you start rigging weird extra crap onto your lens like a raynox (yet another lens) that increases the magnification to 2:1, so larger than life size now and beyond. 

<img src="https://thomas-keller.github.io/images/leaf_vein.jpg" width="800">

Of course, at this point your depth of field is so shallow you have to crank up the aperture to get ANYTHING in focus, and that means usually bringing in lights and flashes to help brighten subjects. It starts getting weird and expensive if you're really into it. I'm not there yet!


Moving on, in Panel B most pictures have an aperture skewed far to the left, letting in as much light as possible. These pictures also have very narrow depths of fields, however you pluralize that. The DoF benefit to increasing f-stops falls off past f-15 or so, which is why you don't see many really high values, as also a fast shutter speed is more than sufficient to balance even moderate f-stops. In reality you are often struggling to not get camera shake, unless it is a bright day.

Panel C shows a distribution of negative valued log10 normalized shutter speed values over the last month. Aside from the single value to the left of 0 (which untransformed was a 30 second nighttime picture), all of the other pictures were taken within fractions of a second. 
<img src="https://thomas-keller.github.io/images/stars.jpg" width="800">

One of the cool things about Pentax cameras in recent years is that they have in-camera stabilization, which is fancy talk to mean that they can deal with your hand shaking a SMALL amount. You'll notice that I generally tended a shutter speed of at least 1/100. I should have probably used 1/150, but because of that stabilization 1/100 was usually OK I think. 

One of the general rules of thumb when you first start to reduce camera blur, in this case caused specifically by your hand moving around when you press the shutter release button, is to use a shutter release that is at least as fast as the reciprical of the camera lens. If you're using a crop sensor camera, you need to take that into account as well. So when I'm using my 100mm (in effect 150mm) lens to shoot little bugs all the time, I would normally use 1/150, but I can often get away with 1/100 because Pentax is weird with their cameras.

Finally, Panel D shows again what I was talking about, way too much ISO 100. Especially since I really like macro stuff, there's a lot of bad light there that 400-1600 would be fine in. And again, I'm not trying to make a living off this stuff, I just post this on Instagram where it gets compressed to god knows what anyway? I actually don't know if Instagram has a separate compression step, but I would assume it does. 

---


```R
p<-qplot(-log10(df$exposure),df$aperture)
p<-p+xlab('Shutter Speed')+ylab('Aperture')
save_plot('exp_vs_aper.jpg',p)
```


![image](http://thomas-keller.github.io/images/exp_vs_aper.png)

You can see there's a general negative correlation , but it's not quite significant:


    >cor.test(-log10(df$exposure),df$aperture)

    Pearson's product-moment correlation

    data:  -log10(df$exposure) and df$aperture
    t = -1.7972, df = 135, p-value = 0.07453
    alternative hypothesis: true correlation is not equal to 0
    95 percent confidence interval:
    -0.31256659  0.01524164
    sample estimates:
        cor 
    -0.1528646 



This is because ISO is floating as a third variable to help control the overall amount of light getting in to the sensor and confounding the correlation. Cameras in the last 5-6 years have started having an auto-ISO feature that's pretty nice that let's the camera try to automatically try to figure out a good ISO for a proper exposure. So, say all you care about is have a low depth of field to blur the background, the camera can figure out the ISO and shutter speed (in theory) so that objects are neither blown out or blackened.  

# In conclusion...
I hope we all learned something today. Paint (picture [diagram] ) your little fluffy clouds!
