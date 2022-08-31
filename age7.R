library(yaml); library(purrr); library(data.table); library(jsonlite)

# gh pr list --assignee @me
# gh pr list --assignee kesiabomfa
# status: Todo; Open; Assigned; Merge; Merged
#======================================================================

age7_status <- read_yaml("age7.yaml")
age7_dp <- read_json("datapackage.json")