import pandas as pd
import os.path
from tkinter import filedialog

import db

# Variables para almacenar nombres de campos y opciones de select
field_names = []
select_fields = []
select_options = []
excel_df = []
matched_db_fields = {}
values_list = []

db_value = ""


def read_input_file():
    # Limpiar listas de campos y opciones de select
    tables = []
    df_dictionary = []
    field_names.clear()
    select_options.clear()

    # Diálogo para seleccionar el archivo
    filetypes = (('csv files', '*.csv'),
                 ('xls files', '*.xls'),
                 ('xlsx files', '*.xlsx'))
    file_path = filedialog.askopenfilename(filetypes=filetypes, initialdir="FuentesInformacion")

    if file_path:
        try:
            df = pd.read_excel(file_path) if file_path.endswith(('.xls', '.xlsx')) else pd.read_csv(file_path)
            df_dictionary = df.to_dict('records')
            excel_fields = df.columns.tolist()
            # excel_df = df.values.tolist()

            # Conectar a la base de datos MySQL para obtener nombres de campos de la tabla
            db_obj = db.db.PsDb()
            db_obj.connect()
            result = db_obj.get_variable_names_db()
            tables = db_obj.get_table_names_db('psdb_json')
            table_index = 0
            table_aux = {}
            for table in tables:
                print(table['Tables_in_psdb_json'])
                if table['Tables_in_psdb_json'] == 'metadata_general':
                    table_index = tables.index(table)
                    table_aux = table
            tables.pop(table_index)
            tables.insert(0, table_aux)
            # print('tables:')
            # print(tables)
            print('df_dictionary:')
            print(df_dictionary)
            db_obj.disconnect()
        except pd.errors.EmptyDataError:
            print("Error: El archivo está vacío.")
        except Exception as e:
            print(f"Error al leer el archivo: {e}")

    print_match_file(tables, df_dictionary)


def print_match_file(tables, df_dictionary):
    if os.path.exists('match_file.txt'):
        match_file = open('match_file.txt', 'w+')
    else:
        match_file = open('match_file.txt', 'x+')
    match_file.write("Campos de la base de datos:")
    match_file.write("\n")

    for table in tables:
        db_obj = db.db.PsDb()
        db_obj.connect()
        response = db_obj.get_variable_names_table(table['Tables_in_psdb_json'])
        variables = [diccionario['COLUMN_NAME'] for diccionario in response]
        db_obj.disconnect()
        # sql_columns = "INSERT INTO " + table['Tables_in_psdb'] + "("
        match_file.write(table['Tables_in_psdb_json'] + "\n")

        for variable in variables:
            match_file.write("\t" + variable + " : \n")

    match_file.close()
    read_matches(df_dictionary)


def read_matches(df_dictionary):
    print("Pulsa cualquier tecla para continuar cuando se haya completado el archivo de equivalencias 'match_file.txt'")
    input()
    table_name = ""
    tables_values = {}
    if os.path.exists('match_file_input.txt'):
        match_file = open('match_file_input.txt', 'r')
        for line in match_file.readlines():
            if line == "Campos de la base de datos:\n":
                print(line)
            if line[0] != "\t" and line != "Campos de la base de datos:\n":
                print(line)
                line = line.rstrip("\n")
                table_name = line
                tables_values[table_name] = {}
            else:
                print(line)
                line = line.rstrip("\n")
                line = line.lstrip("\t")
                line_values = line.split(" : ")
                if table_name in tables_values and line_values[1] != "":
                    tables_values[table_name].update({line_values[0]: line_values[1]})
    else:
        print("No se ha encontrado el archivo 'match_file_input.txt'")


def create_sql():
    # for i, field in enumerate(select_options):
    #     match_file.a (f"{i+1}. {field}")
    # print("\nCampos del archivo:")
    # for i, field in enumerate(excel_fields):
    #     print(f"{i+1}. {field}")

    pass


def write_sql_script():
    sql_script = ""

    db_obj = db.db.PsDb()
    db_obj.connect()
    # tables = db_obj.get_table_names_db('psdb_json')
    # db_obj.disconnect()
    #
    # df_sql_values = df
    #
    for table in tables:
        # table_include = 0
        response = db_obj.get_variable_names_table(table['Tables_in_psdb'])
        variables = [diccionario['COLUMN_NAME'] for diccionario in response]

        sql_columns = "INSERT INTO " + table['Tables_in_psdb'] + "("

        for key, value in matched_db_fields.items():
            if value in variables:
                table_include = 1
                sql_columns = sql_columns + matched_db_fields[key] + ", "
            else:
                pass
                # df_sql_values.drop(columns=key)

        # if table_include == 0:
        #     sql_columns = ""
        #     continue
        # else:
        #     sql_columns = sql_columns[:-2]
        #     sql_columns = sql_columns + ") \n"

        # print("SQL columns: ")
        # print(sql_columns)
        #
        # print("df_sql_values: ")
        # print(df_sql_values)

        # for row in excel_df:
        #     sql_values = "VALUES ("
        #     values = ",".join(str(value) for value in row)

        # for row in df_wospaces.itertuples(index=True):
        # for row in df_dictionary:
        #     sql_values = "VALUES ("
        #     # print("Tuple: ")
        #     # print(row)
        #     for key, value in row.items():
        #         # for key, value in matched_db_fields.items():
        #         #                        if key == getattr(row, key) and value in variables:
        #         variable = matched_db_fields[key]
        #         if variable in variables:
        #             # if table['Tables_in_psdb'] == locus
        #             sql_values = sql_values + "'" + str(value) + "', "
        #
        #     sql_values = sql_values[:-2]
        #     sql_values = sql_values + "); \n"
        #     sql_script = sql_script + sql_columns + sql_values

    # Disconnecting from DB once all the operations have been performed
    db_obj.disconnect()

    return sql_script


read_input_file()
