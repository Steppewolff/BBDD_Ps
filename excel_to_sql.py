import pandas as pd
import numpy as np
import tkinter as tk
from tkinter import filedialog, ttk
import db

# file_path = tkinter.filedialog.askopenfilename()
# Instantiation of a tk app
app = tk.Tk()

# Title and parameters of the app
app.title('CARGA DE DATOS A BBDD ARPBIGIDISBA')
app.geometry('800x600')

# Create Text field for Excel column names
excelColumnNames_text = tk.Text(app, height=20, width=50)
excelColumnNames_text.grid(column=2, row=2)

# Create Text field for DB fields
dbFieldNames_text = tk.Text(app, height=20, width=50)
dbFieldNames_text.grid(column=60, row=2)


def open_excel_file():
    filetypes = (('xls files', '*.xls'),
                 ('xlsx files', '*.xlsx'),
                 ('csv files', '*.csv'))

    file_path = filedialog.askopenfile(filetypes=filetypes, initialdir="/home/fernando/Proyectos")
    df = pd.read_csv(file_path, encoding='utf-8')

    return df


# Button to open file
chooseFileButton = ttk.Button(app, text='Choose File', command=open_excel_file)

db_obj = db.db.PsDb()
db_obj.connect()
table_name = 'ab_resistance'
result = db_obj.get_variable_names(table_name)
db_obj.disconnect()

variable_list = [dic['COLUMN_NAME'] for dic in result]

# df = open_excel_file()

for excel_column in df.columns:
    match = 0
    match_variable = ""
    excelColumn_text = excel_column + "_text"


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

    excelColumnNames_text.insert('1.0', excel_column)
    # dbFieldNames_text.insert('1.0', )

# print(df[['ST']].to_string(index=False))
# print(result)
# Imprimir la lista


print(variable_list)
print(df.columns)

# Specify the button position on the app
chooseFileButton.grid(sticky='w', padx=250, pady=50)

# Make infinite loop for displaying app on the screen
app.mainloop()