# A network visualization and analysis of the actors in the Marvel Cinematic Universe (movies only). 

## Background

On August 6th, 2015 at 12:48am I was watching the movie The Hurt Locker. I only know the exact date and time because I wrote myself a fairly incoherent email with the subject "MCU stats" and in the body "Graph theory , ca, so many possible exsmples.". I had almost fallen asleep when I had noticed and then mumble-fully said to myself (which prompted my email): "Oh, that's [Alrdich Killian](http://marvelcinematicuniverse.wikia.com/wiki/Aldrich_Killian) and [Falcon](http://marvelcinematicuniverse.wikia.com/wiki/Falcon)." A few minutes later: "OH AND THAT'S [HAWKEYE](http://marvelcinematicuniverse.wikia.com/wiki/Hawkeye)!". Three actors in Marvel Cinematic Universe (MCU) all in The Hurt Locker seemed pretty neat (at the time it wasn't, but it is now actually four: [Hope Van Dyne, a.k.a., The Wasp](http://marvelcinematicuniverse.wikia.com/wiki/Hope_van_Dyne)). And that is what prompted my incoherent email and the following idea: I must understand the network structure of the actors in the MCU.


The original data table of actors x movies for these visualizations and analyses can be found [here](./Data/MovieMat/movie.mat.rda) where network data can be found [here](./Data/ForAnalyses/).


## The really short version. 

Of all the MCU *movie* (not TV) actors in all MCU movies from Iron Man 1 to Spider-man: Homecoming, there are 938 unique actors that have been in 12,000+ movies (and some other things like shorts, video games, etc.. but I excluded TV episodes and shows). After a bit of cleaning we are left with 779 actors from 10,000+ movies and such. If actors appear together in something they are connected. That connection gets stronger if they appear with each other in many things. 

### Dual network visualization. 

Actors were clustered via hierarchical clustering with Ward linkage of a 0/1 dissimilarity matrix. The clustering determined their grouping and order for the following two figures. In both, the upper triangle shows a simple connectedness: connected (have acted together) is purple and not connected (have not acted together) is green. The lower triangle shows the strength of connectedness: not connected is white where as if actors are more connected (i.e., acted more frequently together) the cell will be darker. 

![Full dual network image](./Pictures/DualNetworkVis/1a_DualNet.png)

This is a lot to take in but for the adventurous: download the figure and explore around a bit. Or for the not-so-adventurous I'll help you out. There's a funny little sub-network hiding in here. It helps show that someone at Marvel Studios is a huge fan of Thomas the Tank Engine. If this wasn't obvious by the [climactic battle in Ant-Man](https://www.youtube.com/watch?v=muYbXyYxd5E), then you can see in the network visualization three people with very very high connectedness (23-35 co-acting credits): [William Hope](http://www.imdb.com/name/nm0394054/), [Martin Sherman](http://www.imdb.com/name/nm1453396/), and [Michael Brandon](http://www.imdb.com/name/nm0104787/): all are in [Captain America: The First Avenger](http://www.imdb.com/title/tt0458339/fullcredits). We can see this Thomas the Tank Engine subnetwork a bit better in the next figure. 

The next figure was created from a different network structure. I removed the "global signal" -- i.e., all of the MCU movies were excluded, and the network recomputed. I also dropped any actors with less than 2 co-acting credits. That leaves us with only 104 individuals and the Thomas the Tank Engine subnetwork becomes a bit more apparent:

![No global signal/minimum 2 co-acting network image](./Pictures/DualNetworkVis/3b_DualNet_NoGS_Min2_reorder.png)

There's also another fascinating subnetwork: actors from The Lord of the Rings Trilogies (from Karl Urban at the bottom up to Richard Armitage). Note that Hugo Weaving—and to a lesser extent Andy Serkis—are critical central nodes that connect the Lord of the Rings trilogy to the Hobbit trilogy.




