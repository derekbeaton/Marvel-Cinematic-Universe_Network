piecewise_get.all.movies.from.actors <- function(unrolled.actors.in,file.loc="./",external.start=1,external.end=NA,chunks=10){


	split.lists <- split(1:nrow(unrolled.actors.in), ceiling(1:nrow(unrolled.actors.in) / chunks))
	#movies.from.actor.super <- vector("list", length(split.lists))	

	if(is.na(external.end) | external.end < external.start){
		external.end <- length(split.lists)
	}

	for(i in external.start:external.end){			
	
		this.vector <- split.lists[[i]]
		start <- this.vector[1]
		end <- this.vector[length(this.vector)]
			
		print(paste(' ACTOR SUPER LIST: GO ',i))
		movies.from.actor.super <- scrape.MoviesFromActors(paste0("http://www.imdb.com", unrolled.actors.in[start:end,2]))
		print(paste(' ACTOR SUPER LIST: SAVING OUT ',i))
		namez <- paste0(file.loc,'/superlist_',i,'.rda')
		save(movies.from.actor.super,file=namez)
		gc()
		
	}
	

}