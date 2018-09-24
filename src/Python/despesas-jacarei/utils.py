def change_money(data):
    """Função para remover ponto (.) e virgula (,) e transformar a string em um
    valor real
    """
    return float(data.replace('.', '').replace(',', ''))
