ucsc_colors <- c(
  blue = "#003157",
  white = "#fffeff",
  darkblue = "#01041d",
  grey1 = "#d7d2cb",
  grey5 = "#b8ab9e"
)

#' Function to extract ucsc colours as hex codes
#'
#' @param ... Character names of ucsc_colors
#' @export
ucsc_cols <- function(...) {
  cols <- c(...)

  if (is.null(cols)) {
    return(ucsc_colors)
  }

  cols <- match.arg(cols,
    names(ucsc_colors),
    several.ok = TRUE
  )

  ucsc_colors[cols]
}

ucsc_palettes <- list(
  `main` = ucsc_cols("darkblue", "blue", "white"),
  `bw` = ucsc_cols("darkblue", "white"),
  `greys` = ucsc_cols("grey1", "grey5"),
  `bluewhite` = ucsc_cols("blue", "white"),
  `blueblack` = ucsc_cols("blue", "darkblue")
)

#' Return function to interpolate a ucsc color palette
#'
#' @param palette Character name of palette in ucsc_palettes
#' @param reverse Logical indicating whether the palette should be reversed
#' @param ... Additional arguments to pass to \code{\link[grDevices]{colorRampPalette}}
#' @export
ucsc_pal <- function(palette = "redblack", reverse = FALSE, ...) {
  palette <- match.arg(palette, names(ucsc_palettes))

  pal <- ucsc_palettes[[palette]]

  if (reverse) pal <- rev(pal)

  grDevices::colorRampPalette(pal, ...)
}
