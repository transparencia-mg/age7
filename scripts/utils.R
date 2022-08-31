describe_unique <- function(x) {
  list(unique = anyDuplicated(x) == 0, 
       pct_unique = length(unique(x))  / length(x),
       n_unique = length(unique(x)))
}

describe_enum <- function(x) {
  list(enum = sort(unique(x)),
       pct_enum = dplyr::arrange(janitor::tabyl(x), -percent))  
}

describe_length <- function(x) {
  result <- unlist(lapply(x, nchar))
  list(minLength = min(result),
       maxLength = max(result))
}

describe_range <- function(x) {
  list(min = min(x),
       max = max(x))
}
