import tkinter as tk
from tkinter import filedialog
import pandas as pd
# import mysql.connector
import db

class ExcelToSqlConverter:
    def __init__(self, root):
        self.root = root
        self.root.title("Excel to SQL Converter")

        # Variables para almacenar nombres de campos y opciones de select
        self.field_names = []
        self.select_options = []

        # Interfaz gráfica
        self.create_interface()

    def create_interface(self):
        # Crear la interfaz gráfica
        self.left_frame = tk.Frame(self.root)
        self.left_frame.grid(row=0, column=0, padx=10, pady=10, sticky="nsew")

        self.right_frame = tk.Frame(self.root)
        self.right_frame.grid(row=0, column=1, padx=10, pady=10, sticky="nsew")

        self.bottom_frame = tk.Frame(self.root)
        self.bottom_frame.grid(row=1, column=0, columnspan=2, padx=10, pady=10, sticky="nsew")

        # Crear campos de texto en la columna izquierda
        tk.Label(self.left_frame, text="Campos de Archivo de Entrada").grid(row=0, column=0, columnspan=2)
        self.text_fields = []
        for i in range(10):  # Número arbitrario de campos de texto
            entry = tk.Entry(self.left_frame)
            entry.grid(row=i+1, column=0, sticky="w", padx=5, pady=5)
            self.text_fields.append(entry)

        # Crear campos select en la columna derecha
        tk.Label(self.right_frame, text="Campos de Tabla MySQL").grid(row=0, column=0)
        self.select_field = tk.Listbox(self.right_frame, selectmode=tk.MULTIPLE, height=len(self.text_fields))
        self.select_field.grid(row=10, column=0, padx=5, pady=5)

        # Botón para seleccionar archivo de entrada
        tk.Button(self.bottom_frame, text="Leer archivo de entrada", command=self.read_input_file).pack()

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

                # Mostrar nombres de campos en campos de texto
                for i, field in enumerate(self.field_names):
                    self.text_fields[i].delete(0, tk.END)
                    self.text_fields[i].insert(0, field)

                # Conectar a la base de datos MySQL para obtener nombres de campos de la tabla
                try:
                    # connection = mysql.connector.connect(
                    #     host="tu_host",
                    #     user="tu_usuario",
                    #     password="tu_contraseña",
                    #     database="tu_base_de_datos"
                    # )
                    # cursor = connection.cursor()

                    db_obj = db.db.PsDb()
                    db_obj.connect()
                    table_name = 'ab_resistance'
                    result = db_obj.get_variable_names(table_name)
                    db_obj.disconnect()

                    variable_list = [dic['COLUMN_NAME'] for dic in result]

                    # self.db = pymysql.connect(
                    #     host='127.0.0.1',  # 'fgromano.com', #
                    #     port=3306,
                    #     user='fernando',  # 'root',
                    #     passwd='password',
                    #     db='psdb',
                    #     charset='utf8mb4',
                    #     autocommit=True,
                    #     cursorclass=pymysql.cursors.DictCursor)
                    # self.cursor = self.db.cursor()


                    # cursor.execute("SHOW COLUMNS FROM tu_tabla")
                    # self.select_options = [column[0] for column in cursor.fetchall()]

                    # Mostrar opciones en el campo select
                    self.select_field.delete(0, tk.END)
                    for option in variable_list:
                        self.select_field.insert(tk.END, option)

                # except mysql.connector.Error as err:
                #     print(f"Error al conectar a la base de datos: {err}")

                finally:
                    if db_obj.db.open:
                        db_obj.disconnect()

            except pd.errors.EmptyDataError:
                print("Error: El archivo está vacío.")
            except Exception as e:
                print(f"Error al leer el archivo: {e}")


if __name__ == "__main__":
    root = tk.Tk()
    app = ExcelToSqlConverter(root)
    root.mainloop()
