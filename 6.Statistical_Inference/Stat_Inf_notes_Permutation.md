Example of permutation test: rank sum test, Fisher’s exact test,
ordinary permutation test

    data("InsectSprays") 
    subdata <- InsectSprays[InsectSprays$spray %in% c("B","C"),] 
    y <- subdata$count
    group <- as.character(subdata$spray)
    testStat <- function(w, g) mean(w[g == "B"]) - mean(w[g == "C"])
    observedStat <- testStat(y,group)
    permutations <- sapply(1:10000, function(i) testStat(y, sample(group)))
    observedStat

    ## [1] 13.25

    mean(permutations > observedStat)

    ## [1] 0

    ## We can not generate more extremes difference from permutation test as compared to the observed difference
