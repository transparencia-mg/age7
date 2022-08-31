arg <- commandArgs(trailingOnly = TRUE)

rmarkdown::render("datapackage.Rmd", output_dir = arg)
