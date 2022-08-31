# Instalação e configuração

## Programas CLI

### make, git, bash

Ferramentas padronizadas.

### jq

Faça download do programa `jq` no site <https://stedolan.github.io/jq/download/>. 

Renomeie o arquivo baixado para `jq` e salve esse arquivo na pasta `C:\Program Files\Git\usr\bin`. 

Para confirmar a instalação e configuração bem sucedida do `jq`, execute em uma nova linha de comando

```bash
jq --version
```

Caso o `jq` não tenha sido detectado, pode ser necessário a instalação do <https://scoop.sh/>, um gerenciador que executará tal função, a partir das etapas seguintes:

- Pressione as teclas **Windows + R**. Digite PowerShell e tecle Enter
- Ao abrir o Prompt de comando, Digite PowerShell e pressione Enter
- Em seguida digite o comando abaixo:
```
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
scoop install jq
````
Digite o comando `jq --version` numa nova `bash` cell para confirmar a instação do `jq`.

### git LFS

Instruções para instalação do `git LFS` estão disponíveis em <https://git-lfs.github.com/>. 

Para configurar execute na linha de comando

```bash
git lfs install
Git LFS initialized.
```

Esse procedimento de inicialização precisa ser executado somente uma vez por instalação.

Para confirmar a instalação e configuração bem sucedida execute na linha de comando

```bash
git lfs --version
```

## R

Esse projeto utiliza o [R versão 4.1.0](https://www.r-project.org/). Faça a instalação ou atualização antes de continuar.

O pacote [renv](https://rstudio.github.io/renv/index.html) é utilizado para gerenciamento de dependências. 
Ao inicializar o projeto do Rstudio, se as seguintes mensagens forem apresentadas

```r
# Bootstrapping renv 0.13.2 --------------------------------------------------
* Downloading renv 0.13.2 from CRAN ... OK
* Installing renv 0.13.2 ... Done!
* Successfully installed and loaded renv 0.13.2.
* Project 'path/to/project/' loaded. [renv 0.13.2]
* The project library is out of sync with the lockfile.
* Use `renv::restore()` to install packages recorded in the lockfile.
```

Siga as instruções e execute

```r
renv::restore()
```

Instale também de forma excepcional

```r
install.packages("remotes")
remotes::install_github("transparencia-mg/dtamg-r@v0.2.0")
```

Caso contrário pode ser necessário

```r
install.packages("renv") # instalação do pacote renv
renv::init() # instalação dos pacotes listados no arquivo renv.lock
```

Essa instalação demora vários minutos.

As mensagens acima somente serão exibidas na primeira vez que o `renv` for inicializado. 
Nas sessões seguintes, a mensagem indicativa de sucesso é simplesmente

```r
* Project 'path/to/project/' loaded. [renv 0.13.2]
```
## Rtools

É necessário baixar e instalar o [Rtools 4.0](https://cran.r-project.org/bin/windows/Rtools/), que tem uma versão compatível com o R 4.1.0.

Após instalado, é necessário colocar o local das ferramentas _make utilities_ (bahs, make, etc) do Rtools no PATH. Sem essa indicação, o R não irá reconhecer essas ferramentas necessárias. 

Para encontrar o local correto, procure no Windows Explorer, a pasta do `RTools > 4.0 > usr > bin` (ou `RBuildTools > 4.0 > usr > bin`, se tiver baixado essa alternativa). Ao encontrar, copie o endereço e cole no path da variável de ambiente, conforme etapas a seguir, no windows:

 1. digitar 'variáveis de ambiente' na barra de busca ao lado do botão iniciar do winsows (canto inferior esquerdo);
 2. após aberta a caixa de diálogo 'Propriedades do Sistema', clicar no botão 'Variáveis de Ambiente' no canto inferior direito;
 3. após aberta nova caixa de diálogo 'Variáveis de Ambiente', buscar pela variável ``Path`` na lista de 'Variáveis de usuário para {USER}', e dar um duplo-clique nessa linha (ou selecioná-la e clicar em 'editar');
 4. incluir ``C:\rtools40\usr\bin`` ou ``C:\RBuildTools\4.0\usr\bin`` como variável nova (a depender, se Rtools ou RBuidTools)
 5. em seguida, clicar em OK (2 vezes)

Outra forma de se apontar esse local é criar um arquivo ``.Renviron`` na pasta ``Documentos`` com o conteúdo

 ```` PATH="${RTOOLS40_HOME}\usr\bin;${PATH}"  ```` ou ```` PATH="${RBUILDTOOLS40_HOME}\usr\bin;${PATH}"````
 
Para verificar se o Rtools teve o ``PATH`` devidamente mapeado, restartar o R e digitar no console: ````Sys.which("make")````. O resultado que indica o ``PATH`` deve então aparecer:

````## "C:\\rtools40\\usr\\bin\\make.exe"````
ou 
````## "C:\\rbuildtools40\\usr\\bin\\make.exe"````



## Python

Para validação dos recursos com `make validate` é necessário a instalação do Python e do pacote `frictionless`. 

Vamos gerenciar nossa instalação do python e dos pacotes python utilizando o miniconda. Faça a instalação seguindo as instruções do link <https://docs.conda.io/en/latest/miniconda.html>. Para confirmar a instalação e configuração bem sucedida execute na linha de comando

```bash
conda --version
```

Agora execute os seguintes comandos no console do R (ie. via Rstudio):

```R
reticulate::conda_create("age7") # criacao de ambiente conda especifico para esse projeto
reticulate::conda_install("age7", "frictionless==4.12.2") # instalacao da versao correta do frictionless
```

