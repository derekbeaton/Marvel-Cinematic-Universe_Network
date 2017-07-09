unroll.actor.list <- function(actor.by.movie.list){

	####this is unrolled from the actor list.
	unroll.actors <- do.call(rbind, actor.by.movie.list$tf)
	
		##DO A RANKING VIA FREQ
	freqs <- table(unroll.actors[,1])
	unroll.actors.clean <- unroll.actors[which( !(duplicated(unroll.actors[,1])) ),]
	rownames(unroll.actors.clean) <- unroll.actors.clean[,1]
	unroll.actors.final <- cbind(unroll.actors.clean,freqs[rownames(unroll.actors.clean)])
	colnames(unroll.actors.final)[4] <- 'occurences'
	unroll.actors.final <- unroll.actors.final[order(unroll.actors.final[,4],decreasing=T),c(1,2,4)] ####role is not important, here.

}