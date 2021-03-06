% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sql.R
\name{get_asset_ogr_table_name}
\alias{get_asset_ogr_table_name}
\title{Get OGR Table Name for Google Earth Engine Asset}
\usage{
get_asset_ogr_table_name(x)
}
\arguments{
\item{x}{character. Path to Google Earth Engine asset}
}
\value{
character. OGR table name of Google Earth asset
}
\description{
\enumerate{
\item Removes EEDA/EEDAI driver prefix, if present
}
}
\details{
\enumerate{
\item Replaces \code{"-"} and \code{"/"} with \code{"_"}
}
}
\examples{
get_asset_ogr_table_name("projects/earthengine-public/assets/COPERNICUS/S2")
}
