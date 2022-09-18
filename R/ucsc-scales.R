
#' Colour and fill scale constructors for ucsc colors
#'
#' These scale functions help alter ggplot2 colour and fill
#' to colours in the ucsc branding scheme.
#' See the colour palettes in \code{\link{ucsc_pal}} for
#' variations you can choode from.
#'
#' @param palette Character name of palette in \code{\link{ucsc_pal}}.
#' @param discrete Logical indicating whether colour aesthetic is discrete or not
#' @param reverse Logical indicating whether the palette should be reversed
#' @param ... Additional arguments passed to \code{\link[ggplot2]{discrete_scale}} or
#'            \code{\link[ggplot2]{scale_color_gradientn}}, used respectively when discrete is TRUE or FALSE
#' @export
#' @rdname scales_ucsc
#' @examples
#' library(ggplot2)
#'
#' ggplot(mtcars, aes(mpg, disp, colour = cyl)) +
#'   geom_point(size = 5) +
#'   scale_colour_ucsc(discrete = FALSE)
#'
#' ggplot(mtcars, aes(mpg, disp, colour = cyl)) +
#'   geom_point(size = 5) +
#'   scale_colour_ucsc(discrete = FALSE, reverse = TRUE)
#'
#' ggplot(mtcars, aes(mpg, disp, colour = cyl)) +
#'   geom_point(size = 5) +
#'   scale_colour_ucsc(discrete = FALSE)
#'
#' ggplot(mtcars, aes(mpg, disp, colour = factor(cyl))) +
#'   geom_point(size = 5) +
#'   scale_colour_ucsc()
scale_colour_ucsc <- function(palette = "bluewhite", discrete = TRUE, reverse = FALSE, ...) {
  pal <- ucsc_pal(palette = palette, reverse = reverse)

  if (discrete) {
    ggplot2::discrete_scale("color", paste0("ucsc_", palette), palette = pal, ...)
  } else {
    ggplot2::scale_colour_gradientn(colours = pal(256), ...)
  }
}

#' @export
#' @rdname scales_ucsc
scale_color_ucsc <- scale_colour_ucsc

#' @export
#' @rdname scales_ucsc
scale_fill_ucsc <- function(palette = "redblack", discrete = TRUE, reverse = FALSE, ...) {
  pal <- ucsc_pal(palette = palette, reverse = reverse)

  if (discrete) {
    ggplot2::discrete_scale("fill", paste0("ucsc_", palette), palette = pal, ...)
  } else {
    ggplot2::scale_fill_gradientn(colours = pal(256), ...)
  }
}
