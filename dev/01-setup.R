
# Prerequisites ----

available::available("pkgsetup")
usethis::use_directory("dev", ignore = TRUE)
fs::file_create("dev/01-setup.R")
rstudioapi::navigateToFile("dev/01-setup.R")
usethis::use_roxygen_md()
usethis::use_news_md()
person(
  given = "Niccolò",
  family = "Salvini",
  email = "niccolo.salvini27@gmail.com",
  role = c("aut", "cre"),
  comment = c(ORCID = "0000-0002-3444-4094")
)

usethis::use_gpl3_license()
usethis::use_package_doc()

# README ----
usethis::use_readme_rmd()
usethis::use_logo("~/Pictures/hex-ucscthemes.png")
usethis::use_cran_badge()
usethis::use_lifecycle_badge("Maturing")


usethis::use_code_of_conduct()
usethis::use_spell_check()
spelling::spell_check_package()
spelling::update_wordlist()



## Test suit .-----
usethis::use_testthat()
usethis::use_test("foo") # `test_that("foo works", expect_null(foo()))`
devtools::test()         # see it fails!!
usethis::use_r("foo")    # define `foo <- function() NULL`
devtools::test()         # see it passes!


usethis::use_tidy_description()

devtools::check_man()
devtools::test()
devtools::check()


usethis::use_github_action("pkgdown")
usethis::use_github_actions_badge("pkgdown")


## Continuous Integration ----

usethis::use_github_action("lint")
usethis::use_github_actions_badge("lint")


## R-CDM-check and coverage ----

usethis::use_github_actions_badge("R-CMD-check")

usethis::use_github_action("test-coverage",
                           save_as = "covr.yaml"
)
usethis::use_github_actions_badge("covr")



usethis::use_tidy_description()
devtools::check_man()

spelling::spell_check_package()
spelling::update_wordlist()

devtools::check()

usethis::use_version("dev")


## Optional ----
usethis::use_pipe()


## Add `tibble` suppot ---
usethis::use_tibble()
