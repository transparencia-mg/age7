import csv
from dtamg_py import utils

connection = utils.connect()

with connection.cursor() as cursor:
    sql_query = """SELECT id, datahora_registro, piloto, indicador_concluido 
                   FROM age7.evento_etl_carga 
                   ORDER BY datahora_registro DESC 
                   LIMIT 4;"""
    cursor.execute(sql_query)
    rows = cursor.fetchall()
    colnames = [desc[0] for desc in cursor.description]
    with open(f'logs/evento_etl_carga.csv', "w", encoding='utf-8-sig', newline='') as fp:
      myFile = csv.DictWriter(fp, colnames, delimiter=';')
      myFile.writeheader()
      myFile.writerows(rows)
