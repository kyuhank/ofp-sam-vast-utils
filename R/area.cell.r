#' Get the area of each longitude by latitude cell. Adjust for change in area with latitude.
#' 
#' @param lond Vector of longitudes (midpoint of the cell)
#' @param latd Vector of latitudes (midpoint of the cell)
#' @param cell.size Integer: size of the cell in degrees. Note, all cells must be the same size
#' @param crs.ll Character string of the crs for the current lat-lon projections
#' @param crs.en.type What type of projection for calculating the area? 'tpeqd', 'mollweide', or 'albers equal area'. Note that 'albers equal area' is hard coded for the central pacific
#' @return Either a vector of areas in km2
#' @importFrom sp SpatialPolygons Polygons Polygon CRS spTransform
#' @importFrom rgeos gArea
#' @export
#' 
area.cell = function(lond, latd, cell.size=1, crs.ll = "+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0", crs.en.type = "mollweide")
{
    # Set coordinate reference system based on projection type
    if(crs.en.type=="tpeqd")
    {
        crs.en = paste0("+proj=tpeqd +lat_1=",round(mean(latd,na.rm=TRUE))," +lon_1=",round(min(lond,na.rm=TRUE) + (1/3)*abs(diff(range(lond,na.rm=TRUE))))," +lat_2=",round(mean(latd,na.rm=TRUE))," +lon_2=",round(min(lond,na.rm=TRUE) + (2/3)*abs(diff(range(lond,na.rm=TRUE))))," +datum=WGS84 +ellps=WGS84 +units=km +no_defs")
    } else if(crs.en.type=="mollweide"){
        crs.en = paste0("+proj=moll +lon_0=",round(mean(lond,na.rm=TRUE))," +x_0=0 +y_0=0 +datum=WGS84 +units=km +no_defs")
    } else if(crs.en.type=="albers equal area"){
        # Hard-coded for central pacific region
        crs.en = paste0("+proj=aea +lat_1=5 +lat_2=45 +lat_0=25 +lon_0=210 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=km +no_defs")
    } else {
        stop("Incorrect crs type is available now. Please set crs.en.type to 'tpeqd'or 'mollweide' or 'albers equal area' ")
    }

    coords.raw = data.frame(x=lond, y=latd)
    
    # Function to create polygon for each cell
    tmp.fn = function(id, coords, crs.ll)
    {	
        coords = coords[id,]
        cell.size.inner = coords[[3]]
        # Create cell boundaries (corners of the grid cell)
        coords = data.frame(
            x = coords[[1]] + c(0.5*cell.size.inner, -0.5*cell.size.inner, -0.5*cell.size.inner, 0.5*cell.size.inner),
            y = coords[[2]] + c(-0.5*cell.size.inner, -0.5*cell.size.inner, 0.5*cell.size.inner, 0.5*cell.size.inner)
        )
        # Create spatial polygon with thickened boundaries for robustness
        poly = sp::SpatialPolygons(
            list(sp::Polygons(list(sp::Polygon(thicken.poly(rbind(coords, coords[1, ]), 100))), ID = as.character(id))),
            proj4string = sp::CRS(crs.ll)
        )
        return(poly)
    }

    # Area is invariant within the same latitude - calculate for unique latitudes only
    u.lat.df = data.frame(
        x = rep(round(mean(coords.raw$x, na.rm=TRUE)), length(unique(coords.raw$y))),
        y = sort(unique(coords.raw$y)),
        size = cell.size
    )
        
    # Create polygons for each unique latitude
    poly.1x1 = lapply(1:nrow(u.lat.df), tmp.fn, coords=u.lat.df, crs.ll=crs.ll)
    poly.1x1 = do.call("rbind", poly.1x1)
    
    # Transform to equal-area projection for accurate area calculation
    poly.1x1.trans = sp::spTransform(poly.1x1, crs.en)

    # Calculate areas in km² and round to 3 decimal places
    u.lat.df$area.km2 = round(rgeos::gArea(poly.1x1.trans, byid=TRUE), digits=3)
    
    # Match areas to original coordinates based on latitude
    coords.raw$area.km2 = u.lat.df$area.km2[match(coords.raw$y, u.lat.df$y)]
    
    return(coords.raw$area.km2)
}
