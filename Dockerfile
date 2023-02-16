FROM python:3.9.12-slim-bullseye
WORKDIR /work_dir
COPY requirements.txt .
ENV RENV_PATHS_LIBRARY /usr/local/lib/R/site-library/
COPY renv.lock .
RUN echo "Initial setup.  This may take a few minutes ..."
RUN apt-get -y update
RUN echo "Installing gcc, g++, make, jq, git and lfs"
RUN apt-get -y install build-essential rsync jq git nano git-lfs wget libcurl4-openssl-dev libssl-dev libxml2-dev libfontconfig1-dev pandoc
RUN git config --global --add safe.directory /work_dir
RUN git config --global user.name "Gabriel Braico Dornas"
RUN git config --global user.email "gabrielbdornas@gmail.com"
RUN echo "Installing python..."
RUN apt-get install -y python3 python3-venv python3-dev libpq-dev
RUN echo "Installing python packages..."
RUN pip install -r requirements.txt
RUN echo "Installing R..."
RUN apt-get install -y --no-install-recommends software-properties-common dirmngr
RUN wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
RUN add-apt-repository "deb https://cloud.r-project.org/bin/linux/debian bullseye-cran40/"
RUN apt-get install -y --no-install-recommends r-base
RUN apt-get install -y r-base-dev # build requirements for R packages such as llapack lblas lgfortran
RUN apt-get install -y libpng-dev # system requirement of png R package
RUN Rscript -e "install.packages('renv')" && Rscript -e 'renv::restore()'
RUN echo "The environment has been installed."