library(tidyverse)
library(hrbrthemes)
library(ggthemr)
library(leaflet)
library(lubridate)
library(stringr)
library(purrr)
# Leitura do arquivo csv
df <- read.csv2("data/dataset_of_abril.csv",
                sep=",",
                stringsAsFactors = FALSE)

# Visualização do conjunto de dados
knitr::kable(head(df, 5))

# Visualização de algumas estatísticas básicas
summary(df)

#'Análises
#'
#'1. Ano de fabricação que sofre mais roubos?
#'1.1 Será que os carros de 2018 são mais roubados?
#'
#'
#'2. Qual é o dia da semana em que houve mais roubo?
#'2.1 Será que foi na sexta-feira?
#'... UMA IDEIA É RESPONDER ISSO AQUI DEPOIS COM OS VIZ
#'
#'3. Qual é o de meio de locomoção mais roubado?
#'3.1 Será que foi moto?
#'... UMA IDEIA É RESPONDER ISSO AQUI DEPOIS COM OS VIZ
#'
#'4. Qual é a marca que mais roubam?
#'4.1 Será ford?
#'... UMA IDEIA É RESPONDER ISSO AQUI DEPOIS COM OS VIZ
#'
#'5. Mapa de região mais roubada

######## 1 - Análise de roubo por ano de fabricação

# Vamos começar selecionando os atributos e filtrando
# pela cidade de São José dos Campos

ggthemr::ggthemr('earth')

carros_sjc <- df %>% select(CIDADE_VEICULO,
                            ANO_MODELO,
                            DESCR_COR_VEICULO) %>%
  filter(CIDADE_VEICULO==("S.JOSE DOS CAMPOS"))

# Definição de cores por classes
cores <- c("Amarelo" = "#f1c40f",
           "Azul" = "#2980b9",
           "Branco" = "#f7f1e3",
           "Cinza" = "#95a5a6",
           "Prata" = "#bdc3c7",
           "Preta" = "#3d3d3d",
           "Verde" = "#2ecc71",
           "Vermelho" = "#e74c3c")

# Grafico de barras
ggplot(carros_sjc, aes(x=ANO_MODELO,
                       fill=DESCR_COR_VEICULO)) +
  geom_histogram(binwidth = 0.5) +
  labs(title = 'Carros roubados em Abril',
       y = 'Quantidade de carros Roubados',
       x = 'Ano de frabricação') +
  scale_fill_manual("Cores dos veículos",values=cores) +
  scale_x_continuous(breaks = seq(1984,2018,2)) +
  scale_y_continuous(breaks = seq(0,16,2)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


######## 2 - Roubo nos dias da semana
ggthemr::ggthemr('fresh')

# Selecionado a data do BO iniciado e transformo em dmy
df %>% select(BO_INICIADO) %>%
  mutate (BO_INICIADO = dmy_hm(BO_INICIADO),
          DIA_SEMANA = wday(BO_INICIADO,
                            label=TRUE,
                            abbr=FALSE)) %>%
  ggplot(aes(x=DIA_SEMANA)) +
  geom_bar() +
  labs(title = 'Roubo de carro no de Abril',
       y = 'Quantidade de carros roubados',
       x = 'Dias da semana')


######## 3 - Meio de locomoção mais roubado

ggthemr::ggthemr_reset()

df %>% select(DESCR_TIPO_VEICULO)%>%
  mutate(DESCR_TIPO_VEICULO =
           str_replace(DESCR_TIPO_VEICULO,"^$", "N/I")) %>%
  group_by(DESCR_TIPO_VEICULO) %>%
  summarise(quant = length(DESCR_TIPO_VEICULO)) %>%
  ggplot(aes(x=DESCR_TIPO_VEICULO,
             y=quant,
             fill=DESCR_TIPO_VEICULO)) +
  geom_point() +
  labs(title = 'Tipos de meio de locomoção roubados',
       y = 'Quantidade total',
       x = 'Meios de locomoção') +
  theme(axis.text.x = element_text(angle = 90),
        legend.position = "none")


######## 4 - Fabricante mais roubado

# Separando os fabricantes dos modelos usando regex
marcas <- str_split(df$DESCR_MARCA_VEICULO,
                    "[:punct:]") %>%
  flatten_chr()

## Transformando para dataframe
df_marcas <- as.data.frame(marcas)

df_marcas %>% select(marcas) %>%
  filter(marcas %in% c("FIAT",
         "HONDA",
         "PEUGEOT",
         "FORD",
         "TOYOTA",
         "YAMAHA")) %>%
  ggplot(aes(x=marcas)) +
  geom_bar() +
  labs(title = 'Fabricantes mais roubadas',
                    y = 'Quantidade Total',
                    x = 'Fabricantes')


### 4- Mapa
# Recomendo: http://sillasgonzaga.com/post/mapeando-a-abertura-de-escolas-municipais-em-sao-paulo-ao-longo-dos-anos/
library(ggmap)


# Selecionando os atributos e transfomando em double
mapa <- df %>%
  select(DATA = BO_INICIADO, LAT = LATITUDE,
         LONG = LONGITUDE) %>%
  mutate(DATA = dmy_hm(DATA),
         LAT = as.double(LAT),
         LONG = as.double(LONG)) %>%
  na.omit()

knitr::kable(head(mapa))


map <- leaflet() %>%
  addTiles() %>%
  addProviderTiles("OpenStreetMap.BlackAndWhite") %>%
  # coordenadas de um ponto em específico para exemplo
  addMarkers(lng = -46.0030986, lat = -23.1894443) %>%
  addCircleMarkers(data = mapa,
                   lng = ~LONG, lat = ~LAT,
                   opacity = 1.5)


# Respostas

# OBS.: Não é possível encontrar uma tendencia com análise de um mês, precisamos análisar uma série maior para extrair
# mais informações.

# 1. Intervalo de carros que mais sofrem roubos são de 2013 até 2015
# 1.1 Não, talvez seja porque a maioria tem seguro

# 2 O dia da semana que teve mais roubo no mês de Abril foi na terça-feira
# 2.1 Não, http://www.rastreadores.org/dias-e-horarios-que-mais-ocorrem-roubos-e-furtos-de-veiculos-no-brasil/, dar uma olhada
# na fonte desse dado.

# 3. Automóveis
# 3.1 Não, pelo menos não nesse mês

# 4. Honda










