rm(list=ls())
gc()

load('../Data/ActorMovieLists/COMPLETE_movies.from.actor.super.rda')
load('../Data/ActorMovieLists/POSTPROD_movies.from.actor.super.rda')
load('../Data/ActorMovieLists/PREPROD_movies.from.actor.super.rda')

unravel <- function(movies.from.actor.super){
	unraveled.super <- unlist(movies.from.actor.super,recursive=F)
	for(i in 1:length(unraveled.super)){
		this.spot <- which(unraveled.super[[i]][,1]=="Iron Man 3 (2013)")
		if(length(this.spot) != 0){
			unraveled.super[[i]][this.spot,1] <- "Iron Man Three (2013)"
		}
	}
	#lapply(unraveled.super,function(x){  x[,2] <- unlist(lapply(strsplit(x[,2],"\\?"),function(y){y[1]}))   })
	unraveled.super2 <- unraveled.super
	for(i in 1:length(unraveled.super)){
	
		first.part <- unlist(lapply(strsplit(unraveled.super2[[i]][,2],"\\?"),function(y){y[1]}))
		second.part <- unlist(lapply(strsplit(first.part,"title/"),function(y){y[2]}))
		unraveled.super2[[i]][,2] <- gsub("/","",second.part)
		
	}
	
	unroll.movies <- do.call(rbind, unraveled.super2)
	return(list(unraveled=unraveled.super2 ,unroll.movies=unroll.movies))
}


COMPLETE_res <- unravel(COMPLETE_movies.from.actor.super)
POSTPROD_res <- unravel(POSTPROD_movies.from.actor.super)
PREPROD_res <- unravel(PREPROD_movies.from.actor.super)

all.actors <- unique(c(names(COMPLETE_res$unraveled),names(POSTPROD_res$unraveled),names(PREPROD_res$unraveled)))
unique.movies <- unique(rbind(COMPLETE_res$unroll.movies, POSTPROD_res$unroll.movies, PREPROD_res$unroll.movies))


movie.mat <- matrix(0,length(all.actors),nrow(unique.movies))
rownames(movie.mat) <- all.actors
colnames(movie.mat) <- unique.movies[,2]

	# ###more fixing required here.
# for(i in 1:nrow(movie.mat)){

	# ###titles are an issue... so there needs to be a check here for the link.	
	# movie.mat[i, COMPLETE_res$unraveled[[which(rownames(movie.mat)[i]==rownames(movie.mat))]][,2]] <- 1
	# movie.mat[i, POSTPROD_res$unraveled[[which(rownames(movie.mat)[i]==rownames(movie.mat))]][,2]] <- 1
	# movie.mat[i, PREPROD_res$unraveled[[which(rownames(movie.mat)[i]==rownames(movie.mat))]][,2]] <- 1
	
# }


for(i in 1:length(COMPLETE_res$unraveled)){
	this.actor <- COMPLETE_res$unraveled[[i]]
	for(j in 1:nrow(this.actor)){
	
		movie.mat[names(COMPLETE_res$unraveled)[i],this.actor[j,2]] <- 1
		
	}
}

for(i in 1:length(POSTPROD_res$unraveled)){
	this.actor <- POSTPROD_res$unraveled[[i]]
	for(j in 1:nrow(this.actor)){
	
		movie.mat[names(POSTPROD_res$unraveled)[i],this.actor[j,2]] <- 1
		
	}
}

for(i in 1:length(PREPROD_res$unraveled)){
	this.actor <- PREPROD_res$unraveled[[i]]
	for(j in 1:nrow(this.actor)){
	
		movie.mat[names(PREPROD_res$unraveled)[i],this.actor[j,2]] <- 1
		
	}
}


save(movie.mat,file='../Data/MovieMat/movie.mat.rda')
save(unique.movies,file='../Data/MovieMat/movie.title.link.map.rda')

