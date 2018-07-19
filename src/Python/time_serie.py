# -*- coding: utf-8 -*-

import pandas as pd

def rem_serie(files, sep):
    """Função para a construção de uma série com todos os gastos por grupo
    :obs: NaN podem ocorrer por conta dos tamanhos dos arquivos
    """
    
    df = pd.DataFrame()
    names = []
    
    for file in files:
        names.append(file)
        temp = pd.read_csv(file, sep = sep)
        groups = temp.groupby('Remuneração')
        
        # Tratando as remunerações
        temp.Remuneração = temp.Remuneração.str.replace('.', '')
        temp.Remuneração = temp.Remuneração.str.replace(',','.').astype(float)

        gasto_por_grupo = groups.Remuneração.sum()
        df = pd.concat([df, gasto_por_grupo], axis = 1)

    df.columns = names
    return df
