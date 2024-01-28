import tkinter
import tkinter as tk
from tkinter import filedialog, ttk
from PIL import Image, ImageTk
import pandas as pd
import db


class ExcelToSqlConverter:
    def __init__(self, root):
        self.root = root
        self.root.title("Excel to SQL Converter")
        self.root.geometry('800x600')

        # Variables para almacenar nombres de campos y opciones de select
        self.field_names = []
        self.select_fields = []
        self.select_options = []
        self.matched_db_fields = {}
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
        file_path = filedialog.askopenfilename(filetypes=filetypes, initialdir="/home/fernando/Proyectos")

        # Leer el archivo utilizando pandas
        if file_path:
            try:
                df = pd.read_excel(file_path) if file_path.endswith(('.xls', '.xlsx')) else pd.read_csv(file_path)
                self.excel_fields = df.columns.tolist()

                print('excel_fields:')
                print(self.excel_fields)

                # Mostrar nombres de campos en campos de texto y opciones de select
                # for i, field in enumerate(self.field_names):
                #     print('i, field:')
                #     print(i)
                #     print(field)
                #     #self.excel_fields[i].delete(0, tk.END)
                #     self.excel_fields[i].insert(0, field)

                # Conectar a la base de datos MySQL para obtener nombres de campos de la tabla
                db_obj = db.db.PsDb()
                db_obj.connect()
                table_name = 'ab_resistance'
                result = db_obj.get_variable_names(table_name)
                db_obj.disconnect()

                self.select_options = [dic['COLUMN_NAME'] for dic in result]
                self.select_options.append("Match not found")

                print('select_options:')
                print(self.select_options)

            except pd.errors.EmptyDataError:
                print("Error: El archivo está vacío.")
            except Exception as e:
                print(f"Error al leer el archivo: {e}")

            # Interfaz gráfica
            self.search_matches()

    def search_matches(self):
        # Loop over the excel fields name list
        for excel_column in self.excel_fields:
            match = 0
            match_variable = ""
            #excelColumn_text = excel_column + "_text"

            # substrings is a list with words in excel column name
            substrings = excel_column.split(" ")

            #    if len(substrings) > 1:
            #        primera_subcadena = substrings[0]
            #        segunda_subcadena = substrings[1]

            #        print(f'Primera subcadena: {primera_subcadena}')
            #        print(f'Segunda subcadena: {segunda_subcadena}')
            #    else:
            #        print('La cadena no contiene un espacio o tiene más de un espacio.')

            for variable in self.select_options:
                for substring in substrings:
                    #            print("substring: " + substring.lower() + ", " + "variable: " + variable)
                    if substring.lower() in variable.lower():
                        match = 1
                        match_variable = variable

            if match == 1:
                self.matched_db_fields[excel_column] = match_variable
                print(excel_column.lower() + " --> " + match_variable)
            else:
                self.matched_db_fields[excel_column] = 'Match not found'
                print(excel_column.lower() + "---")

        # Calling the GUI interface function
        self.create_interface()


    # New window with SQL script resume
    def open_secondary_window(self):
        secondary_window = tk.Toplevel()
        secondary_window.title("Matched fields")
        secondary_window.geometry('600x300')
#        secondary_window.config(width=500, height=400)

        fm1 = tk.Frame(secondary_window, bg='red')
        fm1['width'] = 480
        fm1['height'] = 140
        fm1.grid(row=0, column=0)

        fm2 = tk.Frame(secondary_window, bg='blue')
        fm1['width'] = 480
        fm1['height'] = 140
        fm2.grid(row=1, column=0)

        # Create a button to close (destroy) this window.
        button_close = ttk.Button(
            secondary_window,
            text="Close window",
            command=secondary_window.destroy
        )
        button_close.grid(row=2, column=0, sticky='nsew')

        # df_frame = tk.Frame(secondary_window)
        # df_frame.grid(row=2, column=1)


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

    def create_interface_elements(self):
        # Crear campos de texto en la columna izquierda
        tk.Label(self.frame, text="Campos de Archivo de Entrada").grid(row=1, column=0)

        # # Añadir logo entre las dos columnas
        # image = ImageTk.PhotoImage(Image.open("/home/steppewolf/Proyectos/CIBERINFEC/BDD/img/logoIDISBA.png"))
        # #image = tk.PhotoImage(file="/home/steppewolf/Proyectos/CIBERINFEC/BDD/img/logoIDISBA.png")
        # ttk.Label(self.frame, image=image).grid(row=0, column=0)
        # #ttk.Label(self.frame, text="Prueba Imagen").grid(row=0, column=0)
        # #self.canvas.create_image(10, 10, anchor="nw", image=image)

        # Añadir logo entre las dos columnas
        image_path = "/home/steppewolf/Proyectos/CIBERINFEC/BDD/img/logoIDISBA.png"
        self.logo_image = ImageTk.PhotoImage(Image.open(image_path))
        ttk.Label(self.frame, image=self.logo_image).grid(row=0, column=0)

        # Crear campos select en la columna derecha
        tk.Label(self.frame, text="Campos de Tabla MySQL").grid(row=1, column=15)
        self.db_fields = []
        self.db_values = []
        self.excel_entries = []

        for i in range(len(self.excel_fields)):  # Número de campos en el excel
            entry_text = tk.StringVar()
            entry = tk.Entry(self.frame, textvariable=entry_text)
            entry.grid(row=i + 3, column=0, sticky="w", padx=5, pady=5)
            entry_text.set(self.excel_fields[i])
            self.excel_entries.append(entry)

            # Variable to store the option selected in OptionMenu
            #self.matched_db_fields
            db_value = tk.StringVar(value=self.matched_db_fields[self.excel_fields[i]])
            index = self.select_options.index(self.matched_db_fields[self.excel_fields[i]])
            #self.db_value.initialize = set(self.matched_db_fields[self.excel_fields[i]])
            print("db_matches: ")
            print(self.matched_db_fields)
            print("db_value: ")
            print(db_value.get())
            print(self.matched_db_fields[self.excel_fields[i]])
            self.select_field = ttk.Combobox(self.frame, state="normal", textvariable=db_value,
                                             values=self.select_options)
            self.select_field.current(index)
            print("index: ")
            print(index)
            #self.select_field.current() = 'Choose one'
            self.select_field.grid(row=i + 3, column=15, sticky="w", padx=5, pady=5)

        # Variable to store the option selected in OptionMenu
        # value_inside = tk.StringVar(root)

        # Botón para seleccionar archivo de entrada
        # tk.Button(self.frame, text="Leer archivo de entrada", command=self.read_input_file).grid(row=2, column=0, columnspan=2, pady=10)

        # Create a button inside the main window that invokes the open_secondary_window() function when pressed.
        button_open = ttk.Button(self.frame, text="Check matched fields", command=self.open_secondary_window)
        button_open.grid(row=len(self.excel_fields) + 4, column=15, sticky="w", padx=5, pady=5)

    def on_canvas_configure(self, event):
        # Configurar el tamaño del canvas cuando cambia el tamaño de la ventana
        self.canvas.configure(scrollregion=self.canvas.bbox("all"))


if __name__ == "__main__":
    root = tk.Tk()
    app = ExcelToSqlConverter(root)

    # Añadir logo como icono de la app
    icon_path = "/home/steppewolf/Proyectos/CIBERINFEC/BDD/img/logoIDISBA.ico"
    icon = ImageTk.PhotoImage(file=icon_path)
    root.iconphoto(True, icon)

    root.mainloop()
