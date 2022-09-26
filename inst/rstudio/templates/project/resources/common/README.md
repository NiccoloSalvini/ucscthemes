# Welcome to the _course_

<!-- badges: start -->
[![Netlify Status](https://api.netlify.com/api/v1/badges/7494142a-3046-427b-bbb5-378efc2663a6/deploy-status)](https://app.netlify.com/sites/sbd-labs-22-23/deploys)
<!-- badges: end -->

This is the official repository containing the lab course materials for Statistics & Big Data. This course skeleton ig generated throughthe package `ucscthemes` with R Markdown and **bookdown** (https://github.com/rstudio/bookdown) styled with bs4. If you are willing to reproduce a course though this template please follow [this vignette](https://ucscthemes.netlify.app/articles/how-to-create-course.html).


## ♻️ Reproducibility _(for developers)_

If you are willing to reproduce this book on your system please make sure to have installed `git`, `Rstudio` and relatively new version of R. Then follow the steps below.

### Usage of this repo

Each **bookdown** chapter is an .Rmd file, and each .Rmd file can contain one (and only one) chapter. A chapter *must* start with a first-level heading: `# A good chapter`, and can contain one (and only one) first-level heading.

Use second-level and higher headings within chapters like: `## A short section` or `### An even shorter section`.

The `index.Rmd` file is required, and is also your first book chapter. It will be the homepage when you render the book.

### Render book

clone the repo locally adn then access to the main directory.

```
git clone https://github.com/NiccoloSalvini/sbd_22-23.git
```

You can render the HTML version of this example book without changing anything:

1. Find the **Build** pane in the RStudio IDE, and

1. Click on **Build Book**, then select your output format, or select "All formats" if you'd like to use multiple formats from the same book source files.

Or build the book from the R console:

```{r, eval=FALSE}
bookdown::render_book()
```

To render this example to PDF as a `bookdown::pdf_book`, you'll need to install XeLaTeX. You are recommended to install TinyTeX (which includes XeLaTeX): <https://yihui.org/tinytex/>.

### Preview book

As you work, you may start a local server to live preview this HTML book. This preview will update as you edit the book when you save individual .Rmd files. You can start the server in a work session by using the RStudio add-in "Preview book", or from the R console:

```{r eval=FALSE}
bookdown::serve_book()
```


```{r include=FALSE}
# automatically create a bib database for R packages
knitr::write_bib(c(
  .packages(), 'bookdown', 'knitr', 'rmarkdown'
), 'packages.bib')
```



