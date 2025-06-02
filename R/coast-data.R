#' A shapefile of coastline centered on the Pacific Ocean
#'
#' A SpatialPolygons object containing global coastline data optimized for 
#' Pacific Ocean-centered mapping and analysis.
#'
#' @format An object of class \code{SpatialPolygons}
#' \describe{
#'   \item{x min}{5.5e-07 - Minimum longitude}
#'   \item{x max}{360 - Maximum longitude}
#'   \item{y min}{-68.91981 - Minimum latitude}
#'   \item{y max}{83.62683 - Maximum latitude}
#'   \item{proj4string}{+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0}
#' }
#' @source \url{https://www.ngdc.noaa.gov/mgg/shorelines/}
#' @examples
#' \dontrun{
#' data(coast)
#' plot(coast)
#' }
"coast"