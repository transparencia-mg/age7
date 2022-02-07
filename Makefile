.PHONY: help vars parse extract full-extract ingest data validate notify load all clean

include config.mk

help: 
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}'

datapackage.json: datapackage.yaml schemas/* data/* logs/validate/* schemas/dialect.json README.md CHANGELOG.md CONTRIBUTING.md
	dtamg-py etl-make build-datapackage

init: ## Create boilerplate files for the derivated datapackages
	dtamg-py etl-make build-documentation-folder

parse: $(SQL_FILES)

$(SQL_FILES): scripts/sql/%.sql: scripts/r/parse-sql.R schemas/%.yaml
	Rscript --verbose $< $* 2> logs/parse/$*.Rout

full-extract:
	# python scripts/python/full-extract.py
	dtamg-py etl-make full-extract 2>> logs/full_extract.txt

extract: $(DATA_RAW_FILES) # Extract raw files from external source into data/raw/

$(DATA_RAW_FILES): data/raw/%.csv: scripts/sql/%.sql
	@dtamg-py etl-make extract --resource $* 2>> logs/extract.txt

ingest: $(DATA_INGEST_FILES) ## Ingest raw files (data/raw/) into staging area (data/staging/)

$(DATA_INGEST_FILES): data/staging/%.csv: data/raw/%.csv
	rsync --itemize-changes --checksum data/raw/* data/staging/ 2> logs/ingest.txt

data: $(DATA_FILES) ## Compress staged files (data/staging/) to data/

$(DATA_FILES): data/%.csv.gz : data/staging/%.csv 
	gzip -n < data/staging/$*.csv > data/$*.csv.gz

validate: $(VALIDATION_FILES)

test: $(TEST_FILES)

$(TEST_FILES): logs/tests/test_%.Rout: tests/testthat/test_%.R data/%.csv.gz tests/testthat.R tests/testthat/setup.R renv.lock
	Rscript --verbose -e "testthat::test_file('$<', stop_on_failure=TRUE)" 2> $@

notify:
	Rscript --verbose scripts/r/notify.R 2> logs/notify.Rout

build:
	dtamg-py etl-make build-datapackages 2> logs/build.txt

create:
	dtamg-py etl-make dpckan-create 2> logs/create.txt

update: $(DATASETS_FILES)

$(DATASETS_FILES): logs/update/%.txt: build_datasets/%/datapackage.json
	dpckan dataset update --datapackage build_datasets/$*/datapackage.json > $@

$(VALIDATION_FILES): logs/validate/%.json: data/%.csv.gz schemas/%.yaml
	-dtamg-py etl-make validate -r $* >$@

validate-metadata: ## Valida arquivo yaml com tableschema
	@echo "Validando tableschemas"
	@dtamg-py etl-make validate-tableschemas

vars: 
	@echo 'DATA_FILES:' $(DATA_FILES)

clean:
	rm -rf logs/extract/*
	rm -rf logs/parse/*
	rm -rf logs/tests/*
	rm -rf logs/update/*
	rm -f logs/full_extract.txt
	rm -f logs/ingest.txt
	rm -f logs/build.txt
	rm -f logs/create.txt
	rm -rf data/raw/*
	rm -f datapackage.json
	rm -rf build_datasets
