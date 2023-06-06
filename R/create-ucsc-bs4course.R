#' @keywords internal
bookdown_skeleton <- function(path, output_format = skeleton_formats()) {
  output_format <- match.arg(output_format)
  # ensure directory exists
  dir.create(path, recursive = TRUE, showWarnings = FALSE)
  path <- xfun::normalize_path(path)

  # Get common resources
  files <- skeleton_get_files("common")
  files_format <- skeleton_get_files(output_format)
  # copy them to path
  source <- file.path(skeleton_get_dir(), c(files, files_format))
  # common resource are copied without folder
  target <- file.path(path, c(xfun::relative_path(files, "common"), files_format))

  lapply(unique(dirname(target)), fs::dir_create)
  file.copy(source, target)

  # Tweak template file
  skeleton_build_index(path, output_format)
  skeleton_build_output_yml(path, output_format)
  skeleton_build_bookdown_yml(path, output_format)
  move_dir(file.path(path, output_format), path) # move left format files
  skeleton_remove_blocks(path, output_format)

  # add image folder
  skeleton_get_images(path)
  skeleton_get_images_chapters(path)

  # Get missing assets
  if (output_format == "bs4_book") {
    skeleton_get_csl(path, "chicago-fullnote-bibliography")
  }

  invisible(TRUE)
}

#' @keywords internal
skeleton_remove_blocks <- function(path, output_format) {
  rmd_files <- list.files(path, "[.]Rmd$", recursive = TRUE, full.names = TRUE)
  unkept_format <- setdiff(skeleton_formats(), output_format)
  for (file in rmd_files) {
    content <- xfun::read_utf8(file)

    # remove block
    r1 <- sprintf("<!--(%s):start-->", paste(unkept_format, collapse = "|"))
    s_remove <- grep(r1, content)
    r3 <- sprintf("<!--(%s):end-->", paste(unkept_format, collapse = "|"))
    e_remove <- grep(r3, content)
    if (length(s_remove) != 0 && length(s_remove) == length(e_remove)) {
      block <- unlist(mapply(function(s, e) seq.int(s, e), s = s_remove, e = e_remove))
      content <- content[-block]
    }

    # remove magick comment only
    r2 <- sprintf("<!--(%s):start-->", output_format)
    s_keep <- grep(r2, content)
    r4 <- sprintf("<!--(%s):end-->", output_format)
    e_keep <- grep(r4, content)
    if (length(s_keep) > 0) content <- content[-c(s_keep, e_keep)]

    xfun::write_utf8(content, file)
  }
  invisible(TRUE)
}

#' @keywords internal
skeleton_formats <- function() {
  c("gitbook", "bs4_book")
}

#' @keywords internal
skeleton_insert_yml <- function(index_rmd, index_yml, placeholder) {
  index <- xfun::read_utf8(index_rmd)
  pos <- grep(placeholder, index, fixed = FALSE)
  if (length(pos) <= 0) {
    return(invisible(FALSE))
  }
  yml <- if (file.exists(index_yml)) {
    on.exit(unlink(index_yml), add = TRUE)
    xfun::read_utf8(index_yml)
  }
  index <- c(index[seq_len(pos - 1)], yml, index[seq.int(pos + 1, length(index))])
  xfun::write_utf8(index, index_rmd)
  invisible(TRUE)
}

#' @keywords internal
skeleton_build_index <- function(path, format_dir) {
  index_file <- file.path(path, "index.Rmd")
  index_format_yml <- file.path(path, format_dir, "index.yml")
  skeleton_insert_yml(index_file, index_format_yml, "# additional yaml goes here")
}

#' @keywords internal
skeleton_append_yml <- function(main_yml, child_yml, prepend = NULL) {
  yml_main <- xfun::read_utf8(main_yml)
  if (!file.exists(child_yml)) {
    return(invisible(FALSE))
  }
  yml_child <- xfun::read_utf8(child_yml)
  on.exit(unlink(child_yml), add = TRUE)
  prepend <- c(prepend, yml_child)
  xfun::write_utf8(c(prepend, yml_main), main_yml)
  invisible(TRUE)
}


#' @keywords internal
move_dir <- function(from, to) {
  if (!fs::dir_exists(to)) {
    return(file.rename(from, to))
  }
  to_copy <- list.files(from, full.names = TRUE)
  if (length(to_copy) == 0 ||
    any(file.copy(list.files(from, full.names = TRUE), to, recursive = TRUE))
  ) {
    unlink(from, recursive = TRUE)
  }
  invisible(TRUE)
}

#' @keywords internal
copy_dir <- function(from, to) {
  if (!fs::dir_exists(to)) dir.create(to)
  file.copy(list.files(from, full.names = TRUE), to, recursive = TRUE)
  invisible(TRUE)
}

#' @keywords internal
move_dirs <- function(from, to) mapply(move_dir, from, to)

#' @keywords internal
copy_dirs <- function(from, to) mapply(copy_dir, from, to)

#' @keywords internal
skeleton_get_images <- function(path) {
  dir_name <- "images"
  dir_path <- file.path(path, dir_name)
  copy_dir(skeleton_get_dir(dir_name), dir_path)
}

#' @keywords internal
skeleton_get_images_chapters <- function(path) {
  dir_name_cpts <- paste0("images/", c("cpt_1", "cpt_3"))
  dir_paths <- file.path(path, dir_name_cpts)
  copy_dirs(skeleton_get_dir(dir_name_cpts), dir_paths)
}

#' @keywords internal
skeleton_build_output_yml <- function(path, format_dir) {
  file <- "_output.yml"
  main_file <- file.path(path, file)
  child_file <- file.path(path, format_dir, file)
  skeleton_append_yml(main_file, child_file)
}

skeleton_build_bookdown_yml <- function(path, format_dir) {
  file <- "_bookdown.yml"
  main_file <- file.path(path, file)
  child_file <- file.path(path, format_dir, file)
  prepend <- sprintf('book_filename: "%s"', basename(path))
  skeleton_append_yml(main_file, child_file, prepend)
}



skeleton_get_files <- function(subdir = NULL, relative = TRUE) {
  resources <- skeleton_get_dir()
  subdir <- file.path(resources, subdir %n% "")
  if (!dir.exists(subdir)) {
    return(NULL)
  }
  files <- list.files(subdir, recursive = TRUE, include.dirs = FALSE, full.names = TRUE)
  if (relative) xfun::relative_path(files, resources) else files
}

skeleton_get_csl <- function(path, csl) {
  xfun::in_dir(path, {
    try_download_asset(
      sprintf("https://www.zotero.org/styles/%s", csl),
      xfun::with_ext(csl, "csl")
    )
  })
}

activate_rstudio_project <- function(dir) {
  if (xfun::pkg_available("rstudioapi") && rstudioapi::isAvailable("1.1.287")) {
    rstudioapi::initializeProject(dir)
  }
}


#' @title Create a bs4 bookdown project for UCSC course
#'
#' @description
#'  Create a bookdown project with multiple book output formats,
#'  including HTML.
#'
#'   * Use `create_bs4_ucsc_course()` to use a `bookdown::bs4_book()` output format for course docs
#'
#' The function will create a folder with file structure for a bookdown project,
#' and example files with information on how to start.
#'
#' @param path Absolute path to an empty directory in which to create the bookdown project.
#'      In the RStudio IDE, if \pkg{rstudioapi} package available, an RStudio project will be created.
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname create_bs4_ucsc_course
#' @export
create_bs4_ucsc_course <- function(path) {
  bookdown_skeleton(path, output_format = "bs4_book")
  activate_rstudio_project(path)
  message("👍 the course template is located at:", path)
}



# Trying download because in case of offline usage we still want the skeleton
# project to be created without error
try_download_asset <- function(url, asset_name) {
  msg <- tryCatch(
    {
      xfun::download_file(url, output = asset_name, quiet = TRUE)
      NULL
    },
    warning = function(w) invokeRestart("muffleWarning"),
    error = function(e) {
      c(
        ">>> ",
        sQuote(asset_name),
        " can't be downloaded. Please retrieve it manually at ",
        sQuote(url),
        " or remove its usage from the template."
      )
    }
  )
  if (!is.null(msg)) message(msg)
  invisible(NULL)
}

bookdown_file <- function(...) {
  system.file(..., package = "ucscthemes", mustWork = TRUE)
}

skeleton_get_dir <- function(...) {
  bookdown_file("rstudio", "templates", "project", "resources", ...)
}

`%n%` <- knitr:::`%n%`
