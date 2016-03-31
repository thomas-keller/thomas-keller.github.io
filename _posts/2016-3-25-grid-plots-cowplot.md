---
layout: article
title: Cowplot is pretty OK in my book
excerpt: vectors are for cool kids
comments: true
tags: bioinformatics, data science, dataviz, R
image:
    teaser: back-9.jpg
---

One of the last papers from the postdoc with my really cool mentor [Soojin Yi](http://www.yilab.gatech.edu/) is out now in early view at [Molecular Ecology](http://onlinelibrary.wiley.com/doi/10.1111/mec.13573/abstract). This was a really fun and hard project for all sorts of reasons (I got to collaborate with my friend [Dr. Jesse R. Lasky](http://laskylab.org) who I first met in graduate school! I don't normally work with plants! I'm not normally an ecologist!). But none of those points are the point of this story.

I thought I'd step through some of the unexpected hurdles I encountered when getting to the end stage of the manuscript, after the reviews have gone back and forth, and its been accepted, and they want *REALLY* high quality figures. It had been a year or so since my last manuscript had gone through, and that journal had been fine with what I thought was a more or less standard 300-dpi tiff when submitting final figures. I'll swing back to cowplot at the end, but for years I had some options that I had hacked together that worked as figure-quality font sizes and placements, but only when saved as a tiff file, not as eps. 

Predictably enough the first rumbling was in one of my other recent papers ([Evolutionary transition of promoter and gene body DNA methylation across invertebrate-vertebrate boundary](http://mbe.oxfordjournals.org/content/early/2015/12/22/molbev.msv345.full.pdf+html)). In that journal (Molecular Biology and Evolution), they wanted 350 dpi, but were still ok with tiff.

Molecular Ecology was interesting to publish with because they require authors to do things I agree with but haven't done in the past. We created a [data dryad archive with all the data](https://datadryad.org/resource/doi:10.5061/dryad.80442), which as largely a [data parasite](http://www.nejm.org/doi/full/10.1056/NEJMe1516564) I haven't done much as there weren't many actual new nucleotides being produced. Anyway, it was a cool experience and worth it. The dryad stores the collated data from the couple different data papers we were pulling from as well as the end models, and the climate data.

---

As for making nice figures for publication, I have always hated getting panels aligned, and cowplot mostly seems to do a nice job of that when you have simple needs like a simple grid of similarly sized figures. My first go attempt was actually a tiff, and aligned and annotated by hand in inkscape. It sucked. Then of course I read the author guidelines for Molecular Ecology more closely (do this before you submit, **seriously** ) and realized that one of the ways they were more progressive in figures is they want everything as vector eps or along those lines.

So now I had to go back and redo everything as an eps, which meant I had to refigure out font sizes and places because they only worked as tiff because of the nightmare hack code I had from grad school.

[Cowplot](https://cran.rstudio.com/web/packages/cowplot/vignettes/introduction.html) is a neat recent project from one of my former graduate student advisers, [Claus Wilke](http://wilkelab.org/). I love the description in the second line from the vignette: "Its primary purpose is to give my students and postdocs an easy way to make figures that I will approve of." Having gone through many ugly draft figures, having a package like this that mostly just works is great. I had trouble figuring out a way to add enough space between rows for a center justified label, or even how to do that, so I just gave up and went back to inkscape to do that at the end. But overall it was pretty good.

As for what this figure is trying to convey, in the paper we were examining whether methylation, an epigenetic marker of DNA, is associated with climate in *Arabidopsis* ecotypes found throughout Europe. Using a multivariate statisticatal redundancy analysis, we then looked at the loadings and found that in both of the two datasets we were pulling from we were seeing similar patterns. In animals, DNA methylation methylation is generally thought to mostly be found in the CG symetric context (that is, a methyl group attached to the cytosine on both forward and negative strands). Recent papers from the Ecker lab have started challenging this, but it is a bit nuanced and certainly rare (less than ~5% or so in non-CG form). 

Anyway, in plants there are three common methylation contexts: CG, CHG, and CHH. Here, H stands for any nucleotide that's not a G. There's interesting biology that plays into the different contexts that we get into, like different proteins and pathways that methylation and demethylate, and they mark different areas of the genome. I should probably move all this stuff into another post...

```R
library(ggplot2)
#library(extrafont)
#loadfonts(device="postscript")
library(grid)
library(RColorBrewer)
library(vegan)

smp_space<-readRDS('/media/thomas/My Passport/postdoc/arab_stuff/nord10_SMP_plink_tpruned_full.Rds')
cdat<-read.csv('nord10_SMP_plink_pruned.csv',header=T)
dmr_scores<-scores(smp_space,display='species',choices=1) #rda 1 only
#gotta get rid of weird attribute
attributes(dmr_scores)<-c()
dmr_scores<-data.frame(score=dmr_scores,score_sq=dmr_scores^2)
dmr_scores<-cbind(dmr_scores,rank=rank(dmr_scores$score_sq),smp_num=1:nrow(dmr_scores))
dmr_scores<-cbind(dmr_scores,class=cdat$class)
dmr_scores2<-dmr_scores[order(dmr_scores$score_sq,decreasing=T),]

qv<-quantile(dmr_scores2[,2],seq(0,1,1/100))
qv[1]<-0
qv[101]<-1
dmr_scores3<-cbind(dmr_scores2,quantile=cut(dmr_scores2$score_sq,qv,labels=100:1,include.lowest=T))
hm<-cdat[dmr_scores3[dmr_scores3$quantile==1,4],4]
table(hm)
cquant<-data.frame(quant=rep(.01,3),perc_ctype=as.numeric(table(hm)/c(42321,16954,103270)),ctype=c('CG','CHG','CHH'))
for(i in 2:100){
    subdf<-cdat[dmr_scores3[dmr_scores3$quantile %in% 1:i,4],4]
    cquant2<-data.frame(quant=rep(i/100,3),perc_ctype=as.numeric(table(subdf)/c(42321,16954,103270)),ctype=c('CG','CHG','CHH'))
    cquant<-rbind(cquant,cquant2)
}

library(ggplot2)
p<-ggplot(data=cquant,aes(x=quant,y=perc_ctype,colour=ctype))
p<-p+geom_line()+theme_bw()
p<-p+theme(panel.grid.major=element_blank(),
          panel.grid.minor=element_blank(),
          #axis.text.x=element_text(angle=45,vjust=.7),
          legend.position='none'
          )
#p<-p+theme(text=element_text(family='Arial'))
p<-p+ylab('Percent of Methylation Context')
p<-p+xlab('Cumulative Quantile of RDA 1')

p4<-p

dmr_scores<-scores(smp_space,display='species',choices=2) #rda 1 only
#gotta get rid of weird attribute
attributes(dmr_scores)<-c()
dmr_scores<-data.frame(score=dmr_scores,score_sq=dmr_scores^2)
dmr_scores<-cbind(dmr_scores,rank=rank(dmr_scores$score_sq),smp_num=1:nrow(dmr_scores))
dmr_scores2<-dmr_scores[order(dmr_scores$score_sq,decreasing=T),]
qv<-quantile(dmr_scores2[,2],seq(0,1,1/100))
qv[1]<-0
qv[101]<-1
dmr_scores3<-cbind(dmr_scores2,quantile=cut(dmr_scores2$score_sq,qv,labels=100:1,include.lowest=T))
hm<-cdat[dmr_scores3[dmr_scores3$quantile==1,4],4]
table(hm)
cquant<-data.frame(quant=rep(.01,3),perc_ctype=as.numeric(table(hm)/c(42321,16954,103270)),ctype=c('CG','CHG','CHH'))
for(i in 2:100){
    subdf<-cdat[dmr_scores3[dmr_scores3$quantile %in% 1:i,4],4]
    cquant2<-data.frame(quant=rep(i/100,3),perc_ctype=as.numeric(table(subdf)/c(42321,16954,103270)),ctype=c('CG','CHG','CHH'))
    cquant<-rbind(cquant,cquant2)
}

library(ggplot2)
p<-ggplot(data=cquant,aes(x=quant,y=perc_ctype,colour=ctype))
p<-p+geom_line()+theme_bw()
p<-p+theme(panel.grid.major=element_blank(),
          panel.grid.minor=element_blank(),
          #axis.text.x=element_text(angle=45,vjust=.7),
          legend.position='none'
          )
#p<-p+theme(text=element_text(family='Arial'))
p<-p+ylab('Percent of Methylation Context')
p<-p+xlab('Cumulative Quantile of RDA 2')

p5<-p

dmr_scores<-scores(smp_space,display='species',choices=3) #rda 1 only
#gotta get rid of weird attribute
attributes(dmr_scores)<-c()
dmr_scores<-data.frame(score=dmr_scores,score_sq=dmr_scores^2)
dmr_scores<-cbind(dmr_scores,rank=rank(dmr_scores$score_sq),smp_num=1:nrow(dmr_scores))
dmr_scores2<-dmr_scores[order(dmr_scores$score_sq,decreasing=T),]
qv<-quantile(dmr_scores2[,2],seq(0,1,1/100))
qv[1]<-0
qv[101]<-1
dmr_scores3<-cbind(dmr_scores2,quantile=cut(dmr_scores2$score_sq,qv,labels=100:1,include.lowest=T))
hm<-cdat[dmr_scores3[dmr_scores3$quantile==1,4],4]
table(hm)
cquant<-data.frame(quant=rep(.01,3),perc_ctype=as.numeric(table(hm)/c(42321,16954,103270)),ctype=c('CG','CHG','CHH'))
for(i in 2:100){
    subdf<-cdat[dmr_scores3[dmr_scores3$quantile %in% 1:i,4],4]
    cquant2<-data.frame(quant=rep(i/100,3),perc_ctype=as.numeric(table(subdf)/c(42321,16954,103270)),ctype=c('CG','CHG','CHH'))
    cquant<-rbind(cquant,cquant2)
}

library(ggplot2)
p<-ggplot(data=cquant,aes(x=quant,y=perc_ctype,colour=ctype))
p<-p+geom_line()+theme_bw()
p<-p+theme(panel.grid.major=element_blank(),
          panel.grid.minor=element_blank(),
          #axis.text.x=element_text(angle=45,vjust=.7),
          legend.position='none'
          )
#p<-p+theme(text=element_text(family='Arial'))
p<-p+ylab('Percent of Methylation Context')
p<-p+xlab('Cumulative Quantile of RDA 3')

p6<-p


smp_space<-readRDS('/media/thomas/My Passport/postdoc/arab_stuff/smps_tpruned_full.Rds')
dmr_scores<-scores(smp_space,display='species',choices=1) #rda 1 only
#gotta get rid of weird attribute
attributes(dmr_scores)<-c()
dmr_scores<-data.frame(score=dmr_scores,score_sq=dmr_scores^2)
dmr_scores<-cbind(dmr_scores,rank=rank(dmr_scores$score_sq),smp_num=1:nrow(dmr_scores))
dmr_scores2<-dmr_scores[order(dmr_scores$score_sq,decreasing=T),]
cdat<-read.csv('arab_smps_pruned.csv',header=T)
qv<-quantile(dmr_scores2[,2],seq(0,1,1/100))
qv[1]<-0
qv[101]<-1
dmr_scores3<-cbind(dmr_scores2,quantile=cut(dmr_scores2$score_sq,qv,labels=100:1))
hm<-cdat[dmr_scores3[dmr_scores3$quantile==1,4],4]
table(hm)
cquant<-data.frame(quant=rep(.01,3),perc_ctype=as.numeric(table(hm)/c(112219,10354,59517)),ctype=c('CG','CHG','CHH'))
for(i in 2:100){
    subdf<-cdat[dmr_scores3[dmr_scores3$quantile %in% 1:i,4],4]
    cquant2<-data.frame(quant=rep(i/100,3),perc_ctype=as.numeric(table(subdf)/c(112219,10354,59517)),ctype=c('CG','CHG','CHH'))
    cquant<-rbind(cquant,cquant2)
}

library(ggplot2)
p<-ggplot(data=cquant,aes(x=quant,y=perc_ctype,colour=ctype))
p<-p+geom_line()+theme_bw()
p<-p+theme(panel.grid.major=element_blank(),
          panel.grid.minor=element_blank(),
          #axis.text.x=element_text(angle=45,vjust=.7),
          legend.position=c(.8,.3)
          )
#p<-p+theme(text=element_text(family='Arial'))
p<-p+ylab('Percent of Methylation Context')
p<-p+xlab('Cumulative Quantile of RDA 1')

p1<-p



#smp_space<-readRDS('/media/thomas/My Passport/postdoc/arab_stuff/smps_tpruned_full.Rds')
dmr_scores<-scores(smp_space,display='species',choices=2) #rda 1 only
#gotta get rid of weird attribute
attributes(dmr_scores)<-c()
dmr_scores<-data.frame(score=dmr_scores,score_sq=dmr_scores^2)
dmr_scores<-cbind(dmr_scores,rank=rank(dmr_scores$score_sq),smp_num=1:nrow(dmr_scores))
dmr_scores2<-dmr_scores[order(dmr_scores$score_sq,decreasing=T),]
#cdat<-read.csv('arab_smps_pruned.csv',header=T)
qv<-quantile(dmr_scores2[,2],seq(0,1,1/100))
qv[1]<-0
qv[101]<-1
dmr_scores3<-cbind(dmr_scores2,quantile=cut(dmr_scores2$score_sq,qv,labels=100:1))
hm<-cdat[dmr_scores3[dmr_scores3$quantile==1,4],4]
table(hm)
cquant<-data.frame(quant=rep(.01,3),perc_ctype=as.numeric(table(hm)/c(112219,10354,59517)),ctype=c('CG','CHG','CHH'))
for(i in 2:100){
    subdf<-cdat[dmr_scores3[dmr_scores3$quantile %in% 1:i,4],4]
    cquant2<-data.frame(quant=rep(i/100,3),perc_ctype=as.numeric(table(subdf)/c(112219,10354,59517)),ctype=c('CG','CHG','CHH'))
    cquant<-rbind(cquant,cquant2)
}

library(ggplot2)
p<-ggplot(data=cquant,aes(x=quant,y=perc_ctype,colour=ctype))
p<-p+geom_line()+theme_bw()
p<-p+theme(panel.grid.major=element_blank(),
          panel.grid.minor=element_blank(),
          #axis.text.x=element_text(angle=45,vjust=.7),
          legend.position='none'
          )
#p<-p+theme(text=element_text(family='Arial'))
p<-p+ylab('Percent of Methylation Context')
p<-p+xlab('Cumulative Quantile of RDA 2')
#plot(p)

p2<-p

#smp_space<-readRDS('smps_tpruned_full.Rds')
dmr_scores<-scores(smp_space,display='species',choices=3) #rda 1 only
#gotta get rid of weird attribute
attributes(dmr_scores)<-c()
dmr_scores<-data.frame(score=dmr_scores,score_sq=dmr_scores^2)
dmr_scores<-cbind(dmr_scores,rank=rank(dmr_scores$score_sq),smp_num=1:nrow(dmr_scores))
dmr_scores2<-dmr_scores[order(dmr_scores$score_sq,decreasing=T),]
#cdat<-read.csv('arab_smps_pruned.csv',header=T)
qv<-quantile(dmr_scores2[,2],seq(0,1,1/100))
qv[1]<-0
qv[101]<-1
dmr_scores3<-cbind(dmr_scores2,quantile=cut(dmr_scores2$score_sq,qv,labels=100:1))
hm<-cdat[dmr_scores3[dmr_scores3$quantile==1,4],4]
table(hm)
cquant<-data.frame(quant=rep(.01,3),perc_ctype=as.numeric(table(hm)/c(112219,10354,59517)),ctype=c('CG','CHG','CHH'))
for(i in 2:100){
    subdf<-cdat[dmr_scores3[dmr_scores3$quantile %in% 1:i,4],4]
    cquant2<-data.frame(quant=rep(i/100,3),perc_ctype=as.numeric(table(subdf)/c(112219,10354,59517)),ctype=c('CG','CHG','CHH'))
    cquant<-rbind(cquant,cquant2)
}

library(ggplot2)
p<-ggplot(data=cquant,aes(x=quant,y=perc_ctype,colour=ctype))
p<-p+geom_line()+theme_bw()
p<-p+theme(panel.grid.major=element_blank(),
          panel.grid.minor=element_blank(),
          #axis.text.x=element_text(angle=45,vjust=.7),
          legend.position='none'
          )
#p<-p+theme(text=element_text(family='Arial'))
p<-p+ylab('Percent of Methylation Context')
p<-p+xlab('Cumulative quantile of RDA 3')
#plot(p)
p3<-p

library(cowplot)
hm<-plot_grid(p1,p2,p3,p4,p5,p6,labels=c('A','B','C','D','E','F'),ncol=3,nrow=2,align='h')
#save_plot('Fig_3_for_internets.eps',hm,ncol=3,nrow=2)
save_plot('Fig_3_for_internets.png',hm,ncol=3,nrow=2)
```

What's noteworthy, aside from my spagetti code and regrettable habit of copy-pasting (there's always the thought that it's going to be one and done, so what's the point of turning into a function... hundreds of lines later...), is that the actual cowplot part is thankfully nice and short, just 3 lines. And, it has sane defaults. Well, it has Claus Wilke defaults, which most who have met him would agree are more or less the same thing.          

```R
hm<-plot_grid(p1,p2,p3,p4,p5,p6,labels=c('A','B','C','D','E','F'),ncol=3,nrow=2,align='h')
save_plot('Fig_3_for_internets.png',hm,ncol=3,nrow=2)
```

This is the figure straight out of R, with no modifications. and of course, the irony of getting it to display on github
...45 minutes later I'm realizing why my labmate Ixa's husband Urko was raving about Knitr...

![image](http://thomas-keller.github.io/images/Fig_3_for_internets.png)

Sadly I am only now in writing this blog post realizing the typo in panel C. Sorry collabos!

I don't have a copy of Photoshop, and Inkscape is kind of a pain to work with. Mainly, there is a longstanding bug where if you want to export as eps (which you will for scientific figures) certain elements would disappear. This turns out to be related to grouping, so it you ungroup everything and thing save as eps, it's ok. Still, this was first reported 3 years ago. However, I'm mindful of the flack open source projects get for putting in their valuable free time, and it's still of great use. Just frustrating at times.

So, after frankensteining the figure by cutting it in half, adding some space to add some legends to differentiate the different datasets, here is the actual figure for the paper. I have no idea if a centered legend like this is possible in cowplot

![image](http://thomas-keller.github.io/images/Fig3_with_annot.png)

I've generally used inkscape in the past for panel figures, but never really utilized any of the alignment options so I just tried to align things by eye which I'm sure has led to everything being off by one or two pixels if you go back to my past publications over the years.

Thanks Claus!