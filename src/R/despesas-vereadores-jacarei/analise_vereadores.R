# Importando os pacotes necessários
library(tidyverse)
library(lubridate)
library(ggthemes)
library(ggthemr)

# Vamos ler os conjuntos de dados
junho <- read.csv2(file="~/R/introducao-analise-de-dados/dados/dados_remuneracao_vereadores-jacarei/jac_junho_2018.csv",
                   sep=",", stringsAsFactors = FALSE)


julho <- read.csv2(file="~/R/introducao-analise-de-dados/dados/dados_remuneracao_vereadores-jacarei/jac_julho_2018.csv",
                   sep=",", stringsAsFactors = FALSE)

agosto <- read.csv2(file="~/R/introducao-analise-de-dados/dados/dados_remuneracao_vereadores-jacarei/jac_agosto_2018.csv",
                   sep=",", stringsAsFactors = FALSE)

# Vamos visualizar nosso conjunto de dados
head(junho, 5)



# Precisamos juntar nossos conjuntos de dados, utilizados
# o bind_rows para reunir os conjuntos pelas linhas, selecionamos
# todas as colunas e criamos levels para poder ordenar nossos meses
conjunto_meses <- bind_rows(junho, julho, agosto) %>%
  select(everything()) %>%
  mutate(Mês = factor(Mês, levels = c("Junho",
                                      "Julho",
                                      "Agosto")))
# Vamos selecionar um tema legal no pacote gthemr,
# quero ver qual vereador que mais ajudou os munícipes
# em Jacareí. Para isso vamos usar o atributo 'Atendimento.aos.munícipes'
# no eixo y e o nome dos vereadores no eixo x, é importante
# criar um grupo de mês para que haja uma ligação com os vereadores
# e a quantidade de atendimento aos munícipes.
ggthemr("dust")
ggplot(conjunto_meses, aes(x=Vereador,
           y=Atendimento.aos.munícipes,
           colour=Mês,
           group=Mês)) +
  geom_line(aes(linetype=Mês), size=0.8) +
  geom_point() +
  theme(axis.text.x = element_text(angle = 75,
                                   hjust = 1)) +
  xlab("Vereadores") +
  ylab("Atendimento aos munícipes") +
  scale_y_continuous(breaks = seq(0,420,30)) +
  scale_colour_colorblind()


# Essa visualização tem a mesma ideia, as principais diferenças
# para essa visualização, é que não fica tão claro que a tendencia
# é que com o passar dos meses a ajuda sobe.
ggthemr("dust")
ggplot(conjunto_meses, aes(x=Vereador,
                           y=Atendimento.aos.munícipes,
                           group=Mês)) +
  geom_col(position = "dodge",
           aes(fill = Mês))+
  theme(axis.text.x = element_text(angle = 0,
                                   hjust = 0.5)) +
  coord_flip() +
  xlab("Vereadores") +
  ylab("Atendimento aos munícipes") +
  ggtitle("Ajuda aos munícipes jacareí") +
  scale_y_continuous(breaks = seq(0,400,50))






