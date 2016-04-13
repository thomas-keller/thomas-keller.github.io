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



#smp_space<-readRDS('/media/thomas/My Passport/postdoc/arab_stuffsmps_tpruned_full.Rds')
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

save_plot('Fig_3_for_internets.eps',hm,ncol=3,nrow=2)