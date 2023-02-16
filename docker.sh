#!/bin/bash
source $HOME/.bash_profile
docker run -i --rm -v $PROJECT_PATH:/work_dir \
     -v /pwd:/pwd \
     -v $PROJECT_PATH/.local/share/AzureR:/root/.local/share/AzureR \
     -e CKAN_HOST=$CKAN_HOST \
     -e CKAN_KEY=$CKAN_KEY \
     -e HTTPS_PROXY=$HTTPS_PROXY \
     -e DB_HOST=$DB_HOST \
     -e DB_USER=$DB_USER \
     -e DB_DATABASE=$DB_DATABASE \
     -e DB_PASSWORD=$DB_PASSWORD \
     -e RETICULATE_PYTHON=$RETICULATE_PYTHON \
     dtamg/age7:latest ./all.sh
