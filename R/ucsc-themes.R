#' ggplot themes for ucsc
#'
#' A selection of themes that fit with the
#' ucsc branding instructions.
#'
#' You should [import_roboto()] first and also install the fonts on your
#' system before trying to use this theme.
#'
#' @details
#' \itemize{
#'    \item{theme_ucsc} - base theme for ucsc
#'    \item{theme_ucsc_dark} - dark/inverted version of base theme
#'    \item{theme_ucsc_void} - base theme without axis information or grid
#'    \item{theme_ucsc_darl_void} - dark/inverted theme without axis information or grid
#' }
#'
#' @param base_size text size
#' @export
#' @importFrom ggplot2 theme_grey theme '%+replace%'
#' @rdname themes_ucsc
#' @examples
#' \dontrun{
#' library(ggplot2)
#'
#' ggplot(mtcars, aes(mpg, disp, colour = cyl)) +
#'   geom_point(size = 5) +
#'   theme_ucsc()
#'
#' ggplot(mtcars, aes(mpg, disp, colour = cyl)) +
#'   geom_point(size = 5) +
#'   theme_ucsc_dark()
#'
#' ggplot(mtcars, aes(mpg, disp, colour = cyl)) +
#'   geom_point(size = 5) +
#'   theme_ucsc_void()
#'
#' ggplot(mtcars, aes(mpg, disp, colour = factor(cyl))) +
#'   geom_point(size = 5) +
#'   theme_ucsc_dark_void()
#' }
theme_ucsc <- function(base_size = 11.5) {
  theme_grey(
    base_size = base_size,
    base_family = "Roboto"
  ) %+replace%
    theme(
      line = ucsc_line(ucsc_cols("grey1")),
      text = ucsc_text(ucsc_cols("blue")),
      title = element_text(family = ucsc_font("title")),
      panel.background = ucsc_rect(),
      panel.grid = ucsc_line("grey95"),
      panel.grid.minor = ucsc_line("grey95",
        linetype = "longdash"
      ),
      plot.background = ucsc_rect(),
      plot.subtitle = ucsc_text(ucsc_cols("blue"),
        fonttype = "title",
        face = "italic", vjust = 1, hjust = 0
      ),
      plot.title = element_text(
        family = ucsc_font("title"),
        margin = margin(b = 10),
        face = "bold",
        size = 15,
        hjust = 0
      ),
      axis.line = ucsc_line("grey60"),
      legend.background = ucsc_rect(),
      legend.key = ucsc_rect()
    )
}

#' @export
#' @importFrom ggplot2 theme '%+replace%'
#' @rdname themes_ucsc
theme_ucsc_dark <- function(base_size = 10) {
  theme_ucsc() %+replace%
    theme(
      line = ucsc_line(ucsc_cols("grey1")),
      text = ucsc_text(ucsc_cols("white")),
      panel.background = ucsc_rect(ucsc_cols("blue")),
      panel.grid = ucsc_line(ucsc_cols("grey5")),
      panel.grid.minor = ucsc_line(ucsc_cols("grey5"),
        linetype = "longdash"
      ),
      plot.background = ucsc_rect(ucsc_cols("blue")),
      plot.subtitle = ucsc_text(ucsc_cols("grey1"),
        face = "italic", vjust = 1, hjust = 0
      ),
      axis.line = ucsc_line(ucsc_cols("white")),
      axis.text = ucsc_text(ucsc_cols("grey1")),
      legend.background = ucsc_rect(),
      legend.key = ucsc_rect()
    )
}

# void themes ----

#' @export
#' @importFrom ggplot2 theme element_blank '%+replace%'
#' @rdname themes_ucsc

theme_ucsc_void <- function(base_size = 10) {
  theme_ucsc() %+replace%
    theme(
      panel.background = element_blank(),
      panel.grid = element_blank(),
      panel.grid.minor = element_blank(),
      plot.background = element_blank(),
      axis.line = element_blank(),
      axis.text = element_blank(),
      axis.title = element_blank(),
      axis.ticks = element_blank()
    )
}


#' @export
#' @importFrom ggplot2 theme element_blank '%+replace%'
#' @rdname themes_ucsc
theme_ucsc_dark_void <- function(base_size = 10) {
  theme_ucsc_dark() %+replace%
    theme(
      panel.grid = element_blank(),
      panel.grid.minor = element_blank(),
      axis.line = element_blank(),
      axis.text = element_blank(),
      axis.title = element_blank(),
      axis.ticks = element_blank()
    )
}

# elements ----
#' @importFrom ggplot2 element_text margin
ucsc_text <- function(colour = ucsc_cols("blue"),
                      size = 10,
                      lineheight = 0.9,
                      hjust = 0.5,
                      vjust = 0.5,
                      angle = 0,
                      face = "plain",
                      fonttype = "body") {
  element_text(
    family = ucsc_font(fonttype),
    face = face,
    colour = colour,
    hjust = hjust,
    vjust = vjust,
    angle = angle,
    size = size,
    lineheight = lineheight,
    margin = margin(),
    debug = FALSE
  )
}

#' @importFrom ggplot2 element_line
ucsc_line <- function(colour, linetype = "solid") {
  element_line(
    colour = colour,
    size = .6,
    linetype = linetype,
    lineend = "round"
  )
}

#' @importFrom ggplot2 element_rect
ucsc_rect <- function(fill = "transparent", colour = NA) {
  element_rect(fill = fill, colour = colour)
}

#' Import Roboto font for use in charts
#'
#' Roboto is a trademark of Google.
#'
#' There is an option `hrbrthemes.loadfonts` which -- if set to `TRUE` -- will
#' call `extrafont::loadfonts()` to register non-core fonts with R PDF & PostScript
#' devices. If you are running under Windows, the package calls the same function
#' to register non-core fonts with the Windows graphics device.
#'
#' @md
#' @note This will take care of ensuring PDF/PostScript usage. The location of the
#'   font directory is displayed after the base import is complete. It is highly
#'   recommended that you install them on your system the same way you would any
#'   other font you wish to use in other programs.
#' @export
import_roboto <- function() {
  roboto_font_dir <- system.file("fonts", "roboto", package = "ucscthemes")
}


#' Import inter font for use in charts
#'
#' inter is a trademark of Google.
#'
#' There is an option `hrbrthemes.loadfonts` which -- if set to `TRUE` -- will
#' call `extrafont::loadfonts()` to register non-core fonts with R PDF & PostScript
#' devices. If you are running under Windows, the package calls the same function
#' to register non-core fonts with the Windows graphics device.
#'
#' @md
#' @note This will take care of ensuring PDF/PostScript usage. The location of the
#'   font directory is displayed after the base import is complete. It is highly
#'   recommended that you install them on your system the same way you would any
#'   other font you wish to use in other programs.
#' @export
import_inter <- function() {
  inter_font_dir <- system.file("fonts", "inter", package = "ucscthemes")
}



#' ucsc theme fonts
#'
#' Returns family name of ucsc fonts, to
#' be used in plots. If for instance used the the
#' ggplot2-theme functions.
#'
#' @param type body or title font type
#'
#' @export
ucsc_font <- function(type = c("body", "title")) {
  type <- match.arg(
    type,
    c("body", "title")
  )

  switch(type,
    "body" = font_inter,
    "title" = font_robo
  )
}


## diff fonts NA
#' @rdname Roboto
#' @md
#' @note `font_rob` (a.k.a. "`Roboto`") is not available on
#'     Windows and will throw a warning if used in plots.
#' @description `font_robo_` == "`Roboto `"
#' @export
font_robo <- "Roboto"


#' @rdname Inter
#' @md
#' @note `font_intr` (a.k.a. "`Inter`") is not available on
#'     Windows and will throw a warning if used in plots.
#' @description `font_intr` == "`Inter`"
#' @export
font_inter <- "Inter"
