#' Create `SpatRaster` and `SpatRasterCollection` from Google Earth Engine Image and ImageCollection
#'
#' @param x Path to Google Earth Engine Image/ImageCollection asset
#' @param ... Additional arguments to `terra::rast()`
#'
#' @return `EEImage()`: a `SpatRaster`
#' @export
#' @importFrom terra rast
#' @examples
#' \dontrun{
#' EEImage("projects/earthengine-public/assets/COPERNICUS/S2/20170430T190351_20170430T190351_T10SEG")
#' }
EEImage <- function(x, silent = TRUE, ...) {
  if (!startsWith(x, "EEDAI:")) {
    x <- paste0("EEDAI:", x)
  }
  .s <- .suppress(silent = silent, suppress_warnings = silent)
  .s(terra::rast(x, ...))
}

#' @rdname EEImage
#' @param n integer. Maximum of elements of ImageCollection to return added to the default `query`. Defaults to `10`; large collections may take a while to query.
#' @param WHERE character. Optional `WHERE` clause added to the default `query`.
#' @param query character. Query argument used by `terra::vect()`. Defaults to `paste("SELECT * FROM", get_asset_ogr_table_name(x), WHERE, "LIMIT ", n)`
#' @param silent logical. Silence warning/error messages? Default: `TRUE`
#' @return `EEImageCollection()`: a `SpatRasterCollection` where each element is a (sub)dataset from the source ImageCollection `x`
#' @export
#' @importFrom terra rast vect sprc
#' @examples
#' \dontrun{
#' EEImageCollection("projects/earthengine-public/assets/COPERNICUS/S2", n = 5)
#' }
EEImageCollection <- function(x, ...,
                              n = 10, WHERE = NULL,
                              query = paste("SELECT * FROM", get_asset_ogr_table_name(x), WHERE, "LIMIT ", n),
                              silent = TRUE) {

  .s <- .suppress(silent = silent, suppress_warnings = silent)

  # query the collection
  v <- .s(terra::vect(.EEDA(x), query = query))

  # if x is a single image with multiple subdatasets, not an imagecollection, above will error
  if (inherits(v, 'try-error')) {
    # try next step with input path, instead of using the index
    v <- list(name = x)
  }

  # create SpatRasterCollection from the list of all subdatasets in v
  .s(terra::sprc(do.call('c', lapply(.EEDAI(v$name), .asset_sds_to_rast, ...))))
}
