# A network visualization and analysis of the actors in the Marvel Cinematic Universe (movies only). 

This is just a very truncated—and very, very boring—version of a comprehensive set of network analyses of the actors in the Marvel Cinematic Universe (MCU) movies. I hope to have a far more detailed—and less boring—write up soon which will include more information on how I gathered the data, created the networks, the statistical analyses I performed, and finally a bunch of conjectures about the future of MCU.

A fair warning: If you haven't seen some of the MCU movies yet (especially Spider-man: Homecoming) then don't click the links as there could be spoilers. 

## Background

On August 6th, 2015 at 12:48am I was watching the movie [The Hurt Locker](http://www.imdb.com/title/tt0887912/). I only know the exact date and time because I wrote myself a fairly incoherent email with the subject "MCU stats" and in the body "Graph theory , ca, so many possible exsmples.". I had almost fallen asleep when I had noticed and then mumble-fully said to myself (which prompted my email): "Oh, that's [Alrdich Killian](http://marvelcinematicuniverse.wikia.com/wiki/Aldrich_Killian) and [Falcon](http://marvelcinematicuniverse.wikia.com/wiki/Falcon)." A few minutes later: "OH AND THAT'S [HAWKEYE](http://marvelcinematicuniverse.wikia.com/wiki/Hawkeye)!". Three actors in Marvel Cinematic Universe (MCU) all in The Hurt Locker seemed pretty neat to me (at the time it was only these three but it is now actually four: [Hope Van Dyne, a.k.a., The Wasp](http://marvelcinematicuniverse.wikia.com/wiki/Hope_van_Dyne)). And that is what prompted my incoherent email and the following idea: I must understand the network structure of the actors in the MCU.


The original data table of actors x movies for these visualizations and analyses can be found [here](./Data/MovieMat/movie.mat.rda) where network data can be found [here](./Data/ForAnalyses/).


## Quick data description

These data were generated from IMDB in late December 2016 through January 2017. I included all MCU movies including those (at the time) in pre-production (e.g., Black Panther), or where particular casting choices had already been made (e.g., Captain Marvel). I excluded the two forthcoming Avengers movies. The data set only includes actors from the MCU *movies* and all of their acting credits for movies, shorts, video games and such but not TV shows or episodes. 

There are 938 unique actors that have been in 12,000+ movies (and some other things like shorts, video games, etc.. but I excluded TV episodes and shows). After a bit of cleaning we are left with 779 actors from 10,000+ movies and such. If actors appear together in something they are connected. That connection gets stronger if they appear with each other in many things. 

## Dual network visualization. 

Actors were clustered via hierarchical clustering with Ward linkage of a 0/1 dissimilarity matrix. The clustering determined their grouping and order for the following two figures. In both, the upper triangle shows a simple connectedness: connected (have acted together) is purple and not connected (have not acted together) is green. The lower triangle shows the strength of connectedness: not connected is white where as if actors are more connected (i.e., acted more frequently together) the cell will be darker. 

![Full dual network image](./Pictures/DualNetworkVis/1a_DualNet.png)

This is a lot to take in but for the adventurous: download the figure and explore around a bit. Or for the not-so-adventurous I'll help you out. There's a funny little sub-network hiding in here. It helps show that someone at Marvel Studios is a huge fan of Thomas the Tank Engine. If this wasn't obvious by the [climactic battle in Ant-Man](https://www.youtube.com/watch?v=muYbXyYxd5E), then you can see in the network visualization three people with very very high connectedness (23-35 co-acting credits): [William Hope](http://www.imdb.com/name/nm0394054/), [Martin Sherman](http://www.imdb.com/name/nm1453396/), and [Michael Brandon](http://www.imdb.com/name/nm0104787/): all are in [Captain America: The First Avenger](http://www.imdb.com/title/tt0458339/fullcredits). We can see this Thomas the Tank Engine subnetwork a bit better in the next figure. 

The next figure was created from a different network structure. I removed the "global signal" -- i.e., all of the MCU movies were excluded, and the network recomputed. I also dropped any actors with less than 2 co-acting credits. That leaves us with only 104 individuals and the Thomas the Tank Engine subnetwork becomes a bit more apparent:

![No global signal/minimum 2 co-acting network image](./Pictures/DualNetworkVis/3b_DualNet_NoGS_Min2_reorder.png)

There's also another fascinating subnetwork: actors from The Lord of the Rings Trilogies (from Karl Urban at the bottom up to Richard Armitage). Note that Hugo Weaving—and to a lesser extent Andy Serkis—are critical central nodes that connect the Lord of the Rings trilogy to the Hobbit trilogy.


## Correspondence analysis as a network visualization tool

The network visualizations above are, in all honesty, fairly difficult to look at it and get much out of. So we need better tools to get better information from these data. I used correspondence analysis (CA; a cousin of principal components analysis designed specifically for categorical and count data). Below is a two-dimensional visualization of the actor x actor (779 x 779) matrix from CA. There are a few key features about CA we should keep in mind when looking at these figures (worth downloading so you can zoom in and explore the images, they're a bit big...):

* Actors near one another are more connected to one another than actors far away
* Actors far away from one another are typically not connected (i.e., no co-acting credits)
* Actors closer to the center (the origin) have many co-acting credits with many other actors throughout all of the MCU movies.
* Actors connected by a line are connected outside of the MCU (only applies in the second image)


In the first figure I show the first (horizontal) and second (vertical) components. These are the two components with the highest variance. 

![Network Visualization through CA](./Pictures/CA/2a_CA_12__NetworkConfig.png)


The first thing we can see is that the actors in The Incredible Hulk (left, green dots) are generally less connected to the rest of the MCU movies. This is to-be-expected as the story line and characters of The Incredible Hulk are typically ignored in the MCU. However, there are three notable exceptions from The Incredible Hulk that are closer to the rest of the actors: Martin Starr, William Hurt, and Lou Ferrigno. The last two are easy: (1) Lou Ferrigno is the voice of the Hulk, and (2) William Hurt's character returned in Civil War (General Ross appeared again as Secretary of State Ross). Martin Starr is a bit different though because he is one of the very, very few individuals to appear in the MCU as *two different characters*: [Amadeus Cho](http://marvelcinematicuniverse.wikia.com/wiki/Amadeus_Cho) in The Incredible Hulk and [Harrigton (a teacher)](http://marvelcinematicuniverse.wikia.com/wiki/Harrington) in Spider-man: Homecoming.

We can also see that actors in the same MCU movies tend to group together: all the red dots are various Iron Man actors, where blue dots are various Captain America actors. 

Finally with this first CA figure, if we zoom in to the center (where the axes meet) we can see Stan Lee hovering around the origin. While that is somewhat poetic, he makes an appearance in every MCU movie and is thus one of the most connected individuals we have. 


The next figure shows a different set of two components (7 and 8), which gave the best visualization to illustrate the grouping of actors by movie. Also in the following figure I included lines between actors but only for the 104 actors described above (i.e., they are connected by at least 2 co-acting credits *excluding* the MCU movies).

![Network Visualization through CA](./Pictures/CA/3b_CA_78__NoGS_Min2_Network.png)

In this figure we still see dots all over the place but generally grouped by the same color. We also only see some of the most connected individuals, e.g., John Favreau, Samuel L. Jackson, Kate Mara, Idris Elba, Judy Greer, Stanley Tucci, and Angela Bassett (who will appear in Black Panther). While there are many fascinating details here (that can be explained by a rich history of acting) there are two particular individuals I will focus on to conclude.

The first is probably not a house-hold name like the previously mentioned actors and is hiding amongst the green-ish dots associated with Spider-Man:Homecoming. Amongst all of those individuals is someone named [Elli](http://www.imdb.com/name/nm1380939/): a rabbi who typically plays a rabbi in a lot of movies and TV shows. Elli has shared acting credits with 89 of 779 individuals in the MCU through a variety of other movie appearances. 


The final—and most important—individual is hiding in plain sight. In the first CA figure we saw that Stan Lee was near the origin. He's there because he's been in every MCU movie. But in both CA figures we see someone else near the origin: [Brie Larson](http://www.imdb.com/name/nm0488953/) who has been cast as [Captain Marvel](http://www.imdb.com/title/tt4154664/). What makes Brie Larson's connectedness so interesting is that she has yet to appear in any MCU movies. That means she is already highly connected to the actors of the MCU (28 total). Unlike most other actors in the MCU though she is connected to many actors *across* many of the franchises. In fact, she has already appeared in movies with almost many of the primary characters in the first Avengers movie (through, e.g., Scott Pilgrim vs. The World, 13 Going on 30, Kong: Skull Island, and Don Jon) as well as actors from more recent MCU films (e.g., Tilda Swinton, John C. Reilly). Captain Marvel is regarded as [one of the most important upcoming MCU movies](http://nerdist.com/captain-marvel-is-the-mcus-most-powerful-hero-according-to-kevin-feige/). It seems that Brie Larson as Captain Marvel was probably a very elaborate and deliberate decision: she's an incredible actress that has already worked with many of the actors who play some of most important characters in the MCU. 




