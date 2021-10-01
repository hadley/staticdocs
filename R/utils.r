set_contains <- function(haystack, needles) {
  all(needles %in% haystack)
}

split_at_linebreaks <- function(text) {
  if (length(text) < 1)
    return(character())
  strsplit(text, "\\n\\s*\\n")[[1]]
}

up_path <- function(depth) {
  paste(rep.int("../", depth), collapse = "")
}

dir_depth <- function(x) {
  x %>%
    strsplit("") %>%
    purrr::map_int(function(x) sum(x == "/"))
}

invert_index <- function(x) {
  stopifnot(is.list(x))

  if (length(x) == 0)
    return(list())

  key <- rep(names(x), purrr::map_int(x, length))
  val <- unlist(x, use.names = FALSE)

  split(key, val)
}

rstudio_save_all <- function() {
  if (is_installed("rstudioapi") && rstudioapi::hasFun("documentSaveAll")) {
    rstudioapi::documentSaveAll()
  }
}

is_syntactic <- function(x) x == make.names(x)

str_trim <- function(x) gsub("^\\s+|\\s+$", "", x)

# devtools metadata -------------------------------------------------------

devtools_loaded <- function(x) {
  if (!x %in% loadedNamespaces()) {
    return(FALSE)
  }
  ns <- .getNamespace(x)
  env_has(ns, ".__DEVTOOLS__")
}

devtools_meta <- function(x) {
  ns <- .getNamespace(x)
  ns[[".__DEVTOOLS__"]]
}

# CLI ---------------------------------------------------------------------

dst_path <- function(...) {
  crayon::blue(encodeString(path(...), quote = "'"))
}

src_path <- function(...) {
  crayon::green(encodeString(path(...), quote = "'"))
}

cat_line <- function(...) {
  cat(paste0(..., "\n"), sep = "")
}

rule <- function(x = NULL, line = "-") {
  width <- getOption("width")

  if (!is.null(x)) {
    prefix <- paste0(line, line, " ")
    suffix <- " "
  } else {
    prefix <- ""
    suffix <- ""
    x <- ""
  }

  line_length <- width - nchar(x) - nchar(prefix) - nchar(suffix)
  # protect against negative values which can result in narrow terminals
  line_length <- max(0, line_length)
  cat_line(prefix, crayon::bold(x), suffix, strrep(line, line_length))
}

yaml_list <- function(...) print_yaml(list(...))

print_yaml <- function(x) {
  structure(x, class = "print_yaml")
}

pkgdown_field <- function(pkg, ...) {

  field <- paste0(list(...), collapse = ".")

  config_path <- pkgdown_config_path(path = pkg$src_path)

  if (is.null(config_path)) {
    return(crayon::bold(field))
  }

  config <- src_path(
    fs::path_rel(
      config_path,
      pkg$src_path
    )
  )

  paste0(
    crayon::bold(field), " in ", config
  )
}

pkgdown_fields <- function(pkg, fields) {
  fields <- purrr::map_chr(fields, paste0, collapse = ".")
  fields <- toString(crayon::bold(fields))
  pkgdown_field(pkg, fields)
}

check_components <- function(needed, present, where, pkg) {
  missing <- setdiff(needed, present)

  if (length(missing) == 0) {
    return()
  }

  missing_components <- lapply(
      missing, append,
      where,
      after = 0
    )
    missing_fields <- pkgdown_fields(pkg = pkg, fields = missing_components)

    abort(
      paste0(
        "Can't find component", if (length(missing) > 1) "s", " ",
        paste0(missing_fields, collapse = " or "),
        "."
      )
    )
}

#' @export
print.print_yaml <- function(x, ...) {
  cat(yaml::as.yaml(x), "\n", sep = "")
}

skip_if_no_pandoc <- function() {
  testthat::skip_if_not(rmarkdown::pandoc_available("1.12.3"))
}

has_internet <- function() {
  return(getOption("pkgdown.internet", default = TRUE))
}

with_dir <- function(new, code) {
  old <- setwd(dir = new)
  on.exit(setwd(old))
  force(code)
}

# remove '' quoting
# e.g. 'title' becomes title.s
cran_unquote <- function(string) {
  gsub("\\'(.*?)\\'", "\\1", string)
}

show_xml <- function(x) {
  cat(as.character(x, options = c("format", "no_declaration")))
}

isFALSE <- function(x) {
  is.logical(x) && length(x) == 1L && !is.na(x) && !x
}

modify_list <- function(x, y) {
  if (is.null(y)) {
    return(x)
  }

  utils::modifyList(x, y)
}

code_commas <- function(x) {
  paste0("`", x, "`", collapse = ", ")
}

# from https://github.com/r-lib/rematch2/blob/8098bd06f251bfe0f20c0598d90fc20b741d13f8/R/package.R#L47
re_match <- function(text, pattern, perl = TRUE, ...) {

  stopifnot(is.character(pattern), length(pattern) == 1, !is.na(pattern))
  text <- as.character(text)

  match <- regexpr(pattern, text, perl = perl, ...)

  start  <- as.vector(match)
  length <- attr(match, "match.length")
  end    <- start + length - 1L

  matchstr <- substring(text, start, end)
  matchstr[ start == -1 ] <- NA_character_

  res <- data.frame(
    stringsAsFactors = FALSE,
    .text = text,
    .match = matchstr
  )

  if (!is.null(attr(match, "capture.start"))) {

    gstart  <- attr(match, "capture.start")
    glength <- attr(match, "capture.length")
    gend    <- gstart + glength - 1L

    groupstr <- substring(text, gstart, gend)
    groupstr[ gstart == -1 ] <- NA_character_
    dim(groupstr) <- dim(gstart)

    res <- cbind(groupstr, res, stringsAsFactors = FALSE)
  }

  names(res) <- c(attr(match, "capture.names"), ".text", ".match")
  class(res) <- c("tbl_df", "tbl", class(res))
  res
}

# external links can't be an active item
# external links start with http(s)
# but are NOT an absolute URL to the pkgdown site at hand
is_internal_link <- function(links, pkg) {
  if (is.null(pkg$meta$url)) {
    !grepl("https?://", links)
  } else {
    !grepl("https?://", links) | grepl(pkg$meta$url, links)
  }
}

remove_useless_parts <- function(links, pkg) {
  # remove website URL
  if (!is.null(pkg$meta$url)) {
    links <- sub(pkg$meta$url, "", links)
  }
  # remove first slash from path
  links <- sub("^/", "", links)
  # remove /index.html from the end
  links <- sub("/index.html/?", "", links)
  # remove ../ from the beginning
  links <- gsub("\\.\\./", "", links)

  links
}

get_section_level <- function(section) {
  as.numeric(
     gsub(
        ".*section level(\\d+).*", '\\1',
        xml2::xml_attr(section, "class")
      )
  )
}
