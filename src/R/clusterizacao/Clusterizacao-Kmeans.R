#'@title Clusterização de dados
#'
#'@description  Em certos casos, no início de uma análise, é necessário entender os dados. A clusterização permite a você verificar se existe alguma similaridade nos dados, ou mesmo se existe alguma característica em comum no conjunto. Existem diversas técnicas de clusterização, cada uma com suas particularidades, estas indo deste simples algoritimos de distância, até mesmo redes neurais.
#' Aqui, vamos aprender a utilizar o KMédias, um algoritimo que através da utilização da distância euclidiana, verifica quais dados tem alguma relação (Pertencem ao mesmo grupo).
#'
#'@author Felipe Carvalho
#'@author Felipe Minino
#'



# Primeiro vamos importar alguns pacotes
library(tidyverse)
library(VIM)

# Vamos baixar o csv
url_dataset <- "http://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data"

# Sim, é possível ler um csv na web, caso não tenha definição no atributo
# vale a pena colocar um 'header = F'
wine <- read.csv2(url_dataset,
                  header = F,
                  sep=",")

# Vou nomear os atributos, (vou traduzir)
wine <- wine %>%
  rename_all( funs (c("tipo",
                      "Alcool",
                      "acido_malico",
                      "cinza",
                      "alcalinidade_cinza",
                      "magnesio",
                      "total_fenolicos",
                      "flavonoides",
                      "nao_flavonoide",
                      "proantocianidina",
                      "intensidade_cor",
                      "hue",
                      "OD280/OD315_diluicao_vinho",
                      "prolina")))

# Se ficou com dúvida no que é ácido málico (assim como eu)
# lá vai: O ácido málico é uma substância naturalmente encontrada em frutas e legumes – como já vimos, uma das mais ricas fontes de ácido málico são as maçãs.
# Também está naturalmente presente nas células do corpo e grandes quantidades de ácido málico são produzidas diariamente pelo corpo. O ácido málico possui muitos benefícios relacionados à saúde, tais como aumentar a imunidade do corpo, melhorar a saúde oral,
# reduzir o risco de acumulação de metais tóxicos no organismo e promover uma pele mais lisa e firme

#https://www.mundoboaforma.com.br/acido-malico-o-que-e-para-que-serve-e-beneficios/
# Tenho formatar isso - Aliás, essa fonte que eu pesquisei é questionável, a gente pode analisar se os vinhos de maça tem mesmo um alto indice de acido malico.
# Agora acho que fica mais fácil pesquisar sobre

## Vamos observar as dimensões
dim(wine)

## Vamos ver se no nosso conjunto contém algum NA
sum(is.na(wine))

## Caso queira algo mais visual...
aggr(wine)

## Vamos transformar o tipo para uma variavel discreta

## O kmeans está implementado no pacote stats do R
## cujo pacote já é integrado (ver isso) no kernel da linguagem
## Pesquise usando - ?stats::kmeans

# Vale ressaltar, esse conjunto de dados é linearmente separável
# ou seja, se traçarmos uma hiperplano veremos um divisao perfeita (ou boa)

# Vamos selecionar alcool e acido malico
cluster_set <- wine %>% select(Alcool,acido_malico) %>%
  mutate(Alcool = as.integer(Alcool),
  acido_malico = as.integer(acido_malico)) %>%
  kmeans(centers = 3)

str(cluster_set)

# Vamos criar um novo conjunto de dados
new_set <- wine %>%
  select(tipo, Alcool, acido_malico) %>%
  mutate(tipo = as.factor(tipo),
         Alcool = as.numeric(as.character(Alcool)),
         acido_malico = as.numeric(as.character(acido_malico)))

# Vamos adicionar os cluster gerados pelo conjunto
new_set$cluster <- as.factor(cluster_set$cluster)

# Represetação gráfica
ggplot(new_set, aes(x=acido_malico, y=Alcool, color=cluster)) + geom_point() +
  scale_y_continuous(breaks = seq(11,15))

# Podemos observar que o conjuto já estava divido, outra coisa,
# esses atributos selecionados não serpara bem o cluster,, as figuras
# são o agrupamentos originas, e o tipo foi o que geramos






