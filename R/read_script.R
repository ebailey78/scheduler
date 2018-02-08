#' turn a script file into a sched_script object
#'
#' This function reads an R script and looks for `#*` comments that it uses
#' to create a sched_script object which is used by the rest of the package.
#' This function is internal and shouldn't be called by users.
#'
#' @param fn the path the to file to read
#'
#' @return a \code{sched_script} object
read_script <- function(fn) {

  fn <- "tests/test_script.R"
  full_file <- readLines(fn)

  if(!any(grepl("^\\#\\*", full_file))) {
    if(interactive()) {
      warning(basename(fn), " contains no scheduler comments...")
    }
    return(NULL)
  }

  comments <- full_file[grepl("^\\#\\*", full_file)]
  script_name <- gsub("^\\#\\*\\s*", "", comments[!grepl("^\\#\\*\\s*$", comments)][[1]])
  whens <- stringi::stri_match(full_file, regex = "^#[\\*\\*]\\s*@when\\s+(.*)$?")[, 2]
  whens <- whens[!is.na(whens)]
  if(length(whens) == 0) {
    stop("No `@when` statements found in script.", call. = FALSE)
  }

  whens <- process_whens(whens)

  log_level <- stringi::stri_match(full_file, regex = "^#[\\*\\*]\\s*@log\\s+(.*)$?")[, 2]
  log_level <- log_level[!is.na(log_level)]
  if(is.na(log_level)) {
    log_level <- "info"
  } else {
    log_level <- log_level[1]
  }

  sched_script <- list(
    script = full_file[!grepl("^\\#\\*", full_file)],
    name = script_name,
    whens = whens,
    log_level = log_level
  )

  class(sched_script) <- c("sched_script", class(sched_script))

  return(sched_script)

}
