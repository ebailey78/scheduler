#' process a POSIXct object for use by scheduler
#'
#' This function processes the current date/time so that it can be compared to
#' when tag arguments
#'
#' @param dt a POSIXct object
#'
#' @return a vector of formatted dates/times
#'
#' @examples
process_time <- function(dt = Sys.time()) {

  tolower(sapply(c("%d", "%H:%M", "%m-%d", "%Y-%m-%d", "%a", "%A", "%j"),
    function(f, dt) {format(dt, f)}, dt = dt))

}
