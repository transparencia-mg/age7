### Dockerfile atualizado para proxy, vim com mouse, e R 4.1 via Ubuntu Focal

# 1. Imagem base Python slim Debian Bullseye
FROM python:3.9.12-slim-bullseye

# 2. Diretório de trabalho
WORKDIR /work_dir

# 3. Proxy para build e runtime
ARG HTTP_PROXY=http://10.100.127.232:8080
ARG HTTPS_PROXY=http://10.100.127.232:8080
ENV http_proxy=${HTTP_PROXY} \
    https_proxy=${HTTPS_PROXY}

# 4. Copia requirements (Python)
COPY requirements.txt ./

# 5. Instala ferramentas essenciais e configura proxy no apt
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      apt-transport-https ca-certificates curl software-properties-common dirmngr \
      build-essential git wget jq nano git-lfs rsync \
      libcurl4-openssl-dev libssl-dev libxml2-dev \
      libfontconfig1-dev libharfbuzz-dev libfribidi-dev \
      libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev \
      libcairo2-dev libicu-dev libgit2-dev libssh2-1-dev \
      g++ make && \
    rm -rf /var/lib/apt/lists/*

# 6. Configura Git global
RUN git config --global --add safe.directory /work_dir && \
    git config --global user.name "Gabriel Braico Dornas" && \
    git config --global user.email "gabrielbdornas@gmail.com"

# 7. Instala Python e dependências
RUN apt-get update && \
    apt-get install -y python3 python3-venv python3-dev libpq-dev && \
    rm -rf /var/lib/apt/lists/*
RUN pip install --no-cache-dir -r requirements.txt

# 8. Instala Vim com suporte a mouse e colagem via botão direito
RUN apt-get update && \
    apt-get install -y vim-nox && \
    echo "set mouse=a" >> /etc/vim/vimrc.local && \
    rm -rf /var/lib/apt/lists/*

# 9. Instala R 4.1 via repositório Ubuntu Focal-CRAN40
RUN curl -fsSL https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc \
      | gpg --dearmor \
      | tee /usr/share/keyrings/cran-archive-keyring.gpg > /dev/null && \
    echo "deb [signed-by=/usr/share/keyrings/cran-archive-keyring.gpg] https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/" \
      | tee /etc/apt/sources.list.d/cran.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends r-base r-base-dev && \
    rm -rf /var/lib/apt/lists/*

# 10. Instala pacotes R necessários do CRAN
RUN Rscript -e 'install.packages(c(
      "purrr", "yaml", "systemfonts", "gdtools", 
      "openssl", "curl", "httr", "covr", "waldo", 
      "testthat", "data.table", "jsonlite"
    ), repos="https://cloud.r-project.org", dependencies=TRUE)'

# 11. Instala remotes e pacotes GitHub
RUN Rscript -e 'install.packages("remotes", repos="https://cloud.r-project.org")'
RUN Rscript -e 'remotes::install_github("rstudio/blastula", dependencies=TRUE, type="source")'
RUN Rscript -e 'remotes::install_github("transparencia-mg/dtamg-r", dependencies=TRUE, type="source")'

# 12. Alias útil para o shell interativo
RUN echo "alias ll='ls -la'" >> /etc/bash.bashrc

# 13. Finalização
RUN echo "=== Ambiente instalado com proxy, vim+mouse e R 4.1+ ==="

# 14. Entrypoint
ENTRYPOINT ["bash"]
CMD ["-l"]

