##now clean -- I should have functions here that work based on percentanges.
	## make those functions now

actorDrop <- function(movie.mat.in, actor.thresh.drop=1){
	## default percentage is 1 / nrow(movie.mat.in)
	
	droppers <- which( rowSums(movie.mat.in) <= actor.thresh.drop)

	if(length(droppers) == 0){
		return(movie.mat.in)
	}else{
		return(movie.mat.in[-c(droppers), ])
	}
}

movieDrop <- function(movie.mat.in, movie.thresh.drop=0){
	## default percentage is 1 / ncol(movie.mat.in)
		
	droppers <- which( colSums(movie.mat.in) <= movie.thresh.drop)
	
	if(length(droppers) == 0){
		return(movie.mat.in)
	}else{
		return(movie.mat.in[, -c(droppers) ])
	}
}


actor.and.movie.Drop <- function(movie.mat.in,actor.thresh.drop=1,movie.thresh.drop=0,max.iters=10){
	
	counter <- 1
	keepLooping <- T
	
	while(keepLooping){
		movie.mat.in <- actorDrop(movie.mat.in, actor.thresh.drop)
		movie.mat.in <- movieDrop(movie.mat.in, movie.thresh.drop)
		
		
		print( paste0("Iter: ", counter) )
		counter <- counter + 1	
		
		## check thresholds
		if( 
			length(which( rowSums(movie.mat.in) <= actor.thresh.drop))==0 & 
			length(which( colSums(movie.mat.in) <= movie.thresh.drop))==0 
		){
			print('Missingness acceptable: Stopping.')
			keepLooping <- F
		}
		if(counter >= max.iters){
			print('Maximum iterations: Stopping')
			keepLooping <- F
		}		
		
	}
	
	return(movie.mat.in)
	
}


##can use a thresholding here to clean the matrix mmt
makeDifferentMats <- function(mat.in,min.connects=0){	
	
	mmt <- mat.in %*% t(mat.in)
	
	####This block finds low connectivity -- but I require the diagonal to be empty.
		mmt.lowCon <- mmt
		diag(mmt.lowCon) <- rep(0,length(diag(mmt.lowCon)))
		mmt.lowCon[mmt.lowCon <= min.connects] <- 0
		
		##clean it up now -- no no; this needs to be based on removing the diagonal value...
		drop.em <- which(rowSums(mmt.lowCon)==0 | colSums(mmt.lowCon)==0)
		if(length(drop.em)!=0){
			mmt <- mmt[-c(drop.em),-c(drop.em)]
		}
		rm(mmt.lowCon)
	####Low connectivity dropped from mmt
	
	####Make count version with 0s on diagonal (this is a weighted network)
		mmt_zero.diag <- mmt
		diag(mmt_zero.diag) <- rep(0,length(diag(mmt_zero.diag)))
	####	

	####Make thresholded version (and then two derivatives)
		mmt.thresh <- mmt
		mmt.thresh[mmt.thresh!=0] <- 1
	####
	####Make thresholded version with zeros on the diagonal
		mmt.thresh_zero.diag <- mmt.thresh
		diag(mmt.thresh_zero.diag) <- rep(0,length(diag(mmt.thresh_zero.diag)))
	####	
	####Loaded diag version for CA -- start with thresholded, then load diag with colSums
		mmt.thresh_repdiag <- mmt.thresh_zero.diag
		diag(mmt.thresh_repdiag) <- colSums(mmt.thresh_repdiag)
	####
		
	####Dissimilarity from threshold
		mmt.thresh_dis <- abs(1-mmt.thresh)
	####


	return(list(counts=mmt, counts_zero.diag= mmt_zero.diag, thresh=mmt.thresh, thresh_zero.diag= mmt.thresh_zero.diag, thresh_load_diag=mmt.thresh_repdiag, dissimilar=mmt.thresh_dis))
}

