#!/bin/bash

# Detecta número de CPUs disponíveis
CPU_TOTAL=$(nproc)
# Reserva 1 CPU para o sistema
CPU_MAKE=$((CPU_TOTAL - 1))
# Caso a máquina tenha só 1 CPU, use 1 para não dar erro
if [ "$CPU_MAKE" -lt 1 ]; then
  CPU_MAKE=1
fi

{
  git pull origin main && \
  make clean && \
  make -j $CPU_MAKE parse && \
  make -j $CPU_MAKE full-extract && \
  make -j $CPU_MAKE ingest && \
  make -j $CPU_MAKE data && \
  make -j $CPU_MAKE validate && \
  make -j $CPU_MAKE check-validation && \
  make -j $CPU_MAKE report && \
  make -j $CPU_MAKE datapackage.json && \
  make -j $CPU_MAKE test && \
  make -j $CPU_MAKE build && \
  make -j $CPU_MAKE update && \
  git add . && git commit -m "Atualização age7"
} > logs/all.txt

echo $? > logs/exit-code.txt

git add . && git commit -m "Atualização age7 - logs notificação"
git push origin main
