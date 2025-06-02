#' A simulated data set approximating skipjack biomass in the western and central Pacific Ocean
#'
#' A simulated dataset containing skipjack tuna biomass data for the Western and Central 
#' Pacific Ocean region, suitable for testing spatial-temporal models.
#'
#' @format A data frame with 10,000 rows and 7 variables:
#' \describe{
#'   \item{Response_variable}{Adult skipjack biomass (numeric)}
#'   \item{Year}{Time step/year (integer)}
#'   \item{Lon}{Longitude in decimal degrees (numeric)}
#'   \item{Lat}{Latitude in decimal degrees (numeric)}
#'   \item{Spp}{Species code (character)}
#'   \item{AreaSwept_km2}{Area of cell where the data came from in km² (numeric)}
#'   \item{Vessel}{Filler column in case vessel random effects are desired (character)}
#' }
#' @source Simulated data for demonstration purposes
#' @examples
#' \dontrun{
#' data(Data_Geostat)
#' head(Data_Geostat)
#' summary(Data_Geostat)
#' }
"Data_Geostat"