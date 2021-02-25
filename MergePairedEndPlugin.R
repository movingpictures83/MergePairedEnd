#First must have dada2 and Bioconductor installed: https://benjjneb.github.io/dada2/dada-installation.html 
#Must also have phyloseq installed: http://joey711.github.io/phyloseq/install.html
dyn.load(paste("RPluMA", .Platform$dynlib.ext, sep=""))
source("RPluMA.R")

library(ShortRead)
library(dada2); 
packageVersion("dada2")


input <- function(inputfile) {
  pfix <<- prefix()
  if (length(pfix) != 0) {
     pfix <<- paste(pfix, "/", sep="")
  }

  parameters <- read.table(inputfile, as.is=T);
  rownames(parameters) <- parameters[,1]
  fastqpfx <<- paste(pfix, toString(parameters["FASTQ", 2]), sep="")
  dadapfx <<- paste(pfix, toString(parameters["DADA", 2]), sep="")
  minOverlap <<- as.integer(toString(parameters["minoverlap", 2]))
}

run <- function() {
	derep_forward <<- readRDS(paste(fastqpfx, "forward", "rds", sep="."))
	derep_reverse <<- readRDS(paste(fastqpfx, "reverse", "rds", sep="."))
	dadaFs <<- readRDS(paste(dadapfx, "forward", "rds", sep="."))
	dadaRs <<- readRDS(paste(dadapfx, "reverse", "rds", sep="."))
	merger1 <<- mergePairs(dadaFs, derep_forward, dadaRs, derep_reverse, minOverlap=minOverlap, verbose=TRUE)
}

output <- function(outputfile) {
i=1
for (fn in names(merger1)) {
   uniquesToFasta(merger1[[i]], paste(outputfile, fn, sep="."))
   i <- i+1
}
   saveRDS(merger1, paste(outputfile, "rds", sep="."))
}


