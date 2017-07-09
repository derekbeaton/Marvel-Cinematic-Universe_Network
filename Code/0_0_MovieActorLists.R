rm(list=ls())
library(rvest)
library(ExPosition)

source('actor.scrape_better.R')
source('unroll.actor.list.R')


completed.mcu.movies <- c(
				 "http://www.imdb.com/title/tt0371746/fullcredits", #iron man
				 "http://www.imdb.com/title/tt0800080/fullcredits", #Hulk
				 "http://www.imdb.com/title/tt0800369/fullcredits", #Thor
				 "http://www.imdb.com/title/tt0458339/fullcredits", #CA: TFA
				 "http://www.imdb.com/title/tt1228705/fullcredits", #iron man 2
				 "http://www.imdb.com/title/tt0848228/fullcredits", #avengers
				 "http://www.imdb.com/title/tt1300854/fullcredits", #iron man 3
				 "http://www.imdb.com/title/tt1981115/fullcredits", #thor 2
				 "http://www.imdb.com/title/tt1843866/fullcredits", #CA:TWS
				 "http://www.imdb.com/title/tt2015381/fullcredits", #GOTG
				 "http://www.imdb.com/title/tt2395427/fullcredits", #A:AoU
				 "http://www.imdb.com/title/tt0478970/fullcredits", #Celeryman.
				 "http://www.imdb.com/title/tt3498820/fullcredits", #CA:CW
				 "http://www.imdb.com/title/tt1211837/fullcredits"  #Doctor Strange
				)
complete.actor.list <- scrape.ActorsFromMovies(completed.mcu.movies)
complete.actors.unrolled <- unroll.actor.list(complete.actor.list)


post.prod.mcu.movies <- c(
				"http://www.imdb.com/title/tt3896198/fullcredits",	# GotG:Vol2
				"http://www.imdb.com/title/tt2250912/fullcredits",	# Spiderman: Homecoming
				"http://www.imdb.com/title/tt3501632/fullcredits"	# Thor: Ragnarok
				)
postprod.actor.list <- scrape.ActorsFromMovies(post.prod.mcu.movies)
postprod.actors.unrolled <- unroll.actor.list(postprod.actor.list)



# preprod.mcu.movies <- c(
				# "http://www.imdb.com/title/tt1825683/fullcredits",	# Black Panther
				# "http://www.imdb.com/title/tt4154756/fullcredits",	# Avengers: Infinity War
				# "http://www.imdb.com/title/tt5095030/fullcredits",	# Ant-Man and The Wasp
				# "http://www.imdb.com/title/tt4154664/fullcredits"	# Captain Marvel
				# )
# preprod.actor.list <- scrape.ActorsFromMovies(preprod.mcu.movies)
# preprod.actors.unrolled <- unroll.actor.list(preprod.actor.list)

## do not include these, only wanted for some new actors.

## I will only grab from BP and then add Brie Larson in later with other actors...
preprod.mcu.movies <- c(
				"http://www.imdb.com/title/tt1825683/fullcredits"#,	# Black Panther
#				"http://www.imdb.com/title/tt4154664/fullcredits"	# Captain Marvel
				)
preprod.actor.list <- scrape.ActorsFromMovies(preprod.mcu.movies)
preprod.actors.unrolled <- unroll.actor.list(preprod.actor.list)

	##make a small edit to preprod to include Brie Larson
brie.larson <- cbind("Brie Larson","/name/nm0488953/",NA)
rownames(brie.larson) <- "Brie Larson"	
preprod.actors.unrolled	<- rbind(preprod.actors.unrolled, cbind(brie.larson))
	
	
	##make a Netflix & Wire actor list separately.
	##cbind NA to everyone here.	
unrolled.netflix.actors <- rbind(
							cbind("Simone Missick","/name/nm1395855/"),
							cbind("Theo Rossi","/name/nm0744331/"),
							cbind("Alfre Woodard","/name/nm0005569/"),
							cbind("Jaiden Kaine","/name/nm4005031/"),
							cbind("Erik LaRay Harvey","/name/nm0367510/"),
							cbind("Mahershala Ali","/name/nm0991810/"),
							cbind("Frank Whaley","/name/nm0001844/"),
							cbind("Parisa Fitz-Henley","/name/nm1406792/"),
							cbind("Krysten Ritter","/name/nm1269983/"),
							cbind("Rachael Taylor","/name/nm1592225/"),
							cbind("Eka Darville","/name/nm2794212/"),
							cbind("David Tennant","/name/nm0855039/"),
							cbind("Wil Traval","/name/nm1505157/"),
							cbind("Mike Colter","/name/nm1591496/"),
							cbind("Michelle Hurd","/name/nm0403335/"),
							cbind("Charlie Cox","/name/nm1214435/"),
							cbind("Deborah Ann Woll","/name/nm2832695/"),
							cbind("Elden Henson","/name/nm0711805/"),
							cbind("Vincent D'Onofrio","/name/nm0000352/"),
							cbind("Jon Bernthal","/name/nm1256532/"),
							cbind("Elodie Yung","/name/nm1392388/"),
							cbind("Royce Johnson","/name/nm1912642/"),
							cbind("Rosario Dawson","/name/nm0206257/"),
							cbind("Geoffrey Cantor","/name/nm0134666/"),
							cbind("Vondie Curtis-Hall","/name/nm0193554/"),
							cbind("Scott Glenn","/name/nm0001277/"),
							cbind("Matt Gerald","/name/nm0313902/"),
							cbind("Carrie-Anne Moss","/name/nm0005251/"),
							cbind("Jessica Henwick","/name/nm3725055/"),
							cbind("Finn Jones","/name/nm3645691/")
						)
						
unrolled.netflix.actors <- cbind(unrolled.netflix.actors,NA)
rownames(unrolled.netflix.actors) <- unrolled.netflix.actors[,1]

	## selected Wire actors...
unrolled.wire.actors <- rbind(
							cbind("Dominic West","/name/nm0922035/"),
							cbind("John Doman","/name/nm0231283/"),
							cbind("Diedre Lovejoy","/name/nm0522479/"),
							cbind("Wendell Pierce","/name/nm0682495/"),
							cbind("Lance Reddick","/name/nm0714698/"),
							cbind("Sonja Sohn","/name/nm0812308/"),
							cbind("Seth Gilliam","/name/nm0319121/"),
							cbind("Domenick Lombardozzi","/name/nm0518511/"),
							cbind("Clarke Peters","/name/nm0676370/"),
							cbind("Andre Royo","/name/nm0747420/"),
							cbind("Michael Kenneth Williams","/name/nm0931324/"),
							cbind("Jim True-Frost","/name/nm0874082/"),
							cbind("Frankie Faison","/name/nm0265670/"),
							cbind("Wood Harris","/name/nm0365445/"),
							cbind("Idris Elba","/name/nm0252961/"),
							cbind("Aiden Gillen","/name/nm0318821/"),
							cbind("Robert Wisdom","/name/nm0936298/"),
							cbind("Method Man","/name/nm0541218/"), 		## in Luke Cage & The Wire
							cbind("Michael B. Jordan","name/nm0430107/")
						)						
						
unrolled.wire.actors <- cbind(unrolled.wire.actors,NA)
rownames(unrolled.wire.actors) <- unrolled.wire.actors[,1]							
							
colnames(unrolled.wire.actors) <- colnames(unrolled.netflix.actors) <- c("Actor/Actress","Link","occurences")


save.image('../Data/PART1.RData')

