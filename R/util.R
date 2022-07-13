
#' Functions for working with `SpatRasterCollection` objects
#'
#' @param x SpatRasterCollection
#' @param colnames Default `c("i", "x", "y", "crs", "xmin", "xmax", "ymin", "ymax")`
#'
#' @return `.sprcres()`: data.frame with first column `"i"` as index, followed by resolution (`"x"`, `"y"`),
#'                       coordinate reference system (`"crs"`), and extent (`"xmin"`, `"xmax"`, `"ymin"`, `"ymax"`)
#' @noRd
#' @keywords internal
.sprcres <- function(x, colnames = c("i", "x", "y", "crs", "xmin", "xmax", "ymin", "ymax")) {
  `colnames<-`(do.call('rbind', lapply(seq_along(x), function(i)
    data.frame(
      i, t(terra::res(x[i])), crs = terra::crs(x[i]), t(terra::ext(x[i])@ptr$vector)
    ))), colnames)
}

#' @return `.splitsprc_res()`: list of `SpatRasterCollection` split according to the columns in colnames, optionally mosaic'd into a list of `SpatRaster`
#' @noRd
#' @keywords internal
.splitsprc_res <- function(x, splitcol = c("x", "y", "crs"), mosaic = FALSE) {
  # TODO: identify SpatRaster with identical resolution, crs, extent--combine into multiband SpatRaster before mosaic
  y <- .sprcres(x)
  res <- lapply(split(seq_along(x), as.list(y[, splitcol]), drop = TRUE), function(i) x[i])
  names(res) <- NULL
  if (mosaic) {
    res <- lapply(res, terra::mosaic, filename = "")
  }
  res
}

#' Add EEDA and EEDAI driver prefix to path
#'
#' @param x character. ID/path to Google Earth Engine asset
#'
#' @return path with "EEDA" or "EEDAI" prefix
#' @aliases .EEDAI
#' @noRd
#' @keywords internal
.EEDA <- function(x) {
  x <- gsub("EEDAI:", "EEDA:", x)
  idx <- grep("^EEDA:.*", x, invert = TRUE)
  x[idx] <- paste0("EEDA:", x[idx])
  x
}

#' @noRd
#' @keywords internal
.EEDAI <- function(x) {
  x <- gsub("EEDA:", "EEDAI:", x)
  idx <- grep("^EEDAI:.*", x, invert = TRUE)
  x[idx] <- paste0("EEDAI:", x[idx])
  x
}

#' Return a `SpatRaster` for each sub-dataset in a dataset
#'
#' @param x character. path to dataset
#'
#' @return list of `SpatRaster`
#' @noRd
#' @keywords internal
.asset_sds_to_rast <- function(x, ...) {
  lapply(terra::describe(x, sds = TRUE)$name, terra::rast, ...)
}


#' Handle error and warning suppression via package option and function argument
#'
#' @param suppress_warnings Default: `TRUE` to `suppressWarnings()`
#' @param silent Default: `TRUE` to silence error output on `try()`
#' @details Uses argument `suppress_warnings` (default `TRUE`) and package option `terragee.suppressWarnings` (default `TRUE`). If both are TRUE, returns a function that suppresses warnings (`suppressWarnings()`). Otherwise, returns a "dummy" function (that does not suppress warnings).
#' @return function. Either `try(suppressWarnings(x))` or `(function(x) x)(x)`
#' @noRd
#' @keywords internal
.suppress <- function(suppress_warnings = TRUE, silent = TRUE) {
  if (suppress_warnings && getOption("terragee.suppressWarnings", default = TRUE)) {
    function(x) try(suppressWarnings(x), silent = silent)
  } else {
    function(x) try(x, silent = silent)
  }
}

