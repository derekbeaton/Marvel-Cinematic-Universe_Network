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
appearances["Stan Lee"] <- 20

my.heatmap(movie.mats$thresh,movie.mats$dissimilar,colors.list=base.cols2$oc,main="Full Connectivity (Thresholded)",png=T,dir="./Pics/",filename="1_StandardConnectivity_FullThreshold.png")

my.heatmap(movie.mats$thresh_zero.diag,movie.mats$dissimilar,colors.list=base.cols2$oc,main="Full Connectivity (Thresholded)",png=T,dir="./Pics/",filename="2_StandardConnectivity_FullThreshold_ZeroDiag.png")

my.heatmap(movie.mats.nogs$thresh,movie.mats.nogs$dissimilar,colors.list=base.cols2$oc,main="No Global Signal (Thresholded)",png=T,dir="./Pics/",filename="3_StandardConnectivity_NoGSThreshold.png")

my.heatmap(movie.mats.nogs$thresh_zero.diag,movie.mats.nogs$dissimilar,colors.list=base.cols2$oc,main="No Global Signal (Thresholded)",png=T,dir="./Pics/",filename="4_StandardConnectivity_NoGSThreshold_ZeroDiag.png")


my.heatmap(movie.mats$counts_zero.diag,movie.mats$dissimilar,heatramp_colors=256,colors.list=base.cols2$oc,main="Full Connectivity",png=T,dir="./Pics/",filename="5_StandardConnectivity_FullCounts_ZeroDiag.png")

movie.counts.thresh <- movie.mats$counts_zero.diag
movie.counts.thresh[movie.counts.thresh > 9] <- 10
my.heatmap(movie.counts.thresh,movie.mats$dissimilar,heatramp_colors=256,colors.list=base.cols2$oc,main="Full Connectivity",png=T,dir="./Pics/",filename="6_StandardConnectivity_FullCounts_ZeroDiag_Thresholded.png")


my.heatmap(movie.mats.nogs$counts_zero.diag,movie.mats.nogs$dissimilar,heatramp_colors=256,colors.list=base.cols2$oc,main="Full Connectivity",png=T,dir="./Pics/",filename="7_StandardConnectivity_NoGSCounts_ZeroDiag.png")


movie.counts.nogs.thresh <- movie.mats.nogs$counts_zero.diag
movie.counts.nogs.thresh[movie.counts.nogs.thresh > 9] <- 10
my.heatmap(movie.counts.nogs.thresh,movie.mats.nogs$dissimilar,heatramp_colors=256,colors.list=base.cols2$oc,main="No Global Signal",png=T,dir="./Pics/",filename="8_StandardConnectivity_NoGSCounts_ZeroDiag_Thresholded.png")




#OK so there are a few matrices to concern ourselves with:
	##movie.mats$counts
	##movie.mats$counts_zero.diag	
	##movie.mats$thresh_zero.diag
	##movie.mats$thresh_load_diag

## I like the ca.res3 the most... it is simplest and informative
	## alternatively ca.res1 is fine.

# ##a test
# ca.res1 <- epCA(movie.mats$counts,graphs=F)
	# ## we don't want "inverse dimensions" which(diag(cor(ca.res$ExPosition.Data$fi,ca.res$ExPosition.Data$fj))==1)
	# which(diag(cor(ca.res1$ExPosition.Data$fi,ca.res1$ExPosition.Data$fj))==1)
	# thisPlotter(ca.res1,appearances[rownames(ca.res1$ExPosition.Data$fi)],base.cols2,1,2,leg.pos="bottomright")
	
# ##a test
# ca.res2 <- epCA(movie.mats$counts_zero.diag,graphs=F)
	# ## we don't want "inverse dimensions" which(diag(cor(ca.res$ExPosition.Data$fi,ca.res$ExPosition.Data$fj))==1)
	# which(diag(cor(ca.res2$ExPosition.Data$fi,ca.res2$ExPosition.Data$fj))==1)
	# thisPlotter(ca.res2,appearances[rownames(ca.res2$ExPosition.Data$fi)],base.cols2,1,2,leg.pos="bottomright")
	
# ##a test
# ca.res3 <- epCA(movie.mats$thresh_load_diag,graphs=F)
	# ## we don't want "inverse dimensions" which(diag(cor(ca.res$ExPosition.Data$fi,ca.res$ExPosition.Data$fj))==1)
	# which(diag(cor(ca.res3$ExPosition.Data$fi,ca.res3$ExPosition.Data$fj))==1)	
	# thisPlotter(ca.res3,appearances[rownames(ca.res3$ExPosition.Data$fi)],base.cols2,1,2,leg.pos="bottomright")
		
# ##a test
# ca.res4 <- epCA(movie.mats$thresh_zero.diag,graphs=F)
	# ## we don't want "inverse dimensions" which(diag(cor(ca.res$ExPosition.Data$fi,ca.res$ExPosition.Data$fj))==1)
	# which(diag(cor(ca.res4$ExPosition.Data$fi,ca.res4$ExPosition.Data$fj))==1)
	# thisPlotter(ca.res4,appearances[rownames(ca.res4$ExPosition.Data$fi)],base.cols2,1,2,leg.pos="bottomright")

# ## this isn't quite right...
# #laplace <- eigen(diag(colSums(movie.mats$thresh_zero.diag)) - movie.mats$thresh_zero.diag)
# #t(laplace$vectors) %*% laplace$vectors
# #plot(laplace$vectors)




# thisPlotter(ca.res,appearances[rownames(ca.res$ExPosition.Data$fi)],base.cols2,1,2,leg.pos="bottomright")
# thisPlotter(ca.res,appears=rep(2,nrow(ca.res$ExPosition.Data$fi)),cols=base.cols2,xa=1,ya=2,leg.pos="bottomright")
	# ## 11 and 12 look OK
	# ## NMDS -- use 1:16
# library(MASS)
# unique.fis <- unique(ca.res1$ExPosition.Data$fi[,1:16])
# d <- dist(unique.fis)
# fit <- isoMDS(d,k=2)
# prettyPlot(fit$points,axes=F,col=base.cols2$oc[rownames(fit$points),],pch=20,display_names=F,cex=appearances[rownames(fit$points)]/2)
	# ## I can replace the missing people with identical values to what they would be given similarity in $fi
	# ## then use that in Gephi or some other visualizer. Or just do it myself.


# mds.res <- epMDS(ca.res3$ExPosition.Data$fi[,1:16],F,graphs=F)
# prettyPlot(mds.res$ExPosition.Data$fi,axes=F,col=base.cols2$oc[rownames(mds.res$ExPosition.Data$fi),],pch=20,display_names=F)

# # ca.res <- epCA(movie.mats.nogs$thresh,graphs=F)	
# # thisPlotter(ca.res,appearances,base.cols2,7,8,leg.pos="bottomright")



## Thomas the Tank Engine: Michael Brandon, Martin Sherman, William Hope


	## I can delve into the nuances later. I just want to present this bluntly.
	## so I'll also need better versions of the network images above.
### OK so let's stick with the easy one: movie.mats$thresh_load_diag

## redo network images then CA

ca.res <- epCA(movie.mats$thresh_load_diag,graphs=F)
	# ## we don't want "inverse dimensions" which(diag(cor(ca.res$ExPosition.Data$fi,ca.res$ExPosition.Data$fj))==1)
	# which(diag(cor(ca.res3$ExPosition.Data$fi,ca.res3$ExPosition.Data$fj))==1)	
	thisPlotter(ca.res,appearances[rownames(ca.res3$ExPosition.Data$fi)],base.cols2,1,2,leg.pos="bottomright")
	
## then dive into NoGS with min connections @ 2

## then dive into the old code to connect individuals.

