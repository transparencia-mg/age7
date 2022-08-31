library(dotenv)

resource_name <- commandArgs(trailingOnly = TRUE)

sql_query <- dtamg::parse_sql("datapackage.yaml", gsub("-", "_", resource_name))
writeLines(sql_query, glue::glue("scripts/sql/{resource_name}.sql"))
