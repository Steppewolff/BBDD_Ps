import tkinter as tk
from tkinter import filedialog, ttk, messagebox
from PIL import Image, ImageTk
from collections import Counter
import pandas as pd
import os
import re

import db


class ExcelToSqlConverter:
    def __init__(self, root):
        self.root = root
        self.root.title("Excel to SQL Converter")
        self.root.geometry('1000x800')

        # Variables para almacenar nombres de campos y opciones de select
        self.field_names = []
        self.select_fields = []
        self.select_options = []
        self.excel_df = []
        self.matched_db_fields = {}
        self.values_list = []
        self.db_value = ""

        # Importar datos
        self.read_input_file()

    def read_input_file(self):
        # Limpiar listas de campos y opciones de select
        self.field_names.clear()
        self.select_options.clear()

        # Diálogo para seleccionar el archivo
        filetypes = (('csv files', '*.csv'),
                     ('xls files', '*.xls'),
                     ('xlsx files', '*.xlsx'))
        file_path = filedialog.askopenfilename(filetypes=filetypes, initialdir="FuentesInformacion")

        # Leer el archivo utilizando pandas
        if file_path:
            try:
                self.df = pd.read_excel(file_path) if file_path.endswith(('.xls', '.xlsx')) else pd.read_csv(file_path)
                self.df_dictionary = self.df.to_dict('records')
                #                self.df_wospaces.columns = self.df_wospaces.columns.str.replace(" ", "_", regex=True)
                self.excel_fields = self.df.columns.tolist()
                # self.excel_df = df.values.tolist()

                # Conectar a la base de datos MySQL para obtener nombres de campos de la tabla
                db_obj = db.db.PsDb()
                db_obj.connect()
                result = db_obj.get_variable_names_db()
                db_obj.disconnect()

                self.select_options = [dic['COLUMN_NAME'] for dic in result]
                self.select_options.append("Match not found")

            except pd.errors.EmptyDataError:
                print("Error: El archivo está vacío.")
            except Exception as e:
                print(f"Error al leer el archivo: {e}")

            # Interfaz gráfica
            self.search_matches()

    def search_matches(self):
        # Loop over the excel fields name list
        for excel_column in self.excel_fields:
            # match = 0
            # match_variable = ""
            match_quality = {}

            # regex = "^PA"
            # if re.match(regex, excel_column):
            #     excel_column = re.sub("\s", "_", excel_column)
            #     self.matched_db_fields[excel_column] = excel_column
            #     continue

            # substrings is a list with words in Excel column name
            substrings_excel = re.split('-|_| |\/', excel_column)
            if " " in substrings_excel: substrings_excel.remove(" ")

            #    if len(substrings) > 1:
            #        primera_subcadena = substrings[0]
            #        segunda_subcadena = substrings[1]

            #        print(f'Primera subcadena: {primera_subcadena}')
            #        print(f'Segunda subcadena: {segunda_subcadena}')
            #    else:
            #        print('La cadena no contiene un espacio o tiene más de un espacio.')

            for variable in self.select_options:
                substrings_db = re.split('-|_| |\/', variable)
                if " " in substrings_db: substrings_db.remove(" ")
                quality = 0
                for substring_excel in substrings_excel:
                    for substring_db in substrings_db:
                        if substring_excel.lower() in substring_db.lower():
                            quality = quality + 1
                            if len(substring_excel) == len(substring_db):
                                quality = quality + 1

                    #            print("substring: " + substring.lower() + ", " + "variable: " + variable)
                    #            if substring.lower() in variable.lower():
                    #    match = 1
                    #    match_variable = variable

########################Muy ineficiente, le permite hacer todas las comparaciones y luego le asigna quality = 0, buscar una manera de eliminar los que pongan EUCAST antes (y dejarlo como una lista de términos que se pueden eliminar cuando se lean)
                if "EUCAST" in substrings_excel:
                    match_quality[variable] = 0
                else:
                    match_quality[variable] = quality

            if max(match_quality.values()) == 0:
                match_variable = 'Match not found'
            else:
                match_variable = max(match_quality, key=match_quality.get)

            self.matched_db_fields[excel_column] = match_variable

            print(match_variable)

            # if match == 1:
            #     self.matched_db_fields[excel_column] = match_variable
            # else:
            #     self.matched_db_fields[excel_column] = 'Match not found'

        # Calling the GUI interface function
        self.create_interface()
        self.values_list = self.matched_db_fields

    # New window with matches summary and SQL script preview v2
    def create_secondary_window(self):
        def on_close_window():
            secondary_window.destroy()

        def create_sql_script():
            content_frame1 = text_frame1.get("1.0", "end-1c")
            content_frame2 = text_frame2.get("1.0", "end-1c")

            # Lógica para crear el archivo SQL
            with open("./outputs/sql_script.sql", "w") as file:
                file.write("\n\n-- SQL script from Frame 2:\n")
                file.write(sql_script)
                confirm_wd = tk.Toplevel(secondary_window)
                confirm_wd.geometry('300x200')
                confirm_wd.title("Script ready")
                confirm_label = tk.Label(confirm_wd, text='SQL script created, to access it: ')
                confirm_label.grid(row=0, column=0, pady=10, sticky='n')

                close_button = ttk.Button(confirm_wd, text="Close window", command=confirm_wd.destroy)
                close_button.grid(row=2, column=0, pady=10)

                create_script_button = ttk.Button(confirm_wd, text="Go to SQL script",
                                                  command=lambda: os.system("gedit ./outputs/sql_script.sql"))
                create_script_button.grid(row=3, column=0, pady=10)

        # Crear la ventana secundaria
        secondary_window = tk.Toplevel()
        secondary_window.title("Matched fields found and SQL script")
        secondary_window.geometry('700x1000')

        # Frames en la parte superior con scroll vertical y horizontal
        frame1 = ttk.Frame(secondary_window, borderwidth=2, relief="groove")
        frame1.grid(row=0, column=0, padx=5, pady=5, sticky="nsew")

        frame2 = ttk.Frame(secondary_window, borderwidth=2, relief="groove")
        frame2.grid(row=1, column=0, padx=5, pady=5, sticky="nsew")

        # Campo de texto en cada frame
        text_frame1 = tk.Text(frame1, wrap="none", width=80, height=20)
        text_frame1.grid(row=0, column=0, sticky="nsew")
        for key in self.matched_db_fields:
            match = key + " --> " + self.matched_db_fields[key] + "\n"
            text_frame1.insert(tk.INSERT, match)

        text_frame2 = tk.Text(frame2, wrap="none", width=80, height=20)
        text_frame2.grid(row=0, column=0, sticky="nsew")
        sql_script = self.write_sql_script()
        text_frame2.insert(tk.INSERT, sql_script)

        # Configuración del scroll para los frames
        scroll_frame1_y = ttk.Scrollbar(frame1, orient="vertical", command=text_frame1.yview)
        scroll_frame1_x = ttk.Scrollbar(frame1, orient="horizontal", command=text_frame1.xview)
        text_frame1.configure(yscrollcommand=scroll_frame1_y.set, xscrollcommand=scroll_frame1_x.set)

        scroll_frame2_y = ttk.Scrollbar(frame2, orient="vertical", command=text_frame2.yview)
        scroll_frame2_x = ttk.Scrollbar(frame2, orient="horizontal", command=text_frame2.xview)
        text_frame2.configure(yscrollcommand=scroll_frame2_y.set, xscrollcommand=scroll_frame2_x.set)

        # Botones en la parte inferior
        close_button = ttk.Button(secondary_window, text="Close window", command=on_close_window)
        close_button.grid(row=2, column=0, pady=10)

        create_script_button = ttk.Button(secondary_window, text="Create SQL script", command=create_sql_script)
        create_script_button.grid(row=3, column=0, pady=10)

        # Colocar los scrollbars en los frames
        scroll_frame1_y.grid(row=0, column=1, sticky="ns")
        scroll_frame1_x.grid(row=1, column=0, sticky="ew")
        scroll_frame2_y.grid(row=0, column=1, sticky="ns")
        scroll_frame2_x.grid(row=1, column=0, sticky="ew")

        # Ajustar el layout cuando se cambie el tamaño de la ventana
        secondary_window.grid_columnconfigure(0, weight=1)
        secondary_window.grid_rowconfigure(0, weight=1)
        secondary_window.grid_rowconfigure(1, weight=1)

    def create_interface(self):
        # Crear un canvas para contener la barra de desplazamiento y la interfaz gráfica
        self.canvas = tk.Canvas(self.root)
        self.canvas.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)

        # Barra de desplazamiento vertical
        scrollbar = tk.Scrollbar(self.root, orient=tk.VERTICAL, command=self.canvas.yview)
        scrollbar.pack(side=tk.RIGHT, fill=tk.Y)

        # Configurar el canvas para desplazarse con la barra
        self.canvas.configure(yscrollcommand=scrollbar.set)
        self.canvas.bind("<Configure>", self.on_canvas_configure)

        # Frame para contener los elementos de la interfaz gráfica
        self.frame = tk.Frame(self.canvas)
        self.canvas.create_window((0, 0), window=self.frame, anchor="nw")

        # Llamar al método create_interface para generar la interfaz gráfica
        self.create_interface_elements()

    def on_combobox_select(self, event, key):
        index = self.excel_fields.index(key)
        selected_value = self.comboboxes[index].get()
        self.values_list[key] = selected_value

    def create_interface_elements(self):
        # Crear campos de texto en la columna izquierda
        tk.Label(self.frame, text="Campos de Archivo de Entrada").grid(row=1, column=0)

        # Añadir logo entre las dos columnas
        image_path = "./img/logoIDISBA.png"
        self.logo_image = ImageTk.PhotoImage(Image.open(image_path))
        ttk.Label(self.frame, image=self.logo_image).grid(row=0, column=0)

        # Crear campos select en la columna derecha
        tk.Label(self.frame, text="Campos de Tabla MySQL").grid(row=1, column=15)
        self.db_fields = []
        self.db_values = []
        self.excel_entries = []
        self.comboboxes = []

        for i in range(len(self.excel_fields)):  # Número de campos en el excel
            entry_text = tk.StringVar()
            entry = tk.Entry(self.frame, state="readonly", textvariable=entry_text)
            entry.grid(row=i + 3, column=0, sticky="w", padx=5, pady=5)
            entry_text.set(self.excel_fields[i])
            self.excel_entries.append(entry)

            # Variable to store the option selected in OptionMenu
            # db_value = tk.StringVar() #value=self.matched_db_fields[self.excel_fields[i]]
            index = self.select_options.index(self.matched_db_fields[self.excel_fields[i]])

            # default_dbvalue = self.matched_db_fields[self.excel_fields[i]]

            # self.select_field = ttk.Combobox(self.frame, state="normal", values=self.select_options) # textvariable=default_dbvalue,
            # self.select_field.current(index)
            # self.select_field.bind('<<ComboboxSelected>>', self.field_modified(self, self.select_field.get()))
            # self.matched_db_fields[self.excel_fields[i]] = self.select_field.get()

            # selected_value = self.select_field.get()

            combobox = ttk.Combobox(self.frame, state="normal",
                                    values=self.select_options)  # textvariable=default_dbvalue,
            combobox.current(index)
            combobox.grid(row=i + 3, column=15, sticky="w", padx=5, pady=5)
            combobox.bind('<<ComboboxSelected>>',
                          lambda event, key=self.excel_fields[i]: self.on_combobox_select(event,
                                                                                          key))  # key=self.matched_db_fields[self.excel_fields[i]]: self.on_combobox_select(event, index, key)
            self.comboboxes.append(combobox)
            # self.matched_db_fields[self.excel_fields[i]] = self.select_field.get()

            # prueba_select = self.select_field.get()

            # self.select_field.grid(row=i + 3, column=15, sticky="w", padx=5, pady=5)

        # Create a button inside the main window that invokes the open_secondary_window() function when pressed.
        button_open = ttk.Button(self.frame, text="Check matched fields",
                                 command=self.create_secondary_window)  # self.open_secondary_window
        button_open.grid(row=len(self.excel_fields) + 4, column=15, sticky="w", padx=5, pady=5)

    def review_matches(self, dictionary):
        counts = Counter(dictionary.values())
        result = {key: value for key, value in dictionary.items() if counts[value] > 1}
        if "Match not found" in counts:
            del counts["Match not found"]

        return result, counts

    def write_sql_script(self):
        sql_script = ""
        result, counts = self.review_matches(self.matched_db_fields)

        if counts.most_common(1)[0][1] > 1:
            duplicates = ""
            for key, value in counts.items():
                if value > 1:
                    duplicates = duplicates + key + ": " + str(value) + "\n"

            messagebox.showerror("Campos duplicados",
                                 "Los siguientes campos de la base de datos tienen asignados más de un campo en el archivo de entrada.\n\nRevíselos y vuelva a intentarlo:\n\n" + str(
                                     duplicates))
        else:
            db_obj = db.db.PsDb()
            db_obj.connect()
            tables = db_obj.get_table_names_db('psdb')
            # db_obj.disconnect()

            df_sql_values = self.df

            for table in tables:
                table_include = 0
                response = db_obj.get_variable_names_table(table['Tables_in_psdb'])
                variables = [diccionario['COLUMN_NAME'] for diccionario in response]
                # print("variables: ")
                # print(variables)
                # print("table: ")
                # print(table)

                sql_columns = "INSERT INTO " + table['Tables_in_psdb'] + "("

                for key, value in self.matched_db_fields.items():
                    # print("KEY: ")
                    # print(table['Tables_in_psdb'], value)
                    if value in variables:
                        table_include = 1
                        sql_columns = sql_columns + self.matched_db_fields[key] + ", "
                    else:
                        df_sql_values.drop(columns=key)

                if table_include == 0:
                    sql_columns = ""
                    continue
                else:
                    sql_columns = sql_columns[:-2]
                    sql_columns = sql_columns + ") \n"

                # print("SQL columns: ")
                # print(sql_columns)
                #
                # print("df_sql_values: ")
                # print(df_sql_values)

                # for row in self.excel_df:
                #     sql_values = "VALUES ("
                #     values = ",".join(str(value) for value in row)

                # for row in self.df_wospaces.itertuples(index=True):
                for row in self.df_dictionary:
                    sql_values = "VALUES ("
                    # print("Tuple: ")
                    # print(row)
                    for key, value in row.items():
                        # for key, value in self.matched_db_fields.items():
                        #                        if key == getattr(row, key) and value in variables:
                        variable = self.matched_db_fields[key]
                        if variable in variables:
                            # if table['Tables_in_psdb'] == locus
                            sql_values = sql_values + "'" + str(value) + "', "

                    sql_values = sql_values[:-2]
                    sql_values = sql_values + "); \n"
                    sql_script = sql_script + sql_columns + sql_values

            # Disconnecting from DB once all the operations have been performed
            db_obj.disconnect()

            return sql_script

    def on_canvas_configure(self, event):
        # Configurar el tamaño del canvas cuando cambia el tamaño de la ventana
        self.canvas.configure(scrollregion=self.canvas.bbox("all"))


if __name__ == "__main__":
    root = tk.Tk()
    app = ExcelToSqlConverter(root)

    # Añadir logo como icono de la app
    icon_path = "./img/logoIDISBA.ico"
    icon = ImageTk.PhotoImage(file=icon_path)
    root.iconphoto(True, icon)

    root.mainloop()
