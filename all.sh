#!/bin/bash
{
git pull origin main && \
make clean && \
make parse && \
make full-extract && \
make ingest && \
make data && \
make validate && \
make check-validation && \
make report && \
make datapackage.json && \
make test && \
make build && \
make update && \
git add . && git commit -m "Atualização age7"
} > logs/all.txt
echo $? > logs/exit-code.txt
git add . && git commit -m "Atualização age7 - logs notificação"
git push origin main