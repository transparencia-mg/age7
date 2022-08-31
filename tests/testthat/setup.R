library(data.table); library(validate); library(dtamg); library(dotenv); library(purrr)

reticulate::use_python(here::here(Sys.getenv("PYTHON_PATH")), required = TRUE)
