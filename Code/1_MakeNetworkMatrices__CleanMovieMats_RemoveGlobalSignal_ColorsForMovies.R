rm(list=ls())
gc()

library(ExPosition)
library(gplots)

load('../Data/MovieMat/movie.mat.rda')
load('../Data/MovieMat/movie.title.link.map.rda')
source('MatrixCleaners.R')

movies.to.drop <- c("tt4154756","tt5095030","tt4154664","tt4154796")
movie.mat <- movie.mat[, -c( which(colnames(movie.mat) %in% movies.to.drop) ) ]

## drop actors with only 1 movie, and all movies with 0 actors.
movie.mat.clean <- actor.and.movie.Drop(movie.mat,actor.thresh.drop=1,movie.thresh.drop=0)
movie.mats <- makeDifferentMats(movie.mat.clean)
movie.mats_min1 <- makeDifferentMats(movie.mat.clean,1)
movie.mats_min2 <- makeDifferentMats(movie.mat.clean,2)



#### Now the removal of the "global signal" a.k.a. Marvel Movies
## global signal needs to be in temporal order for convenience
global.signal <- c("tt0371746","tt0800080","tt1228705","tt0800369","tt0458339","tt0848228","tt1300854","tt1981115","tt1843866","tt2015381","tt2395427","tt0478970","tt3498820","tt1211837","tt3896198","tt2250912","tt3501632","tt1825683")

movie.mat.nogs <- movie.mat[, -c( which(colnames(movie.mat) %in% global.signal) ) ]
movie.mat.nogs.clean <- actor.and.movie.Drop(movie.mat.nogs,actor.thresh.drop=1,movie.thresh.drop=0)
movie.mats.nogs <- makeDifferentMats(movie.mat.nogs.clean)
movie.mats.nogs_min1 <- makeDifferentMats(movie.mat.nogs.clean,1)
movie.mats.nogs_min2 <- makeDifferentMats(movie.mat.nogs.clean,2)


#####now make colors...
movie.des <- cbind(cbind(movie.mat[, global.signal],0),0)
	## Brie Larson will need her own color like Stan Lee.
colnames(movie.des)[c((ncol(movie.des)-1),ncol(movie.des))] <- c("tt4154664","Stan Lee")
movie.des["Brie Larson","tt4154664"] <- 1
movie.des["Stan Lee",] <- 0
movie.des["Stan Lee","Stan Lee"] <- 1

for.des <- unique.movies[which(unique.movies[,2] %in% colnames(movie.des)),]
rownames(for.des) <- for.des[,2]

movie.des_first.appear <- movie.des 
appearances <- rowSums(movie.des_first.appear)

for(i in 1:(ncol(movie.des_first.appear)-1) ){
	these.ones <- which(movie.des_first.appear[,i]==1)
	movie.des_first.appear[these.ones, ((i+1):ncol(movie.des_first.appear)) ] <- 0
}
for.des <- for.des[colnames(movie.des_first.appear)[1:19],]

colnames(movie.des_first.appear) <- c(for.des[colnames(movie.des_first.appear)[1:19],1],"Stan Lee")
base.cols2 <- base.cols <- createColorVectorsByDesign(movie.des_first.appear)

## Stan Lee = slategray4
## CONDITIONAL COLORING: try to match the character OR the color of the infinity stone OR the bad guy

	## SUIT / MOVIE COLORS
## Iron Men: firebricks
	## firebrick1, red, indianred4
## CAs: dodgerblues
	## dodgerblue1, dodgerblue3, steelblue4
## Hulk = Green
	## darkgreen
## Thors = Greys
	## grey30, grey50, grey70
	
## Black Panther = Black
	## black
## Captain Marvel = Goldenrod?
	## goldenrod1

	## BAD GUY
## Ant-Man = Yellow (Yellow Jacket)
	## yellow2
## Spiderman = Dark Green?
	## seagreen3

	## INFINITY STONES
## Avengers = Light blue; Avengers 2 = Dark yellow
	## skyblue1,  gold1
## GotG = Purple (power stone); GotG2 = another purple (their names are in purple)
	## darkorchid3, darkorchid1
## Doctor Strange = Some type of green
	## chartreuse3
	
	
base.cols2$gc[,1] <- c("firebrick1","darkgreen","red","grey30","dodgerblue1","skyblue1","indianred4","grey50","dodgerblue3","darkorchid3","gold1","yellow2","steelblue4","chartreuse3","darkorchid1","seagreen3","grey70","black","goldenrod1","slategray4")

for(i in 1:nrow(base.cols2$gc)){
	base.cols2$oc[ which( base.cols$oc[,1] %in% base.cols$gc[i,1]), 1] <- base.cols2$gc[i,1]
}

## things to save out for analyses:
save(base.cols2,file='../Data/ForAnalyses/base.cols2.rda')
save(movie.mats.nogs_min2,file='../Data/ForAnalyses/movie.mats.nogs_min2.rda')
save(movie.mats.nogs_min1,file='../Data/ForAnalyses/movie.mats.nogs_min1.rda')
save(movie.mats.nogs,file='../Data/ForAnalyses/movie.mats.nogs.rda')
save(global.signal,file='../Data/ForAnalyses/global.signal.rda')
save(movie.mats_min2,file='../Data/ForAnalyses/movie.mats_min2.rda')
save(movie.mats_min1,file='../Data/ForAnalyses/movie.mats_min1.rda')
save(movie.mats,file='../Data/ForAnalyses/movie.mats.rda')
save(unique.movies,file='../Data/ForAnalyses/unique.movies.rda') 	## redundant but useful for later.
save(appearances,file='../Data/ForAnalyses/appearances.rda')
save(movie.mat,file='../Data/ForAnalyses/new.movie.mat.rda')
save(movie.mat.nogs,file='../Data/ForAnalyses/new.movie.mat.nogs.rda')
