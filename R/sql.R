
#' Get OGR Table Name for Google Earth Engine Asset
#'
#' 1. Removes EEDA/EEDAI driver prefix, if present
#'
#' 2. Replaces `"-"` and `"/"` with `"_"`
#'
#' @param x character. Path to Google Earth Engine asset
#'
#' @return character. OGR table name of Google Earth asset
#' @export
#' @examples
#' get_asset_ogr_table_name("projects/earthengine-public/assets/COPERNICUS/S2")
get_asset_ogr_table_name <- function(x) {
  gsub("\\-|/", "_", gsub("EEDAI?:(.*)", "\\1", x))
}
