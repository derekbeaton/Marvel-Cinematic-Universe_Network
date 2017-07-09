scrape.ActorsFromMovies <- function(fullcredits.url.list){

###While this could work -- I'd rather parse the fullcredits list and break it into two:
	###everything above and below "Rest of cast list ..."
	
	full.movie.list <- top.movie.list <- top.final <- vector("list",length(fullcredits.url.list))
	full.all.titles <- c()
	
	#full.credit.movies <- paste(url.list,"fullcredits/",sep="")
	
	for(i in 1:length(fullcredits.url.list)){

		full.movie <- html(fullcredits.url.list[i])
		full.cast <- html_nodes(full.movie,"#fullcredits_content span.itemprop")
		full.cast.list <- html_text(full.cast)

		movie.frames <- html_table(full.movie)
		all.cast <- movie.frames[[3]]
		all.cast.split <- grep("alphabetically",all.cast[,1])
		#top.cast <- as.matrix(all.cast[2:(all.cast.split-1),c(2,4)]) ##this also has their role.
		if( length(all.cast.split) == 0 ){
			end.length <- nrow(all.cast)
		}else{
			end.length <- all.cast.split-1
		}
		top.cast <- as.matrix(all.cast[(2:end.length),c(2,4)]) ##this also has their role.
		colnames(top.cast) <- c('Actor/Actress','Role')
		
		urls <- html_nodes(full.movie,"#fullcredits_content td.itemprop")
		cast.urls <- xml_attr(urls %>% html_nodes("a"),"href")
		cast.urls <- unlist(lapply(strsplit(cast.urls,"\\?"),function(x){x[1]}))


	###I CAN FIX THE TITLE EASILY.
		#title.block <- html_nodes(full.movie,"div.subpage_title_block")
		#title <- html_text((title.block %>% html_nodes("a"))[[2]])
		title2 <- unlist(strsplit(html_text(html_nodes(full.movie,"title"))," -"))[1]
		#print(title)
		print(title2)
		
		full.all.titles <- c(full.all.titles,title2)
		full.movie.list[[i]] <- cbind(full.cast.list,cast.urls)
		top.movie.list[[i]] <- top.cast

		top.final[[i]] <- cbind(full.movie.list[[i]][1:(end.length-1),],top.cast[,'Role'])
		top.final[[i]] <- gsub("  ","",top.final[[i]])
		top.final[[i]] <- gsub("\\n","",top.final[[i]])
		colnames(top.final[[i]]) <- c('Actor/Actress','Link','Role')
		
	}
	names(top.movie.list) <- names(full.movie.list) <- names(top.final) <- full.all.titles
	
	return(list(full=full.movie.list,top=top.movie.list,tf=top.final))
}