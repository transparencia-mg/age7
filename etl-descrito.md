# título

### finalidade

Este arquivo serve para descrever como ocorre o fluxo de extração, transofrmação e carga (ETL) nos dados do [Portal de dados Abertos/PdA](https://dados.mg.gov.br/dataset), a partir do banco de dados do [Portal de Transparência/PdT](https://www.transparencia.mg.gov.br/).  As alterações desse banco serão captadas, interpretadas, processadas e refletidas nos datasets correspondentes do PdA.

## Conteúdo [subtítulo - explicação do fluxo/processo]

O processo de ETL dos dados se dá a partir de uma atualização diária das tabelas do PdT para os datasets do PdA. As modificações das tabelas do PdT são incluídas diariamente na pasta [`datasets`](https://github.com/transparencia-mg/age7/tree/main/datasets), [COMO]?  

O arquivo `all.sh` é o centro coordenador do processo de ETL do Portal de Dados Abertos. Ele reúne e encadeia as principais funções para encadear as ações necessárias, como:

  - atualização na documentação dos datasets;

  - extração dos dados atualizados do banco do PdT;

  - validação dos datasets de acordo com o padrão de metadados de dados sem fricção (Frictionless Data Specs);

  - atualização dos metadados dos datasets em pacotes de dados padrão Frictionless Data (`datapackage.json`);

  - teste [?]

  - update

  - compliance do processo [logs, erros]

  - atualização do repositório https://github.com/transparencia-mg/age7

Cada linha do `all.sh` representa um comando ou instância com um argumento ou comando subsequebnte, p. ex.: `make` + `ingest`.

As barras invertidas ao final de cada linha de comando com `make` são uma separação didática/visual dos próprios comandos.

Para os comandos das linhas 2 a 12, e linha 17, o operador `&&` indica que o comando da próxima linha somente será executado se o da linha atual estiver completado.
