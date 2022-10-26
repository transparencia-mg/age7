library(dotenv)

resource_name <- commandArgs(trailingOnly = TRUE)

df <- "datapackage.yaml"

df <- as.data.frame(t(df))

sql_query <- dtamg::parse_sql(df, gsub("-", "_", resource_name))

writeLines(sql_query, glue::glue("scripts/sql/{resource_name}.sql"))
