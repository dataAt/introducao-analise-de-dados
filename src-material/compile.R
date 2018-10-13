'
Script para "compilar" o bookdown
'

# Pode ser necessário alterar os comandos abaixo (Caso seu ambiente esteja 
# configurado de forma diferente)
venvCommand <- 'virtualenv venv';
installCommand <- 'venv/bin/pip install pandas plotnine';

if (!dir.exists('venv')) {
  system(venvCommand);
  system(installCommand);
}

# Talvez seja necessário editar o working dir
bookdown::render_book("index.Rmd", bookdown::gitbook(lib_dir = "libs"))
