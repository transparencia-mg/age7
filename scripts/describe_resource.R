library(etlpdt); library(reticulate); library(ROracle)

use_python("~/.virtualenvs/frictionless/bin/python", required = TRUE)

arg <- commandArgs(trailingOnly = TRUE)

extract_table_data(tbl = arg, dir = "data")

filepath <- file.path("data", paste0(tolower(arg), ".csv"))
R.utils::gzip(filepath)
extract_table_metadata(tbl = arg, dir = "schemas")
