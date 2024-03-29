% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ucsc-themes.R
\name{theme_ucsc}
\alias{theme_ucsc}
\alias{theme_ucsc_dark}
\alias{theme_ucsc_void}
\alias{theme_ucsc_dark_void}
\title{ggplot themes for ucsc}
\usage{
theme_ucsc(base_size = 11.5)

theme_ucsc_dark(base_size = 10)

theme_ucsc_void(base_size = 10)

theme_ucsc_dark_void(base_size = 10)
}
\arguments{
\item{base_size}{text size}
}
\description{
A selection of themes that fit with the
ucsc branding instructions.
}
\details{
You should \code{\link[=import_roboto]{import_roboto()}} first and also install the fonts on your
system before trying to use this theme.

\itemize{
\item{theme_ucsc} - base theme for ucsc
\item{theme_ucsc_dark} - dark/inverted version of base theme
\item{theme_ucsc_void} - base theme without axis information or grid
\item{theme_ucsc_darl_void} - dark/inverted theme without axis information or grid
}
}
\examples{
\dontrun{
library(ggplot2)

ggplot(mtcars, aes(mpg, disp, colour = cyl)) +
  geom_point(size = 5) +
  theme_ucsc()

ggplot(mtcars, aes(mpg, disp, colour = cyl)) +
  geom_point(size = 5) +
  theme_ucsc_dark()

ggplot(mtcars, aes(mpg, disp, colour = cyl)) +
  geom_point(size = 5) +
  theme_ucsc_void()

ggplot(mtcars, aes(mpg, disp, colour = factor(cyl))) +
  geom_point(size = 5) +
  theme_ucsc_dark_void()
}
}
