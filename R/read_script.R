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
  comments <- gsub("^\\#\\*[[:space:]]*", "", comments)
  comments <- trimws(comments)
  script <- full_file[!grepl("^\\#\\*", full_file)]
  sched_script <- list()

  sched_script$script <- script

  if(comments[2] == "" && comments[1] != "") {
    sched_script$name <- comments[1]
  } else {
    stop("Must have a name in the comments")
  }

  end_desc <- which(comments == "")[which(comments == "") > 2][1] - 1
  sched_script$description <- paste(comments[3:end_desc], collapse = " ")

  tags <- comments[grepl("^@", comments)]
  tags <- gsub("^@", "", tags)
  tags <- strsplit(tags, " ")
  for(i in seq_along(tags)) {
    tag <- tags[[i]][1]
    args <- tags[[i]][seq(2, length(tags[[i]]))]
    if(tag %in% names(sched_script)) {

    } else {
      sched_script[tag] <- args
    }
  }

  class(sched_script) <- c("sched_script", class(sched_script))

  return(sched_script)

}
