rm(list=ls())
gc()

library(gplots)
library(ExPosition)

source('PlottingHelperFunctions.R')

load('./SaveFiles/ForAnalyses/base.cols2.rda')
load('./SaveFiles/ForAnalyses/movie.mats.nogs_min2.rda')
load('./SaveFiles/ForAnalyses/movie.mats.nogs_min1.rda')
load('./SaveFiles/ForAnalyses/movie.mats.nogs.rda')
load('./SaveFiles/ForAnalyses/global.signal.rda')
load('./SaveFiles/ForAnalyses/movie.mats_min2.rda')
load('./SaveFiles/ForAnalyses/movie.mats_min1.rda')
load('./SaveFiles/ForAnalyses/movie.mats.rda')
load('./SaveFiles/ForAnalyses/unique.movies.rda')
load('./SaveFiles/ForAnalyses/appearances.rda')


# he's special.
appearances["Stan Lee"] <- (length(base.cols2$gc)-1)

# my.heatmap(movie.mats$thresh,movie.mats$dissimilar,colors.list=base.cols2$oc,main="Full Connectivity (Thresholded)",png=T,dir="./Pics/",filename="1_StandardConnectivity_FullThreshold.png")

# my.heatmap(movie.mats$thresh_zero.diag,movie.mats$dissimilar,colors.list=base.cols2$oc,main="Full Connectivity (Thresholded)",png=T,dir="./Pics/",filename="2_StandardConnectivity_FullThreshold_ZeroDiag.png")

# my.heatmap(movie.mats.nogs$thresh,movie.mats.nogs$dissimilar,colors.list=base.cols2$oc,main="No Global Signal (Thresholded)",png=T,dir="./Pics/",filename="3_StandardConnectivity_NoGSThreshold.png")

# my.heatmap(movie.mats.nogs$thresh_zero.diag,movie.mats.nogs$dissimilar,colors.list=base.cols2$oc,main="No Global Signal (Thresholded)",png=T,dir="./Pics/",filename="4_StandardConnectivity_NoGSThreshold_ZeroDiag.png")


# my.heatmap(movie.mats$counts_zero.diag,movie.mats$dissimilar,heatramp_colors=256,colors.list=base.cols2$oc,main="Full Connectivity",png=T,dir="./Pics/",filename="5_StandardConnectivity_FullCounts_ZeroDiag.png")

# movie.counts.thresh <- movie.mats$counts_zero.diag
# movie.counts.thresh[movie.counts.thresh > 9] <- 10
# my.heatmap(movie.counts.thresh,movie.mats$dissimilar,heatramp_colors=256,colors.list=base.cols2$oc,main="Full Connectivity",png=T,dir="./Pics/",filename="6_StandardConnectivity_FullCounts_ZeroDiag_Thresholded.png")


# my.heatmap(movie.mats.nogs$counts_zero.diag,movie.mats.nogs$dissimilar,heatramp_colors=256,colors.list=base.cols2$oc,main="Full Connectivity",png=T,dir="./Pics/",filename="7_StandardConnectivity_NoGSCounts_ZeroDiag.png")


# movie.counts.nogs.thresh <- movie.mats.nogs$counts_zero.diag
# movie.counts.nogs.thresh[movie.counts.nogs.thresh > 9] <- 10
# my.heatmap(movie.counts.nogs.thresh,movie.mats.nogs$dissimilar,heatramp_colors=256,colors.list=base.cols2$oc,main="No Global Signal",png=T,dir="./Pics/",filename="8_StandardConnectivity_NoGSCounts_ZeroDiag_Thresholded.png")




## Thomas the Tank Engine: Michael Brandon, Martin Sherman, William Hope


	## I can delve into the nuances later. I just want to present this bluntly.
	## so I'll also need better versions of the network images above.
### OK so let's stick with the easy one: movie.mats$thresh_load_diag

## redo network images then CA
#my.heatmap(movie.counts.nogs.thresh,movie.mats.nogs$dissimilar,heatramp_colors=256,colors.list=base.cols2$oc,main="No Global Signal",png=T,dir="./Pics/",filename="8_StandardConnectivity_NoGSCounts_ZeroDiag_Thresholded.png")

counts_zerodiag <- movie.mats$counts
diag(counts_zerodiag) <- rep(0,length(diag(counts_zerodiag)))
my.heatmap(counts_zerodiag,heatramp=colorRampPalette(c("white","black")),movie.mats$dissimilar,heatramp_colors=32,colors.list=base.cols2$oc,main="Full Connectivity (Counts)",png=T,dir="./Pics/",filename="00_FullConnectivity_Counts.png")

count.thresh <- movie.mats$counts
count.thresh[count.thresh>5] <- 6
diag(count.thresh) <- rep(0,length(diag(count.thresh)))
my.heatmap(count.thresh,heatramp=colorRampPalette(c("white","black")),movie.mats$dissimilar,heatramp_colors=7,colors.list=base.cols2$oc,main="Full Connectivity (Counts; Thresholded)",png=T,dir="./Pics/",filename="00_FullConnectivity_Counts_Thresholded_ZeroDiag.png")



## test with image
counts.mat <- movie.mats$counts
rowInd <- order.dendrogram(as.dendrogram(hclust(as.dist(movie.mats$dissimilar),method="ward.D2")))
counts.mat <- counts.mat[rowInd,rowInd]
upper.thresh <- lower.thresh <- counts.mat
lower.thresh[lower.tri(lower.thresh,diag=F)] <- NA
lower.thresh[lower.thresh>0] <- 1
upper.thresh[upper.tri(upper.thresh,diag=T)] <- NA
upper.thresh[upper.thresh>5] <- 6


png("TEST_NET.png",width=12000,height=12000,pointsize=300)
image(x=1:nrow(counts.mat),y=1:ncol(counts.mat),z=lower.thresh,axes=F,col=colorRampPalette(c("white","black"))(2),xlab="",ylab="")
image(x=1:nrow(counts.mat),y=1:ncol(counts.mat),z=upper.thresh,add=T,col=colorRampPalette(c("palegreen1","mediumorchid"))(7))
ypos <- axis(4, at=1:nrow(counts.mat), labels = rep("", nrow(counts.mat)), las = 2, line = -0.5, tick = 0)
text(x = par("usr")[2] + (1 + .5) * strwidth("M"), y = ypos, labels=rownames(counts.mat), cex = 0.175/log10(nrow(counts.mat)), col=base.cols2$oc[rownames(counts.mat),],xpd=T)
dev.off()

#reorderfun = function(d, w) reorder(d, w)

#ddr <- as.dendrogram(hcr)
#ddr <- reorderfun(ddr, Rowv)



##

ca.res <- epCA(movie.mats$thresh_load_diag,graphs=F)
	# ## we don't want "inverse dimensions" which(diag(cor(ca.res$ExPosition.Data$fi,ca.res$ExPosition.Data$fj))==1)
	# which(diag(cor(ca.res3$ExPosition.Data$fi,ca.res3$ExPosition.Data$fj))==1)	
	thisPlotter(ca.res,appearances[rownames(ca.res$ExPosition.Data$fi)],base.cols2,1,2,leg.pos="bottomleft")
	thisPlotter(ca.res,rep(3,nrow(ca.res$ExPosition.Data$fi)),base.cols2,1,2,leg.pos="topleft")	

## then dive into NoGS with min connections @ 2; 1 is cool, too. Should build up.
ca.res1 <- epCA(movie.mats.nogs_min1$thresh_load_diag,graphs=F)
	# ## we don't want "inverse dimensions" which(diag(cor(ca.res$ExPosition.Data$fi,ca.res$ExPosition.Data$fj))==1)
	# which(diag(cor(ca.res3$ExPosition.Data$fi,ca.res3$ExPosition.Data$fj))==1)	
	thisPlotter(ca.res1,appearances[rownames(ca.res1$ExPosition.Data$fi)],base.cols2,3,4,leg.pos="bottomleft")
	thisPlotter(ca.res1,rep(2,nrow(ca.res1$ExPosition.Data$fi)),base.cols2,3,4,leg.pos="bottomleft")	
		
ca.res2 <- epCA(movie.mats.nogs_min2$thresh_load_diag,graphs=F)
	# ## we don't want "inverse dimensions" which(diag(cor(ca.res$ExPosition.Data$fi,ca.res$ExPosition.Data$fj))==1)
	# which(diag(cor(ca.res3$ExPosition.Data$fi,ca.res3$ExPosition.Data$fj))==1)	
	thisPlotter(ca.res2,appearances[rownames(ca.res2$ExPosition.Data$fi)],base.cols2,3,4,leg.pos="bottomleft")
	thisPlotter(ca.res2,rep(4,nrow(ca.res2$ExPosition.Data$fi)),base.cols2,3,4,leg.pos="bottomleft")	


## then dive into the old code to connect individuals.

