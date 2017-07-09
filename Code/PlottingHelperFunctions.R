populate.matrix <- function(small.mat,bigger.mat){
	
	if( (nrow(small.mat) != ncol(small.mat)) | (nrow(bigger.mat) != ncol(bigger.mat)) ){
		stop("Matrices are not square")
	}
	if( nrow(small.mat) >= nrow(bigger.mat) ){
		stop("small.mat is bigger than bigger.mat")
	}
	if( all( rownames(small.mat) %in% rownames(bigger.mat) ) ){
		stop("small.mat is not a subset of bigger.mat")
	}
	
	empty.mat <- matrix(0,nrow(bigger.mat),ncol(bigger.mat))
	rownames(empty.mat) <- colnames(empty.mat) <- rownames(bigger.mat)
	empty.mat[rownames(small.mat),colnames(small.mat)] <- small.mat

	return(empty.mat)
	
}

## need to point out where I got this
add.alpha <- function(col, alpha = .4){
 apply(sapply(col, col2rgb)/255, 2, function(x) rgb(x[1], x[2], x[3], alpha = alpha))
}

## need to point out where I got this -- check coffee analysis
# shadowtext <- function(x, y=NULL, labels, col='white', bg='white', 
                       # theta= seq(0, 2*pi, length.out=300), r=0.0075, ... ) {

    # xy <- xy.coords(x,y)
    # xo <- r*strwidth('A')
    # yo <- r*strheight('A')

    # # draw background text with small shift in x and y in background colour
    # for (i in theta) {
        # text( xy$x + cos(i)*xo, xy$y + sin(i)*yo, labels, col=bg, ... )
    # }
    # # draw actual text in exact xy position in foreground colour
    # text(xy$x, xy$y, labels, col=col, ... )
# } 


##stolen https://github.com/cran/TeachingDemos/blob/master/R/shadowtext.R
shadowtext <- function(x, y=NULL, labels, col='white', bg='black', theta= seq(pi/4, 2*pi, length.out=16), r=0.1, pos=3, ... ) {
	xy <- xy.coords(x,y)
	xo <- r*strwidth('A')
	yo <- r*strheight('A')
	for (i in theta) {
		text( xy$x + cos(i)*xo, xy$y + sin(i)*yo, labels, col=bg, pos=pos, ... )
	}
	text(xy$x, xy$y, labels, col=col, pos=pos, ... ) 
}


my.heatmap <- function(viz.mat,clust.mat,heatramp=colorRampPalette(c("palegreen1","mediumorchid")),heatramp_colors=2,colors.list,main="",png=F,dir="./",filename="my_heatmap.png",width=12000,height=12000,pointsize=300){
	
	if(png){
		png(paste0(dir,filename),width=width,height=height,pointsize=pointsize)
	}
	
	heatmap.2(
		viz.mat,
		Rowv=as.dendrogram(hclust(as.dist(clust.mat),method="ward.D2")),
		trace="none",
		dendrogram="none",
		density.info="none",
		col=heatramp(heatramp_colors),
		scale="none",
		key=T,
		labCol=F,
		colRow=c(colors.list[rownames(viz.mat),]),
		cexRow=0.175/log10(nrow(clust.mat)),
		margins=c(2,2),
		main=main,
		symm=T
	)	
	
	if(png){
		dev.off()
	}
	
}

dual.heatmap <- 
function(upper.data,lower.data,
	upperRamp=colorRampPalette(c("palegreen1","mediumorchid")),upperRampCols=2,lowerRamp=colorRampPalette(c("white","black")),lowerRampCols=2,label.colors="black",label.sizes=0.175/log10(nrow(upper.data)),xlab="",ylab="",main="",png=F,dir="./",filename="my_heatmap.png",width=12000,height=12000,pointsize=300){
	
	if(png){
		png(paste0(dir,filename),width=width,height=height,pointsize=pointsize)
	}
	
	image(x=1:nrow(upper.data),y=1:ncol(upper.data),z= upper.data,axes=F,col= upperRamp(upperRampCols),xlab=xlab,ylab=ylab,main=main)
	image(x=1:nrow(lower.data),y=1:ncol(lower.data),z= lower.data,add=T,col= lowerRamp(lowerRampCols))
	ypos <- axis(4, at=1:nrow(upper.data), labels = rep("", nrow(upper.data)), las = 2, line = -0.5, tick = 0)
	text(x = par("usr")[2] + (1 + .5) * strwidth("M"), y = ypos, labels=rownames(upper.data), cex = label.sizes, col= label.colors,xpd=T)
	
	
	if(png){
		dev.off()
	}
	
}




thisPlotter <- function(res,appears,cols,xa=1,ya=2,dn=T,file="",leg.pos="topleft"){


	dots.file <- paste0(file,"_dots.png")
	names.file <- paste0(file,"_names.png")	

	if(!dn){
		
		png(dots.file,width=1000,height=1000,pointsize=48)
		prettyPlot(res$ExPosition.Data$fi,display_names=F,col=cols$oc[rownames(res$ExPosition.Data$fi),],cex= appears/2,axes=F,pch=20,x_axis=xa,y_axis=ya,dev.new=F)
		legend(leg.pos,legend=rownames(cols$gc),col= cols,pch=20,cex=.75,pt.cex=2,text.col=cols$gc)
		dev.off()

		png(names.file,width=1000,height=1000,pointsize=48)		
		prettyPlot(res$ExPosition.Data$fi,display_names=T,display_points=F,col=cols$oc[rownames(res$ExPosition.Data$fi),],text.cex=(appears/2)/2,axes=F,x_axis=xa,y_axis=ya)
		legend(leg.pos,legend=rownames(cols$gc),col=cols$gc,pch=20,cex=.75,pt.cex=2,text.col=base.cols2$gc)
		dev.off()
		
	}else{
		
		prettyPlot(res$ExPosition.Data$fi,display_names=F,col=cols$oc[rownames(res$ExPosition.Data$fi),],cex= appears/2,axes=F,pch=20,x_axis=xa,y_axis=ya)
		legend(leg.pos,legend=rownames(cols$gc),col= cols$gc,pch=20,cex=.5,pt.cex=1.1,text.col=cols$gc,bty="n")

		
		
		#prettyPlot(res$ExPosition.Data$fi,display_names=T,display_points=F,"white",axes=F,x_axis=xa,y_axis=ya)
		prettyPlot(res$ExPosition.Data$fi,display_names=T,display_points=F,col=cols$oc[rownames(res$ExPosition.Data$fi),],text.cex=(appears/2)/2,axes=F,x_axis=xa,y_axis=ya)
		#shadowtext(res$ExPosition.Data$fi[,xa],res$ExPosition.Data$fi[,ya], col = cols$oc[rownames(res$ExPosition.Data$fi),],labels = rownames(res$ExPosition.Data$fi), cex = ((appears[rownames(res$ExPosition.Data$fi)])/2)*.1, pos = 3, offset = 0.1)
		
		legend(leg.pos,legend=rownames(cols$gc),col= cols$gc,pch=20,cex=.5,pt.cex=1.1,text.col=cols$gc,bty="n")

	}
}

