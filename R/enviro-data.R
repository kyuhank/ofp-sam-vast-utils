#' Environmental covariate data structure for spatial-temporal modeling
#'
#' A named list containing environmental covariate information required for 
#' spatial-temporal modeling in VAST. The list contains formula specifications
#' and associated covariate data.
#'
#' @format A named list of length 2:
#' \describe{
#'   \item{formula}{A character string that can be coerced to a formula using \code{stats::as.formula}}
#'   \item{covariate_data}{A data frame with the following columns:
#'     \itemize{
#'       \item Year - Time step/year (integer)
#'       \item Lon - Longitude in decimal degrees (numeric)
#'       \item Lat - Latitude in decimal degrees (numeric)
#'       \item covariates... - Additional environmental covariates (numeric)
#'     }
#'   }
#' }
#' @source Environmental data for demonstration purposes
#' @examples
#' \dontrun{
#' data(enviro)
#' str(enviro)
#' head(enviro$covariate_data)
#' }
"enviro"