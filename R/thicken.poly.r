
#' Helper function to thicken polygon boundaries for numerical stability
#' 
#' @param coords Matrix of coordinates
#' @param n Number of intermediate points to add between vertices
#' @return Matrix of thickened coordinates
#' @keywords internal
thicken.poly = function(coords, n) {
    thick.poly = c()
    for(i in 2:nrow(coords))
    {
        x.thick = seq(from=coords[i-1,1], to=coords[i,1], length.out=n)
        y.thick = seq(from=coords[i-1,2], to=coords[i,2], length.out=n)
        thick.poly = rbind(thick.poly, cbind(x.thick, y.thick))
    }
    return(thick.poly)
}



