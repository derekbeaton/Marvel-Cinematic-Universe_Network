scrape.MoviesFromActors <- function(url.list){
	
	actor.list <- vector("list",length(url.list))
	all.names <- c()
	for(i in 1:length(url.list)){
		actor <- read_html(url.list[i])
		acted <- html_nodes(actor,"#filmography")
		
		#all.links <- acted %>% html_nodes(acted,"a")
		all.links <- html_nodes(acted,"a")
		#convert.from.xml <- capture.output(unlist(all.links))
		convert.from.xml <- html_attr(all.links,"href") # html_text(all.links)
		movie.links.and.titles <- convert.from.xml[grep("/title/", convert.from.xml)]
		movies.links.titles.only.acted <- movie.links.and.titles[grep("_act_", movie.links.and.titles)]
			###this has all the information for movies and titles, I just need more about the movies themselves.
		
# 		movie.urls <- unlist(lapply(movies.links.titles.only.acted,function(x){ 
# 													lvl1 <- unlist(strsplit(x,"\\\"") )
# 													movie.link <- unlist(strsplit(lvl1[2],"\\?"))[1]
# 														}))
    movie.urls <- unlist(strsplit(movies.links.titles.only.acted,'\\\\'))
		##a blast through the proper titles
		movie.titles <- vector("character",length=length(movie.urls))
		droppers <- c()
		for(j in 1:length(movie.urls)){
			this.movie <- read_html( paste0("http://www.imdb.com",movie.urls[j]) )
			temp.title <- unlist(strsplit(html_text(html_nodes(this.movie,"title"))," -"))[1]
			if( length(grep("video.movie",capture.output(html_nodes(this.movie,"meta")))) == 0){
				#movie.titles <- c(movie.titles,paste0("DROP::",temp.title))
				droppers <- c(droppers, j)
			}else{
				movie.titles[j] <- temp.title
			}
		}
		actor.name <- html_text(html_nodes(actor,"span.itemprop")[[1]])
		print(actor.name)
		all.names <- c(all.names,actor.name)
		if(length(droppers) > 0){
			actor.list[[i]] <- cbind(movie.titles[-c(droppers)],movie.urls[-c(droppers)])
		}else{
			actor.list[[i]] <- cbind(movie.titles,movie.urls)
		}
	}
	
	names(actor.list) <- all.names
	return(actor.list)
	
}