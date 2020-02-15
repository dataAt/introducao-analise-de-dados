'
Script para "compilar" o bookdown
'
# Pode ser necessário alterar os comandos abaixo (Caso seu ambiente esteja
# configurado de forma diferente)
venvCommand <- 'python3 -m venv venv';
installCommand <- 'venv/bin/pip3 install pandas plotnine requests';

if (!dir.exists('venv')) {
  system(venvCommand);
  system(installCommand);
}

# é necessário alterar o path para o diretório com os materiais em .Rmd
setwd("./")
# bookdown::render_book("index.Rmd", bookdown::gitbook(lib_dir = "libs"))

options(tinytex.verbose = TRUE)
bookdown::render_book("index.Rmd", bookdown::pdf_book())
