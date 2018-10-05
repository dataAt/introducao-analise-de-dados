'
Script para "compilar" o bookdown
'

# Talvez seja necessário editar o working dir
bookdown::render_book("index.Rmd", bookdown::gitbook(lib_dir = "libs"))
