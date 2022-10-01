

#
# Development history
# usethis::use_test("<function_name>")
# usethis::use_r("<function_name>")

#'
#' Check cycles
#' ====================================================================
#'
#' Before pushes
#' --------------------------------------------------------------------
#'
usethis::use_tidy_description()
spelling::spell_check_package()
spelling::update_wordlist()

#'
#' Before pull requests
#' --------------------------------------------------------------------
#'
lintr::lint_package()
goodpractice::gp()

# The following calls run into your (interactive) session
# Use the corresponding RStudio button under the "Build"
# tab to execute them mantaining free your console
# (and running them in a non-interactive session)
devtools::test()
devtools::check()
devtools::build()
devtools::install()

devtools::build_readme()
devtools::build_vignettes()
devtools::build_site()

#'
#' > Update the `NEWS.md` file
#'
usethis::use_version()


#'
#' CRAN submission's cycle
#' ====================================================================
#'

# usethis::use_release_issue() # at the first start only
devtools::build_readme()
devtools::check(remote = TRUE, manual = TRUE)
devtools::check_win_devel()
cran_prep <- rhub::check_for_cran()
