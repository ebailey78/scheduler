process_whens <- function(whens) {

  whens <- strsplit(whens, " ")
  date_regex <- "(^[[:digit:]]{1,3}$)|(^([[:digit:]]{4}-)?[[:digit:]]{1,2}-[[:digit:]]{1,2})|((^(M|m)on(day)?$)|(^(T|t)ues(day)?$)|(^(W|w)ed(nesday)?$)|(^(T|t)hur(sday)?$)|(^(F|f)ri(day)?$)|(^(S|s)at(urday)?$)|(^(S|s)un(day)?$))"
  time_regex <- "^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$"

  for(i in seq_along(whens)) {
    whens[[i]] <- whens[[i]][grepl(date_regex, whens[[i]]) | grepl(time_regex, whens[[i]])]
    if(!any(grepl(time_regex, whens[[i]]))) {
      whens[[i]] <- c(whens[[i]], "00:15")
    }
  }

  return(whens)

}
