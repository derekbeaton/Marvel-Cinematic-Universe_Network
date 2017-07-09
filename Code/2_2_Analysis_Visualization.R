rm(list=ls())
gc()

library(gplots)
library(ExPosition)

source('PlottingHelperFunctions.R')

load('../Data/ForAnalyses/base.cols2.rda')
load('../Data/ForAnalyses/movie.mats.nogs_min2.rda')
load('../Data/ForAnalyses/movie.mats.nogs_min1.rda')
load('../Data/ForAnalyses/movie.mats.nogs.rda')
load('../Data/ForAnalyses/global.signal.rda')
load('../Data/ForAnalyses/movie.mats_min2.rda')
load('../Data/ForAnalyses/movie.mats_min1.rda')
load('../Data/ForAnalyses/movie.mats.rda')
load('../Data/ForAnalyses/unique.movies.rda')
load('../Data/ForAnalyses/appearances.rda')

# he's special.
appearances["Stan Lee"] <- (length(base.cols2$gc)-1)

ca.res <- epCA(movie.mats$thresh_load_diag,graphs=F)
	## just some visuals to display
#thisPlotter(ca.res,appearances[rownames(ca.res$ExPosition.Data$fi)],base.cols2,1,2,leg.pos="bottomleft")
#thisPlotter(ca.res,rep(3,nrow(ca.res$ExPosition.Data$fi)),base.cols2,1,2,leg.pos="topleft")	

#thisPlotter(ca.res,rep(1,nrow(ca.res$ExPosition.Data$fi)),base.cols2,7,8,leg.pos="topleft")
#thisPlotter(ca.res,log(appearances[rownames(ca.res$ExPosition.Data$fi)]+1),base.cols2,7,8,leg.pos="topleft")



	## cleaning up the space so I can get some gigglebites back.		
gc()		

	## Here I make the skeleton of my own network visualization
	## This is the CA plot in stupid high res. All names are included, as well as the axes for Components 1 and 2.

	## all individuals -- so use every actor in the visualization.
all.inds <- rownames(movie.mats$counts)

	png("../Pictures/CA/CA_12__NetworkConfig_NoNames.png",width=14000,height=14000,pointsize=66)
#	plot(ca.res$ExPosition.Data$fi[all.inds,],axes=F,pch=20,col=add.alpha("white",0),xlab="",ylab="")
	plot(ca.res$ExPosition.Data$fi[all.inds,],axes=F,type="n",xlab="",ylab="")
	abline(v=0,lwd=10,col='black',lty=3)
	abline(h=0,lwd=10,col='black',lty=3)	
	points(ca.res$ExPosition.Data$fi[all.inds,],pch=20,col=add.alpha(base.cols2$oc[all.inds,],.4),cex=3)
	legend("top",legend=rownames(base.cols2$gc),col=base.cols2$gc,pch=20,cex=2.5,pt.cex=3,text.col=base.cols2$gc,bty="n")
	dev.off()		
## clean up the space (gotta save them gigglebites).
gc()

	png("../Pictures/CA/CA_78__NetworkConfig_NoNames.png",width=14000,height=14000,pointsize=66)
#	plot(ca.res$ExPosition.Data$fi[all.inds,c(7,8)],axes=F,pch=20,col=add.alpha("white",0),xlab="",ylab="")
	plot(ca.res$ExPosition.Data$fi[all.inds,c(7,8)],axes=F,type="n",xlab="",ylab="")
	abline(v=0,lwd=10,col='black',lty=3)
	abline(h=0,lwd=10,col='black',lty=3)	
	points(ca.res$ExPosition.Data$fi[all.inds,c(7,8)],pch=20,col=add.alpha(base.cols2$oc[all.inds,],.4),cex=3)
	legend("top",legend=rownames(base.cols2$gc),col=base.cols2$gc,pch=20,cex=2.5,pt.cex=3,text.col=base.cols2$gc,bty="n")
	dev.off()		
## clean up the space (gotta save them gigglebites).
gc()



	png("../Pictures/CA/CA_12__NetworkConfig.png",width=14000,height=14000,pointsize=66)
#	plot(ca.res$ExPosition.Data$fi[all.inds,],axes=F,pch=20,col=add.alpha("white",0),xlab="",ylab="")
	plot(ca.res$ExPosition.Data$fi[all.inds,],axes=F,type="n",xlab="",ylab="")
	abline(v=0,lwd=10,col='black',lty=3)
	abline(h=0,lwd=10,col='black',lty=3)	
	points(ca.res$ExPosition.Data$fi[all.inds,],pch=20,col=add.alpha(base.cols2$oc[all.inds,],.4),cex=2)
	text(ca.res$ExPosition.Data$fi[all.inds,1],ca.res$ExPosition.Data$fi[all.inds,2],labels= all.inds,col=add.alpha(base.cols2$oc[all.inds,],.7),cex=.5,pos=1)			
	legend("top",legend=rownames(base.cols2$gc),col=base.cols2$gc,pch=20,cex=2.5,pt.cex=3,text.col=base.cols2$gc,bty="n")
	dev.off()	

## clean up the space (gotta save them gigglebites).	
gc()

	png("../Pictures/CA/CA_78__NetworkConfig.png",width=14000,height=14000,pointsize=66)
#	plot(ca.res$ExPosition.Data$fi[all.inds,c(7,8)],axes=F,pch=20,col=add.alpha("white",0),xlab="",ylab="")
	plot(ca.res$ExPosition.Data$fi[all.inds,c(7,8)],axes=F,type="n",xlab="",ylab="")
	abline(v=0,lwd=10,col='black',lty=3)
	abline(h=0,lwd=10,col='black',lty=3)	
	points(ca.res$ExPosition.Data$fi[all.inds,c(7,8)],pch=20,col=add.alpha(base.cols2$oc[all.inds,],.4),cex=2)
	text(ca.res$ExPosition.Data$fi[all.inds,7],ca.res$ExPosition.Data$fi[all.inds,8],labels= all.inds,col=add.alpha(base.cols2$oc[all.inds,],.7),cex=.5,pos=1)			
	legend("top",legend=rownames(base.cols2$gc),col=base.cols2$gc,pch=20,cex=2.5,pt.cex=3,text.col=base.cols2$gc,bty="n")
	dev.off()	

## clean up the space (gotta save them gigglebites).	
gc()



	## We know from a different network strucutre (no global signal, minimum 2 connections) that there is a much smaller subset of individuals. Let's *only* show them on the network.		
nogs_min2.inds <- rownames(movie.mats.nogs_min2$counts)
diff.inds <- setdiff(all.inds,nogs_min2.inds)
		
	png("../Pictures/CA/CA_12__NoGS_Min2_Network.png",width=28000/2,height=28000/2,pointsize=132/2)
#		plot(ca.res$ExPosition.Data$fi,axes=F,pch=20,col=add.alpha("white",0),xlab="",ylab="")
	plot(ca.res$ExPosition.Data$fi,axes=F,type="n",xlab="",ylab="")
	abline(v=0,lwd=10,col='black',lty=3)
	abline(h=0,lwd=10,col='black',lty=3)				
	for(i in 1:nrow(movie.mats.nogs_min2$thresh_zero.diag)){
		this.point <- ca.res$ExPosition.Data$fi[rownames(movie.mats.nogs_min2$thresh_zero.diag)[i],1:2]
		those.names <- names(which(which(movie.mats.nogs_min2$thresh_zero.diag[i,]==1)>i))
		if(length(those.names)>0){
			for(j in 1:length(those.names)){
				that.point <- ca.res$ExPosition.Data$fi[those.names[j],1:2]
				points(rbind(this.point,that.point),type="l",col=add.alpha("black",.4),lwd=3,lty=1)
			}
		}
	}

	points(ca.res$ExPosition.Data$fi[diff.inds,],pch=20,col=add.alpha(base.cols2$oc[diff.inds,],.25),xlab="",ylab="",cex=1.5)
		
	points(ca.res$ExPosition.Data$fi[nogs_min2.inds,],pch=21,col="black",bg=base.cols2$oc[nogs_min2.inds,],xlab="",ylab="",cex=log(rowSums(movie.mats.nogs_min2$counts[nogs_min2.inds,nogs_min2.inds]>0)-1)+1)
	shadowtext(ca.res$ExPosition.Data$fi[nogs_min2.inds,1],ca.res$ExPosition.Data$fi[nogs_min2.inds,2],labels=nogs_min2.inds,col=base.cols2$oc[nogs_min2.inds,],bg=add.alpha("grey60",.5),cex=.75)
	
	legend("top",legend=rownames(base.cols2$gc),col=base.cols2$gc,pch=20,cex=2.5,pt.cex=3,text.col=base.cols2$gc,bty="n")
	dev.off()


## clean up the space (gotta save them gigglebites).		
gc()		


	## We know from a different network strucutre (no global signal, minimum 2 connections) that there is a much smaller subset of individuals. Let's *only* show them on the network.		
nogs_min2.inds <- rownames(movie.mats.nogs_min2$counts)
diff.inds <- setdiff(all.inds,nogs_min2.inds)
		
	png("../Pictures/CA/CA_78__NoGS_Min2_Network.png",width=28000/2,height=28000/2,pointsize=132/2)
#		plot(ca.res$ExPosition.Data$fi,axes=F,pch=20,col=add.alpha("white",0),xlab="",ylab="")
	plot(ca.res$ExPosition.Data$fi[,c(7,8)],axes=F,type="n",xlab="",ylab="")
	abline(v=0,lwd=10,col='black',lty=3)
	abline(h=0,lwd=10,col='black',lty=3)				
	for(i in 1:nrow(movie.mats.nogs_min2$thresh_zero.diag)){
		this.point <- ca.res$ExPosition.Data$fi[rownames(movie.mats.nogs_min2$thresh_zero.diag)[i],c(7,8)]
		those.names <- names(which(which(movie.mats.nogs_min2$thresh_zero.diag[i,]==1)>i))
		if(length(those.names)>0){
			for(j in 1:length(those.names)){
				that.point <- ca.res$ExPosition.Data$fi[those.names[j],c(7,8)]
				points(rbind(this.point,that.point),type="l",col=add.alpha("black",.4),lwd=3,lty=1)
			}
		}
	}

	points(ca.res$ExPosition.Data$fi[diff.inds,c(7,8)],pch=20,col=add.alpha(base.cols2$oc[diff.inds,],.25),xlab="",ylab="",cex=1.5)
		
	points(ca.res$ExPosition.Data$fi[nogs_min2.inds,c(7,8)],pch=21,col="black",bg=base.cols2$oc[nogs_min2.inds,],xlab="",ylab="",cex=log(rowSums(movie.mats.nogs_min2$counts[nogs_min2.inds,nogs_min2.inds]>0)-1)+1)
	shadowtext(ca.res$ExPosition.Data$fi[nogs_min2.inds,7],ca.res$ExPosition.Data$fi[nogs_min2.inds,8],labels=nogs_min2.inds,col=base.cols2$oc[nogs_min2.inds,],bg=add.alpha("grey60",.5),cex=.75)
	
	legend("top",legend=rownames(base.cols2$gc),col=base.cols2$gc,pch=20,cex=2.5,pt.cex=3,text.col=base.cols2$gc,bty="n")
	dev.off()


## clean up the space (gotta save them gigglebites).		
gc()
	
		
	## this is simply to highlight that CA finds cliques.		
#ca.res2 <- epCA(movie.mats.nogs_min2$thresh_load_diag,graphs=F)
#ca.res2 <- epCA(movie.mats.nogs_min2$counts,graphs=F)
	# ## we don't want "inverse dimensions" which(diag(cor(ca.res$ExPosition.Data$fi,ca.res$ExPosition.Data$fj))==1)
	# which(diag(cor(ca.res3$ExPosition.Data$fi,ca.res3$ExPosition.Data$fj))==1)	
#	thisPlotter(ca.res2,appearances[rownames(ca.res2$ExPosition.Data$fi)],base.cols2,1,2,leg.pos="bottomleft")
#	thisPlotter(ca.res2,rep(4,nrow(ca.res2$ExPosition.Data$fi)),base.cols2,1,2,leg.pos="bottomleft")	
