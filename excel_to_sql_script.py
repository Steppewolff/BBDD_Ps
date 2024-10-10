import pandas as pd
import os.path
from tkinter import filedialog
import json
import re

import db

# Variables para almacenar nombres de campos y opciones de select
field_names = []
select_fields = []
select_options = []
excel_df = []
matched_db_fields = {}
values_list = []

db_value = ""


def escape_quotes(string):
    string = re.sub(r"'", r"\'", string)
    string = re.sub(r'"', r'\"', string)

    return string

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
                # print(table['Tables_in_psdb_json'])
                if table['Tables_in_psdb_json'] == 'metadata_general':
                    table_index = tables.index(table)
                    table_aux = table
            tables.pop(table_index)
            tables.insert(0, table_aux)

            # print('df_dictionary:')
            # print(df_dictionary)
            db_obj.disconnect()
        except pd.errors.EmptyDataError:
            print("Error: El archivo está vacío.")
        except Exception as e:
            print(f"Error al leer el archivo: {e}")

    print_match_file(tables, df_dictionary, excel_fields)


def print_match_file(tables, df_dictionary, excel_fields):
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
    read_matches(df_dictionary, excel_fields)


def read_matches(df_dictionary, excel_fields):
    print(
        "Pulsa cualquier tecla para continuar cuando se haya completado el archivo de equivalencias 'match_file_input.txt'")
    input()
    table_name = ""
    tables_values = {}
    db_obj = db.db.PsDb()
    db_obj.connect()
    locus_resistoma = db_obj.loci_list('mutational_resistome')
    resistoma_dict = {}
    locus_mlst = db_obj.loci_list('locus_mlst')
    mlst_dict = {}
    locus_virulencia = db_obj.loci_list('virulence_gene')
    virulencia_dict = {}
    locus_hipermutacion = db_obj.loci_list('hypermutation_gene')
    hipermutacion_dict = {}
    db_obj.disconnect()

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
                # print(line)
                line = line.rstrip("\n")
                line = line.lstrip("\t")
                line_values = line.split(" : ")
                if table_name in tables_values and line_values[1] != '':
                    tables_values[table_name].update({line_values[0]: line_values[1]})

        for field in excel_fields:
            field = field.split(" ")[0]
            if field in locus_resistoma:
                resistoma_dict[field] = {}
            elif field in locus_mlst:
                mlst_dict[field] = {}
            elif field in locus_virulencia:
                virulencia_dict[field] = {}
            elif field in locus_hipermutacion:
                hipermutacion_dict[field] = {}
            else:
                pass

    else:
        print("No se ha encontrado el archivo 'match_file_input_gemarasuplementary.txt'")

    write_sql_script(df_dictionary, tables_values, resistoma_dict, mlst_dict, virulencia_dict, hipermutacion_dict)


def write_sql_script(df_dictionary, tables_values, resistoma_dict, mlst_dict, virulencia_dict, hipermutacion_dict):
    sql_script = ""
    sql_script_comments = ""

    db_obj = db.db.PsDb()
    db_obj.connect()

    print("Introduce el NOMBRE EXACTO de la columna del archivo excel que contiene el identificador aislado:")
    id_aislado = ""
    id_aislado = input()

    for isolate in df_dictionary:
        for key, value in isolate.items():
            locus = key.split(" ")[0]
            if locus in resistoma_dict:
                if str(isolate[key]) == 'nan':
                    mutant = 'WT'
                else:
                    mutant = isolate[key]
                resistoma_dict[locus] = mutant
            elif locus in mlst_dict:
                if isolate[key] == 'nan':
                    mutant = 'WT'
                else:
                    mutant = isolate[key]
                mlst_dict[locus] = mutant
            elif locus in virulencia_dict:
                if isolate[key] == 'nan':
                    mutant = 'WT'
                else:
                    mutant = isolate[key]
                virulencia_dict[locus] = mutant
            elif locus in hipermutacion_dict:
                if isolate[key] == 'nan':
                    mutant = 'WT'
                else:
                    mutant = isolate[key]
                hipermutacion_dict[locus] = mutant

        sql_count = db_obj.count('metadata_general', 'isolate_name', isolate[id_aislado])
        if sql_count == 0:
            success = db_obj.insert_row('metadata_general', 'isolate_name', isolate[id_aislado])

        isolate_id = db_obj.get_row_id('metadata_general', 'isolate_name', isolate[id_aislado])

        if len(resistoma_dict) > 0:
            resistoma_json = json.dumps(resistoma_dict)

        if len(mlst_dict) > 0:
            mlst_json = json.dumps(mlst_dict)

        if len(virulencia_dict) > 0:
            virulencia_json = json.dumps(virulencia_dict)

        if len(hipermutacion_dict) > 0:
            hipermutacion_json = json.dumps(hipermutacion_dict)

        for table, fields in tables_values.items():
            if len(fields) > 0:

                duplicate_update = {}

                if table != 'metadata_general':
                    sql_count = db_obj.count(table, 'isolate_id', isolate_id)
                    if sql_count == 0:
                        success = db_obj.insert_row(table, 'isolate_id', isolate_id)
                    table_id = db_obj.get_table_id(table)
                    row_id = db_obj.get_row_id(table, 'isolate_id', isolate_id)

                sql_script = sql_script + "INSERT INTO " + table + "("
                if table != 'metadata_general': sql_script = sql_script + table_id + ", "
                table_variables = db_obj.get_variable_names_table(table)
                for variable in table_variables:
                    if variable['COLUMN_NAME'] == 'isolate_id': sql_script = sql_script + "isolate_id, "

                for field, column_name in fields.items():
                    if column_name in isolate:
                        sql_script = sql_script + field + ", "

                if table == 'sequence_analysis':
                    if len(resistoma_dict) > 0:
                        sql_script = sql_script + 'mutational_resistome' + ", "
                    if len(mlst_dict) > 0:
                        sql_script = sql_script + 'mlst_allelic_profile' + ", "
                    if len(virulencia_dict) > 0:
                        sql_script = sql_script + 'virulence_gene' + ", "
                    if len(hipermutacion_dict) > 0:
                        sql_script = sql_script + 'hypermutation_gene' + ", "

                sql_script = sql_script[:-2] + ") VALUES ("

                if table != 'metadata_general': sql_script = sql_script + "'" + str(row_id) + "', "
                sql_script = sql_script + "'" + str(isolate_id) + "', "
                for field, column_name in fields.items():
                    value_field = ""
                    if column_name in isolate:
                        if table == 'metadata_clinic':
                            if field == 'hospital':
                                value_field = db_obj.get_row_id('hospital', 'hospital_name', isolate[column_name])
                            elif field == 'sample_type':
                                value_field = db_obj.get_row_id('sample_type', 'sample', isolate[column_name])
                            else:
                                value_field = isolate[column_name]

                        elif table == 'sequencing_info':
                            if field == 'sequencing_technology':
                                value_field = db_obj.get_row_id('sequencing_technology', 'sequencing_technology_name',
                                                                isolate[column_name])
                            elif field == 'sequencing_platform':
                                value_field = db_obj.get_row_id('sequencing_platform', 'sequencing_platform_name',
                                                                isolate[column_name])
                            elif field == 'sequencing_library':
                                value_field = db_obj.get_row_id('sequencing_library', 'sequencing_library_method',
                                                                isolate[column_name])
                            else:
                                value_field = isolate[column_name]

                        elif table == 'phenotypic_data':
                            if field == 'invitro_serotype_id':
                                value_field = db_obj.get_row_id('invitro_serotype', 'invitro_value',
                                                                isolate[column_name])
                            else:
                                value_field = isolate[column_name]

                        else:
                            value_field = isolate[column_name]

                        if value_field == None:
                            # reg_value = db_obj.get_value_byid(table, field)
                            sql_script_comments = "INSERT INTO " + table + "(" + field + ") VALUES (" + str(isolate[column_name]) + ") ON DUPLICATE KEY UPDATE " + table + " SET " + field + " = CONCAT(" + field + "," + str(isolate[column_name]) + ");"
                        else:
                            if str(value_field) == 'nan':
                                value_field = '-'
                            elif isinstance(value_field, str):
                                value_field = escape_quotes(value_field)

                            sql_script = sql_script + "'" + str(value_field) + "'" + ", "
                            duplicate_update[field] = value_field

                if table == 'sequence_analysis':
                    if len(resistoma_dict) > 0:
                        sql_script = sql_script + "'" + resistoma_json + "', "
                    if len(mlst_dict) > 0:
                        sql_script = sql_script + "'" + mlst_json + "', "
                    if len(virulencia_dict) > 0:
                        sql_script = sql_script + "'" + virulencia_json + "', "
                    if len(hipermutacion_dict) > 0:
                        sql_script = sql_script + "'" + hipermutacion_json + "', "

                sql_script = sql_script[:-2] + ") "

                sql_script = sql_script + "ON DUPLICATE KEY UPDATE "

                for field, field_value in duplicate_update.items():
                    # if column_name in isolate:
                    sql_script = sql_script + field + " = '" + str(field_value) + "'" + ", "

                if table == 'sequence_analysis':
                    if len(resistoma_dict) > 0:
                        sql_script = sql_script + "mutational_resistome = '" + resistoma_json + "', "
                    if len(mlst_dict) > 0:
                        sql_script = sql_script + "mlst_allelic_profile = '" + mlst_json + "', "
                    if len(virulencia_dict) > 0:
                        sql_script = sql_script + "virulence_gene = '" + virulencia_json + "', "
                    if len(hipermutacion_dict) > 0:
                        sql_script = sql_script + "hypermutation_gene = '" + hipermutacion_json + "', "

                sql_script = sql_script[:-2] + "; \n"

    db_obj.disconnect()
    file = open('sql_script.sql', 'w')
    file.write(sql_script)
    file.write(sql_script_comments)

read_input_file()
