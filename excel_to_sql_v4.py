import tkinter as tk
from tkinter import filedialog
import pandas as pd
import db

class ExcelToSqlConverter:
    def __init__(self, root):
        self.root = root
        self.root.title("Excel to SQL Converter")
        self.root.geometry('800x700')

        # Variables para almacenar nombres de campos y opciones de select
        self.field_names = []
        self.select_options = []

        # Interfaz gráfica
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
                self.field_names = df.columns.tolist()
                self.excel_len = len(self.field_names)

                # Mostrar nombres de campos en campos de texto y opciones de select
                for i, field in enumerate(self.field_names):
                    self.excel_fields[i].delete(0, tk.END)
                    self.excel_fields[i].insert(0, field)

                # Conectar a la base de datos MySQL para obtener nombres de campos de la tabla
                db_obj = db.db.PsDb()
                db_obj.connect()
                table_name = 'ab_resistance'
                result = db_obj.get_variable_names(table_name)
                db_obj.disconnect()

                self.select_options = [dic['COLUMN_NAME'] for dic in result]
                print(self.select_options)
#                    variable_list = [dic['COLUMN_NAME'] for dic in result]

                # Mostrar opciones en el campo select
                self.select_field.delete(0, tk.END)
                for option in self.select_options:
                    self.select_field.insert(tk.END, option)

                if db_obj.db.open:
                    db_obj.disconnect()

            except pd.errors.EmptyDataError:
                print("Error: El archivo está vacío.")
            except Exception as e:
                print(f"Error al leer el archivo: {e}")

        # Interfaz gráfica
        self.create_interface()

    def create_interface(self):
        # Crear un canvas para contener la barra de desplazamiento y la interfaz gráfica
        self.canvas = tk.Canvas(self.root)
        self.canvas.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        print(self.excel_len)

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
        tk.Label(self.frame, text="Campos de Archivo de Entrada").grid(row=0, column=0, columnspan=2)
        self.excel_fields = []

        # Crear campos select en la columna derecha
        tk.Label(self.frame, text="Campos de Tabla MySQL").grid(row=0, column=15)
        self.db_fields = []
        self.db_values = []

        for i in range(self.excel_len):  # Número de campos en el excel
            entry = tk.Entry(self.frame)
            entry.grid(row=i+2, column=0, sticky="w", padx=5, pady=5)
            self.excel_fields.append(entry)

            # Variable to store the options list of the OptionMenu, they are the DB fields
            options_list = ["Option1", "Option2", "Option3", "Option4"]

            # Variable to store the option selected in OptionMenu
            db_values = tk.StringVar(root)

            print(self.select_options)
            db_values.set("Select an Option")
            self.select_field = tk.OptionMenu(self.frame, db_values, *self.select_options)
            self.select_field.grid(row=i+2, column=15, sticky="w", padx=5, pady=5)

        # Variable to store the option selected in OptionMenu
        # value_inside = tk.StringVar(root)

        # Botón para seleccionar archivo de entrada
        tk.Button(self.frame, text="Leer archivo de entrada", command=self.read_input_file).grid(row=1, column=0, columnspan=2, pady=10)

    def on_canvas_configure(self, event):
        # Configurar el tamaño del canvas cuando cambia el tamaño de la ventana
        self.canvas.configure(scrollregion=self.canvas.bbox("all"))

if __name__ == "__main__":
    root = tk.Tk()
    app = ExcelToSqlConverter(root)
    root.mainloop()