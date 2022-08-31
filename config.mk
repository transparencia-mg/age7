RESOURCES := $(shell Rscript -e "cat(purrr::map_chr(yaml::read_yaml('datapackage.yaml')[['resources']], 'name'))")

DATA_FILES := $(shell Rscript -e "cat(purrr::map_chr(yaml::read_yaml('datapackage.yaml')[['resources']], 'path'))")

DATA_RAW_FILES := $(subst csv.gz,csv, $(subst data,data/raw, $(DATA_FILES)))

DATA_INGEST_FILES = $(subst data/raw,data/staging, $(shell rsync --checksum --dry-run --out-format='%f' data/raw/* data/staging/))
# --out-format=FORMAT
#   This allows you to specify exactly what the rsync client outputs
#   to the user on a per-update basis.  The format is a text  string
#   containing  embedded  single-character escape sequences prefixed
#   with a percent (%) character.  For a list of the possible escape
#   characters, see the "log format" setting in the rsyncd.conf man-
#   page (ie. man rsyncd.conf).

SQL_FILES := $(subst csv.gz,sql, $(subst data,scripts/sql, $(DATA_FILES)))

LOAD_FILES := $(subst csv.gz,txt, $(subst data,logs/load, $(DATA_FILES)))

VALIDATION_FILES := $(subst csv.gz,json, $(subst data,logs/validate, $(DATA_FILES)))

TEST_FILES := $(subst .R,.Rout, $(subst tests/testthat,logs/tests, $(shell ls tests/testthat/test_*)))

DATASETS_FILES := $(shell Rscript -e "consultas <- names(yaml::read_yaml('age7.yaml')[['consultas']]); cat(glue::glue('logs/update/{consultas}.txt'))")