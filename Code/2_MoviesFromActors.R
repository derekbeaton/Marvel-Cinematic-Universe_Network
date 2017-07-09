##this is to just load in whatever "superlist" files I want, and then build a matrix from there.

	## DEFINITELY
#'../Data/ActorPartitions/Complete/'
#'../Data/ActorPartitions/Postprod/'

	## PROBABLY
#'../Data/ActorPartitions/Preprod/'

	## PROBABLY NOT FOR NOW?
#'../Data/ActorPartitions/Wire/'
#'../Data/ActorPartitions/Netflix/'

rm(list=ls())
gc()

complete.files <- list.files('../Data/ActorPartitions/Complete/')
COMPLETE_movies.from.actor.super <- vector("list",length(complete.files))
for(i in 1:length(complete.files)){
	load(paste0('../Data/ActorPartitions/Complete/', complete.files[i]))
	COMPLETE_movies.from.actor.super[[i]] <- movies.from.actor.super
}
save(COMPLETE_movies.from.actor.super,file='../Data/ActorMovieLists/COMPLETE_movies.from.actor.super.rda')
##now save

rm(list=ls())
gc()

postprod.files <- list.files('../Data/ActorPartitions/Postprod/')
POSTPROD_movies.from.actor.super <- vector("list",length(postprod.files))
for(i in 1:length(postprod.files)){
	load(paste0('../Data/ActorPartitions/Postprod/', postprod.files[i]))
	POSTPROD_movies.from.actor.super[[i]] <- outzo
}
save(POSTPROD_movies.from.actor.super,file='../Data/ActorMovieLists/POSTPROD_movies.from.actor.super.rda')
##now save

rm(list=ls())
gc()

preprod.files <- list.files('../Data/ActorPartitions/Preprod/')
PREPROD_movies.from.actor.super <- vector("list",length(preprod.files))
for(i in 1:length(preprod.files)){
	load(paste0('../Data/ActorPartitions/Preprod/', preprod.files[i]))
	PREPROD_movies.from.actor.super[[i]] <- outzo
}
save(PREPROD_movies.from.actor.super,file='../Data/ActorMovieLists/PREPROD_movies.from.actor.super.rda')
##now save

rm(list=ls())
gc()

netflix.files <- list.files('../Data/ActorPartitions/Netflix/')
NETFLIX_movies.from.actor.super <- vector("list",length(netflix.files))
for(i in 1:length(netflix.files)){
	load(paste0('../Data/ActorPartitions/Netflix/', netflix.files[i]))
	NETFLIX_movies.from.actor.super[[i]] <- outzo
}
save(NETFLIX_movies.from.actor.super,file='../Data/ActorMovieLists/NETFLIX_movies.from.actor.super.rda')
##now save

rm(list=ls())
gc()

wire.files <- list.files('../Data/ActorPartitions/Wire/')
WIRE_movies.from.actor.super <- vector("list",length(wire.files))
for(i in 1:length(wire.files)){
	load(paste0('../Data/ActorPartitions/Wire/', wire.files[i]))
	WIRE_movies.from.actor.super[[i]] <- movies.from.actor.super
}
save(WIRE_movies.from.actor.super,file='../Data/ActorMovieLists/WIRE_movies.from.actor.super.rda')
##now save



#tt1951266 - PART 2
#tt1951265 - PART 1