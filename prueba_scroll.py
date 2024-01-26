import tkinter as tk
from tkinter import ttk

class ScrollableTextFieldApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Scrollable Text Fields")

        # Variable que controla la cantidad de campos de texto
        self.num_text_fields = 50

        # Crear un canvas para contener la barra de desplazamiento y la columna de campos de texto
        self.canvas = tk.Canvas(root)
        self.canvas.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)

        # Barra de desplazamiento vertical
        scrollbar = ttk.Scrollbar(root, orient=tk.VERTICAL, command=self.canvas.yview)
        scrollbar.pack(side=tk.RIGHT, fill=tk.Y)

        # Configurar el canvas para desplazarse con la barra
        self.canvas.configure(yscrollcommand=scrollbar.set)
        self.canvas.bind("<Configure>", self.on_canvas_configure)

        # Frame para contener los campos de texto
        self.frame = ttk.Frame(self.canvas)
        self.canvas.create_window((0, 0), window=self.frame, anchor="nw")

        # Lista para almacenar los campos de texto
        self.text_fields = []

        # Columna de campos de texto
        for i in range(self.num_text_fields):
            entry = tk.Entry(self.frame, width=20)
            entry.grid(row=i, column=0, padx=10, pady=5, sticky="w")
            self.text_fields.append(entry)

        # Hacer que el canvas se expanda automáticamente
        self.canvas.bind("<Configure>", self.on_canvas_configure)

    def on_canvas_configure(self, event):
        # Configurar el tamaño del canvas cuando cambia el tamaño de la ventana
        self.canvas.configure(scrollregion=self.canvas.bbox("all"))

if __name__ == "__main__":
    root = tk.Tk()
    app = ScrollableTextFieldApp(root)
    root.mainloop()