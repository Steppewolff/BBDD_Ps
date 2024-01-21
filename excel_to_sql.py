import pandas as pd
import numpy as np
import tkinter.filedialog
import db

file_path = tkinter.filedialog.askopenfilename()

df = pd.read_excel(file_path)

db_obj = db.PsDb()
db_obj.connect()
table_name = 'ab_resistance'
result = db_obj.get_variable_names(table_name)
db_obj.disconnect()

variable_list = [dic['COLUMN_NAME'] for dic in result]

for excel_column in df.columns:
    match = 0
    match_variable = ""

    # substrings is a list with words in excel column name
    substrings = excel_column.split(" ")

#    if len(substrings) > 1:
#        primera_subcadena = substrings[0]
#        segunda_subcadena = substrings[1]

#        print(f'Primera subcadena: {primera_subcadena}')
#        print(f'Segunda subcadena: {segunda_subcadena}')
#    else:
#        print('La cadena no contiene un espacio o tiene más de un espacio.')

    for variable in variable_list:
        for substring in substrings:
#            print("substring: " + substring.lower() + ", " + "variable: " + variable)
            if substring.lower() in variable.lower():
                match = 1
                match_variable = variable
#                print(match_variable)

    if match == 1:
        print(excel_column.lower() + " --> " + match_variable)
    else:
        print(excel_column.lower() + "---")

# Imprimir la lista
print(variable_list)

#print(df[['ST']].to_string(index=False))
#print(result)