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


## a base order to go with -- just appearances for all.
counts.mat <- movie.mats$counts
rowInd <- order.dendrogram(as.dendrogram(hclust(as.dist(movie.mats$dissimilar),method="ward.D2")))
counts.mat <- counts.mat[rowInd,rowInd]

upper.thresh <- lower.thresh <- counts.mat

upper.thresh[lower.tri(upper.thresh,diag=F)] <- NA
upper.thresh[upper.thresh>0] <- 1
lower.thresh[upper.tri(lower.thresh,diag=T)] <- NA

dual.heatmap(upper.thresh, lower.thresh, lowerRampCols=7,label.colors=base.cols2$oc[rownames(counts.mat),],main="Dual Network -- No Thresholding",png=T,dir="../Pictures/DualNetworkVis/",filename="DualNet_NoThresh.png")


lower.thresh[lower.thresh>5] <- 6
dual.heatmap(upper.thresh, lower.thresh, lowerRampCols=7,label.colors=base.cols2$oc[rownames(counts.mat),],main="Dual Network",png=T,dir="../Pictures/DualNetworkVis/",filename="DualNet.png")



## Now remove the global signal (MCU movies); use the order/actors from original
nogs.counts <- counts.mat
nogs.counts[] <- 0
nogs.counts[rownames(movie.mats.nogs$counts),colnames(movie.mats.nogs$counts)] <- movie.mats.nogs$counts
nogs.upper.thresh <- nogs.lower.thresh <- nogs.counts

nogs.upper.thresh[lower.tri(nogs.upper.thresh,diag=F)] <- NA
nogs.upper.thresh[nogs.upper.thresh>0] <- 1

nogs.lower.thresh[upper.tri(nogs.lower.thresh,diag=T)] <- NA
nogs.lower.thresh[nogs.lower.thresh>5] <- 6

dual.heatmap(nogs.upper.thresh, nogs.lower.thresh, lowerRampCols=7,label.colors=base.cols2$oc[rownames(nogs.counts),],main="Dual Network - No Global Signal",png=T,dir="../Pictures/DualNetworkVis/",filename="DualNet_NoGS.png")


## Now remove the global signal (MCU movies) and require minimum of 2 connections; use the order/actors from original
nogs.min2.counts <- counts.mat
nogs.min2.counts[] <- 0
nogs.min2.counts[rownames(movie.mats.nogs_min2$counts),colnames(movie.mats.nogs_min2$counts)] <- movie.mats.nogs_min2$counts
nogs.min2.upper.thresh <- nogs.min2.lower.thresh <- nogs.min2.counts

nogs.min2.upper.thresh[lower.tri(nogs.min2.upper.thresh,diag=F)] <- NA
nogs.min2.upper.thresh[nogs.min2.upper.thresh>0] <- 1

nogs.min2.lower.thresh[upper.tri(nogs.min2.lower.thresh,diag=T)] <- NA
nogs.min2.lower.thresh[nogs.min2.lower.thresh>5] <- 6

dual.heatmap(nogs.min2.upper.thresh, nogs.min2.lower.thresh, lowerRampCols=7,label.colors=base.cols2$oc[rownames(nogs.min2.counts),],main="Dual Network - No Global Signal (Min. 2)",png=T,dir="../Pictures/DualNetworkVis/",filename="DualNet_NoGS_Min2.png")


## Now remove the global signal (MCU movies) and require minimum of 2 connections; but re-ordered for this particular set up.
nogs.min2.counts_re <- movie.mats.nogs_min2$counts
nogs.min2.rowInd <- order.dendrogram(as.dendrogram(hclust(as.dist(movie.mats.nogs_min2$dissimilar),method="ward.D2")))
nogs.min2.counts_re <- nogs.min2.counts_re[nogs.min2.rowInd,nogs.min2.rowInd]
nogs.min2.upper.thresh_re <- nogs.min2.lower.thresh_re <- nogs.min2.counts_re

nogs.min2.upper.thresh_re[lower.tri(nogs.min2.upper.thresh_re,diag=F)] <- NA
nogs.min2.upper.thresh_re[nogs.min2.upper.thresh_re>0] <- 1

nogs.min2.lower.thresh_re[upper.tri(nogs.min2.lower.thresh_re,diag=T)] <- NA
nogs.min2.lower.thresh_re[nogs.min2.lower.thresh_re>5] <- 6

dual.heatmap(nogs.min2.upper.thresh_re, nogs.min2.lower.thresh_re, lowerRampCols=7,label.colors=base.cols2$oc[rownames(nogs.min2.counts_re),],main="Dual Network - No Global Signal (Min. 2)",png=T,dir="../Pictures/DualNetworkVis/",filename="DualNet_NoGS_Min2_reorder.png", label.size=.5/log10(nrow(nogs.min2.upper.thresh_re)))


