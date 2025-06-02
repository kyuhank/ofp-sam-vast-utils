#' Eastern Pacific Ocean (EPO) regional boundaries for BET stock assessment
#'
#' A SpatialPolygons object containing the boundaries of the model regions 
#' for the Eastern Pacific Ocean (EPO) used in the 2015 WCPFC Pacific-wide 
#' BET (bigeye tuna) stock assessment.
#'
#' @format An object of class \code{SpatialPolygons}
#' \describe{
#'   \item{regions}{Multiple polygon regions representing EPO boundaries}
#'   \item{proj4string}{Coordinate reference system information}
#' }
#' @source 2015 WCPFC Pacific-wide BET stock assessment
#' @references Western and Central Pacific Fisheries Commission (WCPFC) 2015 stock assessment
#' @examples
#' \dontrun{
#' data(epo.shp)
#' plot(epo.shp)
#' }
"epo.shp"
