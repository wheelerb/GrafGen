
rules.mindist <- function(grafout) {

    if (isFile(grafout)) grafout <- readGrafOut(grafout)$table
    ref  <- gp_getRefPops()
    nref <- length(ref)
    ret  <- rep(ref[1], nrow(grafout))
    mind <- as.numeric(grafout[, ref[1], drop=TRUE])
    for (i in 2:nref) {
        vec <- as.numeric(grafout[, ref[i], drop=TRUE])
        tmp <- vec < mind
        tmp[is.na(tmp)] <- FALSE
        if (any(tmp)) {
            mind[tmp] <- vec[tmp]
            ret[tmp]  <- ref[i]
        }
    }
    ret
}
