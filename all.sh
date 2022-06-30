#!/bin/bash
{
make clean && \
make parse && \
make full-extract && \
make ingest && \
make data && \
make validate && \
make check-validation && \
make datapackage.json && \
make test && \
make build && \
make update
} > logs/all.txt
echo $? > logs/exit-code.txt
make notify
