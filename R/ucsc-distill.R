#' @title Create a distill fashion course themed for UCSC
#' @description can easily create new distill website with USCS themeing.
#' @param dir absolute path
#' @param title website title
#' @param gh_pages are you going to use GH pages?, Default: FALSE
#' @param edit interactively decide index.Rmc, Default: interactive()
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[distill]{character(0)}}
#' @rdname create_ucsc_distill_website
#' @export
#' @importFrom distill create_website
create_ucsc_distill_website <- function(dir,
                                        title,
                                        gh_pages = FALSE,
                                        edit = interactive()) {
  type <- "distill-ucsc-website"
  tmp <- distill::create_website(
    dir = dir,
    title = title,
    gh_pages = gh_pages,
    type = "website",
    edit = edit
  ) # dont open before adapting files

  # copy template files
  theme_dir <- system.file(file.path("rstudio", "templates", "project", type, "theme"),
    package = "ucscthemes"
  )
  theme_files <- list.files(theme_dir)
  k <- if (!dir.exists(file.path(dir, "theme"))) dir.create(file.path(dir, "theme"))

  k <- lapply(theme_files, function(x) file.copy(file.path(theme_dir, x), file.path(dir, "theme", x)))

  render_website_template <- function(file, data = list()) {
    ucscthemes_render_template(file, type = type, dir, data)
  }
  render_website_template("_site.yml", data = list(
    name = basename(dir),
    title = title,
    output_dir = if (gh_pages) "docs" else "_site"
  ))
  render_website_template("index.Rmd", data = list(title = title, gh_pages = gh_pages))
  render_website_template("about.Rmd")

  distill::distill_website(dir)
}

#' @keywords internal
new_project_create_website <- function(dir, ...) {
  params <- list(...)
  create_ucsc_distill_website(dir,
    params$title,
    params$gh_pages,
    edit = FALSE
  )
}


#' @keywords internal
ucscthemes_render_template <- function(file, type, target_path, data = list()) {
  template <- system.file(file.path("rstudio", "templates", "project", type, file),
    package = "ucscthemes"
  )
  template <- paste(readLines(template, encoding = "UTF-8"), collapse = "\n")
  output <- whisker::whisker.render(template, data)
  writeLines(output, file.path(target_path, file), useBytes = TRUE)
}
