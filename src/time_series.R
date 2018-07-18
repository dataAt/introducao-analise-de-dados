library(tidyverse)

#' Função para realizar a criação de uma serie temporal de dados 
#' 
#' @param files Vetor com os data.frames a serem unidos
#' @param delim Delimitador dos arquivos a serem carregados
#'
build_series <- function(files, delim) {
  references <- data.frame();
  df <- data.frame();
  for (file in files) {
    reference <- str_sub(file, 1, 7);
    temp <- read_delim(file, delim = delim);
    references <- rbind(references, data.frame(rep(reference, nrow(temp[1]))));
    df <- rbind(df, temp);
  }
  df$references <- data.frame(references);
  return(df);
}

#' Função para agrupar (Somatório) uma serie temporal
#'
#' @param index_data Indice da coluna a ser agrupada
#' @param index_category Indice da coluna a ser utilizada como parâmetro de agrupamento
group_serie <- function(data_serie, data_category) {
  return(aggregate(data_serie, by=list(Category=data_category), FUN=sum))
}