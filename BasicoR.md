cursoR
================
Felipe Carvalho
2018-09-15

-   [Básico do R](#básico-do-r)
-   [Para saber mais](#para-saber-mais)
-   [Materias utilizados como base](#materias-utilizados-como-base)

Básico do R
-----------

1.  Definição de variáveis

1.1 Tipos primitivos

``` r
  a <- 7L
  b = 14.01
  42 -> c
  k <- FALSE
  g <- 12i # tipo complexo*
  couse <- 'cool'
  
  
  # Para ver inspecionar o valor das variáveis
  print(a)
```

    ## [1] 7

``` r
  b
```

    ## [1] 14.01

``` r
  cat(c)
```

    ## 42

``` r
  # Para ver as classes[1]
  class(a)
```

    ## [1] "integer"

``` r
  class(b)
```

    ## [1] "numeric"

``` r
  class(c)
```

    ## [1] "numeric"

``` r
  class(k)
```

    ## [1] "logical"

``` r
  class(couse)
```

    ## [1] "character"

``` r
  # Para remove-las
  rm(a)
```

1.2 Tipos de dados estruturados

``` r
  # Vetores[2]
  vetor_boleano <- c(FALSE, TRUE, TRUE, FALSE)
  vetor_numerico <- c(3.14, 6.28, 2.3)
  vetor_char <- c('ola', 'pessoal', 'xd')
  v01 <- 1:4
  v02 <- 84:76
  v03 <- seq(from=1, to=10)
  v06 <- rep('DATA SCIENCE', 50)
  v08 <- paste("A", 'B', 'C') 
  v11 <- paste0("EX_", 1:5)
  
  # Podemos misturar tudo
  vetor_misturado <- c("sou legal", FALSE, 21)
  # Vetor atomico tem um único tipo, então se misturarmos, vai converter para o tipo mais forte:
  #1 - character
  #2 - complex
  #3 - numeric
  #4 - integerc
  #5- logical
  # Vetor misturado será convertido em qual tipo?
  
  # Conferirndo a variável e tamanho
  is.atomic(vetor_boleano)
```

    ## [1] TRUE

``` r
  is.list(vetor_boleano)
```

    ## [1] FALSE

``` r
  length(vetor_boleano)
```

    ## [1] 4

``` r
  # Lista
  lista_boleano <- list(FALSE, TRUE, TRUE, FALSE)
  lista_inteiro <- list(12L, 10L, 7L)
  lista_misturada <- list(FALSE, 12L, 't', 2i)
  
  # Conferindo o tamanho da lista
  is.list(lista_boleano)
```

    ## [1] TRUE

``` r
  is.recursive(lista_boleano)
```

    ## [1] TRUE

``` r
  is.atomic(lista_boleano)
```

    ## [1] FALSE

``` r
  is.list(lista_inteiro)
```

    ## [1] TRUE

``` r
  # Array
  a <- array(c('green','yellow'),dim = c(3,3,2)); a
```

    ## , , 1
    ## 
    ##      [,1]     [,2]     [,3]    
    ## [1,] "green"  "yellow" "green" 
    ## [2,] "yellow" "green"  "yellow"
    ## [3,] "green"  "yellow" "green" 
    ## 
    ## , , 2
    ## 
    ##      [,1]     [,2]     [,3]    
    ## [1,] "yellow" "green"  "yellow"
    ## [2,] "green"  "yellow" "green" 
    ## [3,] "yellow" "green"  "yellow"

``` r
  class(a)
```

    ## [1] "array"

``` r
  typeof(a)
```

    ## [1] "character"

``` r
  is.atomic(a)
```

    ## [1] TRUE

``` r
  # Por que não é um vetor?
  is.vector(a)
```

    ## [1] FALSE

``` r
  is.list(a)
```

    ## [1] FALSE

``` r
  # Matriz
   m2 <- matrix(data = c(1:25, rep("legal", 5)), nrow = 5, ncol=6)
   
   is.matrix(m2)
```

    ## [1] TRUE

``` r
   is.array(m2)
```

    ## [1] TRUE

``` r
   m2[5,6]
```

    ## [1] "legal"

1.3 DataFrame

``` r
   # DataFrame[3]
   data_frame <- data.frame(Risco=c(FALSE,FALSE, FALSE, FALSE,TRUE), Animal=c("Cachorro", "Gato", "Capivara", "Girafa", "Macaco"), Periculosidade=c(200, 400, 0, 7, 1000))
  
  # Para ver o tamanho
  length(data_frame)
```

    ## [1] 3

``` r
  # Podemos acessar os valores individuais usando o '$'
  data_frame$Animal
```

    ## [1] Cachorro Gato     Capivara Girafa   Macaco  
    ## Levels: Cachorro Capivara Gato Girafa Macaco

``` r
  # Acessando os valores por indices
  data_frame[,2]
```

    ## [1] Cachorro Gato     Capivara Girafa   Macaco  
    ## Levels: Cachorro Capivara Gato Girafa Macaco

``` r
  data_frame[2,]
```

    ##   Risco Animal Periculosidade
    ## 2 FALSE   Gato            400

``` r
  data_frame[3,2]
```

    ## [1] Capivara
    ## Levels: Cachorro Capivara Gato Girafa Macaco

``` r
  # Visualização das lihas iniciais
  head(data_frame)
```

    ##   Risco   Animal Periculosidade
    ## 1 FALSE Cachorro            200
    ## 2 FALSE     Gato            400
    ## 3 FALSE Capivara              0
    ## 4 FALSE   Girafa              7
    ## 5  TRUE   Macaco           1000

``` r
  # Visualização das linhas finais
  tail(data_frame)
```

    ##   Risco   Animal Periculosidade
    ## 1 FALSE Cachorro            200
    ## 2 FALSE     Gato            400
    ## 3 FALSE Capivara              0
    ## 4 FALSE   Girafa              7
    ## 5  TRUE   Macaco           1000

``` r
  # Nome das colunas
  colnames(data_frame)
```

    ## [1] "Risco"          "Animal"         "Periculosidade"

``` r
  # Nome das linhas
  rownames(data_frame)
```

    ## [1] "1" "2" "3" "4" "5"

``` r
  # Quantidade de colunas
  ncol(data_frame)
```

    ## [1] 3

``` r
  # Quantidade de linhas
  nrow(data_frame)
```

    ## [1] 5

``` r
  # Podemos observar a estrutura
  str(data_frame)
```

    ## 'data.frame':    5 obs. of  3 variables:
    ##  $ Risco         : logi  FALSE FALSE FALSE FALSE TRUE
    ##  $ Animal        : Factor w/ 5 levels "Cachorro","Capivara",..: 1 3 2 4 5
    ##  $ Periculosidade: num  200 400 0 7 1000

``` r
  # Algumas estatísticas básicas 
  summary(data_frame)
```

    ##    Risco              Animal  Periculosidade  
    ##  Mode :logical   Cachorro:1   Min.   :   0.0  
    ##  FALSE:4         Capivara:1   1st Qu.:   7.0  
    ##  TRUE :1         Gato    :1   Median : 200.0  
    ##  NA's :0         Girafa  :1   Mean   : 321.4  
    ##                  Macaco  :1   3rd Qu.: 400.0  
    ##                               Max.   :1000.0

1.  Operações Básicas

2.1 Dicas úteis

``` r
  # Para usar algum pacote
  library(tidyverse)

  # Para procurar por um pacote
  ??ggsom

  # Para instalar algum pacote que esteja no CRAN [4]
  #install.packages("meupacotefavorite")

  # Para ler sobre alguma função
  ?sum()
  
  # Para verificar seu diretório atual
  getwd() 
  
  # Para definir um novo diretório
  setwd("~/R/ggsom/")
  
  # Para ler conjunto de dados
  df <- read.csv2("~/Dados/pesquisa_google_trend/convolutional_neural_networks.csv", 
            header = TRUE, sep = ",")
  
  # Dependendo do tamanho do dataset, vale a pena usar fread() ou read_csv()
```

2.2 Estatisca básica

``` r
  # Vamos usar o dado do filme Star Wars do pacote dplyr*
  suppressMessages(library(dplyr))
  starwars <- dplyr::starwars
  
  # Desse modo o dataset é carregado no nosso ambiente, use ls()
  data(starwars)
  
  # Vamos visualizar o dado
  dplyr::glimpse(starwars)
```

    ## Observations: 87
    ## Variables: 13
    ## $ name       <chr> "Luke Skywalker", "C-3PO", "R2-D2", "Darth Vader", ...
    ## $ height     <int> 172, 167, 96, 202, 150, 178, 165, 97, 183, 182, 188...
    ## $ mass       <dbl> 77.0, 75.0, 32.0, 136.0, 49.0, 120.0, 75.0, 32.0, 8...
    ## $ hair_color <chr> "blond", NA, NA, "none", "brown", "brown, grey", "b...
    ## $ skin_color <chr> "fair", "gold", "white, blue", "white", "light", "l...
    ## $ eye_color  <chr> "blue", "yellow", "red", "yellow", "brown", "blue",...
    ## $ birth_year <dbl> 19.0, 112.0, 33.0, 41.9, 19.0, 52.0, 47.0, NA, 24.0...
    ## $ gender     <chr> "male", NA, NA, "male", "female", "male", "female",...
    ## $ homeworld  <chr> "Tatooine", "Tatooine", "Naboo", "Tatooine", "Alder...
    ## $ species    <chr> "Human", "Droid", "Droid", "Human", "Human", "Human...
    ## $ films      <list> [<"Revenge of the Sith", "Return of the Jedi", "Th...
    ## $ vehicles   <list> [<"Snowspeeder", "Imperial Speeder Bike">, <>, <>,...
    ## $ starships  <list> [<"X-wing", "Imperial shuttle">, <>, <>, "TIE Adva...

``` r
  # Vamos ver a média de ano de nascimento
  mean(starwars$birth_year)
```

    ## [1] NA

``` r
  # oops... - Observe que o NA atrapalha nossa média,vamos remove-lo
  mean(starwars$birth_year, na.rm = TRUE)
```

    ## [1] 87.56512

``` r
  # Podemos procurar pela menor data de nascimento
  min(starwars$birth_year, na.rm = TRUE)
```

    ## [1] 8

``` r
  # Pelo máximo também
  max(starwars$birth_year, na.rm = TRUE)
```

    ## [1] 896

``` r
  # Desvio padrão 
  sd(starwars$birth_year, na.rm = TRUE)
```

    ## [1] 154.6914

1.  Os ifs da vida...

``` r
  if(starwars$name == "Luke Skywalker"){
    "Faz cara de vilão"
  } else {
    "Faz cara de bonzinho"
  }
  # hackezinho rápido
  vilao <- ifelse(starwars$name == "Luke Skywalker",
         TRUE, FALSE)
  
  # Pense em vetor...
  starwars$name[vilao]
  
  # Foreach
  for(i in starwars$name){
    print(i)
  }
  
  # Um For pouco mais rápido[5]
  for(i in seq_along(starwars$name)){
    print(starwars$name[i])
  }
  # Usando map do pacote purr
  library(purrr)
  purrr::map_chr(starwars$name, print)
```

Para saber mais
---------------

[Números complexos - 1](!https://stat.ethz.ch/R-manual/R-devel/library/base/html/complex.html)

[Tipos númericos em R - 2](!http://uc-r.github.io/integer_double/)

[Diferença entre lista e vetor - 3](!https://www.burns-stat.com/documents/tutorials/impatient-r/)

[CRAN - 4](!https://cran.r-project.org/doc/FAQ/R-FAQ.html#Introduction) [R eficiente - 5](!https://csgillespie.github.io/efficientR/)

Materias utilizados como base
-----------------------------

[Rafael Santos](!https://github.com/rafaeldcsantos/CAP-394)

-   José Roberto M. Garcia
