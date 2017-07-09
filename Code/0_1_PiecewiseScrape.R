rm(list=ls())
library(rvest)
library(ExPosition)

source('movie.scrape_better.R')
source('piecewise_get.all.movies.from.actors.R')

load('../Data/PART1.RData')
#ls()[grep("unrolled",ls())]


## pre production -- already done.
#piecewise_get.all.movies.from.actors(preprod.actors.unrolled,'../Data/ActorPartitions/Preprod/')


## post production
#piecewise_get.all.movies.from.actors(postprod.actors.unrolled,'../Data/ActorPartitions/Postprod/')

## Wire -- there's an error in Michael B Jordan... but I already have him.
#unrolled.wire.actors["Michael B. Jordan","Link"] <- "/name/nm0430107/"
#piecewise_get.all.movies.from.actors(unrolled.wire.actors,'../Data/ActorPartitions/Wire/')

## NetFlix
#piecewise_get.all.movies.from.actors(unrolled.netflix.actors,'../Data/ActorPartitions/Netflix/')


## FULL -- tests
#piecewise_get.all.movies.from.actors(complete.actors.unrolled,'../Data/ActorPartitions/Complete/',external.start=1,external.end=20)
	###piecewise_get.all.movies.from.actors(complete.actors.unrolled,'../Data/ActorPartitions/Complete/',external.start=4,external.end=5)
#piecewise_get.all.movies.from.actors(complete.actors.unrolled,'../Data/ActorPartitions/Complete/',external.start=23,external.end=30)
#piecewise_get.all.movies.from.actors(complete.actors.unrolled,'../Data/ActorPartitions/Complete/',external.start=40,external.end=41)
#piecewise_get.all.movies.from.actors(complete.actors.unrolled,'../Data/ActorPartitions/Complete/',external.start=42)
