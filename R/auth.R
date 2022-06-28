#' Set Google Authentication Credentials
#'
#' @param x Path to Google "service account" Authentication Credentials file (JSON format)
#'
#' @return Sets `GOOGLE_APPLICATION_CREDENTIALS` system environment variable for the current session
#' @export
#' @examples
#' \dontrun{
#' set_google_application_credentials("~/example-gizmo-999999-999999999999.json")
#' }
set_google_application_credentials <- function(x) {
  Sys.setenv(GOOGLE_APPLICATION_CREDENTIALS = path.expand(x))
}
