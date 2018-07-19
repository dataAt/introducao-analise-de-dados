# -*- coding: utf-8 -*-

'''
Este script permite a visualização dos gastos por cargo de um único mês
'''

import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv('./2017_02.csv', sep = ';')

# Tratando as remunerações
df.Remuneração = df.Remuneração.str.replace('.', '')
df.Remuneração = df.Remuneração.str.replace(',','.').astype(float)

# Agrupando os dados
groups = df.groupby('Cargo')

gasto_por_grupo = groups.Remuneração.sum().reset_index()

# Realizando plot
plt.figure()

plt.bar(gasto_por_grupo.Cargo, gasto_por_grupo.Remuneração)
plt.show()