# Importación de paquetes externos al proyecto
# import sys
# sys.setdefaultencoding('utf-8')
import pymysql.cursors
from werkzeug.security import generate_password_hash
import sqlalchemy as db
import logging
from datetime import datetime

# Bloque para configurar el logger de Python, en el directorio Top: Python_debug.log
logger = logging.getLogger('Python_Log')
logger.setLevel(logging.DEBUG)
fh = logging.FileHandler('Python_debug.log')
fh.setLevel(logging.DEBUG)
logger.addHandler(fh)
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
fh.setFormatter(formatter)
logger.addHandler(fh)


# logger.debug('Debug Message')
# logger.info('Info Message')
# logger.warning('Warning')
# logger.error('Error Occurred')
# logger.critical('Critical Error')

class PsDb:
    # Conexion a la BBDD del servidor mySQL
    def connect(self):
        self.db = pymysql.connect(
            host='212.227.145.156',  # '127.0.0.1' # 'fgromano.com', #
            port=3306,
            user='fernando',  # 'root',
            passwd='Orgullovalor',  # 'password' # 'Orgullovalor',
            db='psdb_json',
            connect_timeout=600,
            charset='utf8mb4',
            autocommit=True,
            cursorclass=pymysql.cursors.DictCursor)
        self.cursor = self.db.cursor()

    # Desconexion de la BBDD del servidor mySQL
    def disconnect(self):
        self.db.close()

    # Autenticación del usuario usando JWT-flask
    def jwtAuth(self, username):
        sql = "SELECT * FROM arpbigidisba_users WHERE username = '" + username + "';"
        self.cursor.execute(sql)
        Response = self.cursor.fetchone()
        return Response

    # Obtención de datos del usuario a partir de su ID usando JWT-flask
    def jwtId(self, user_id):
        sql = "SELECT * FROM arpbigidisba_users WHERE user_id = '" + str(user_id) + "';"
        self.cursor.execute(sql)
        Response = self.cursor.fetchone()
        return Response

    # Devuelve los nombres de las tablas de una BDD
    def get_table_names_db(self, db):
        sql = "SHOW FULL TABLES FROM " + db + ";"

        self.cursor.execute(sql)
        Response = self.cursor.fetchall()

        return Response

    # Devuelve los nombres de las columnas de una tabla
    def get_variable_names_table(self, table):
        sql = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS " \
              "WHERE " \
              "TABLE_SCHEMA = 'psdb_json' " \
              "AND " \
              "TABLE_NAME = '" + table + "';"

        self.cursor.execute(sql)
        Response = self.cursor.fetchall()

        return Response

    # Devuelve los nombres de las columnas de toda la BDD
    def get_variable_names_db(self):
        sql = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS " \
              "WHERE " \
              "TABLE_SCHEMA = 'psdb_json' "

        self.cursor.execute(sql)
        Response = self.cursor.fetchall()

        return Response

    # Devuelve los datos de tabla summary en psdb
    def summary_get(self, pag):
        already_displayed = 5 * pag
        sql = "SELECT * FROM psdb_json.metadata_general" \
              "ORDER BY aislado_id " \
              "LIMIT " + str(already_displayed) + ", 5;"

        self.cursor.execute(sql)
        Response = self.cursor.fetchall()

        # for isolate in Response:
        #     isolate["isolate_info"] = isolate['isolate_id'] + "/"
        #     isolate['strain_id']            

        return Response

    # Devuelve los datos de un aislado concreto mediante isolated_id
    def isolated_id(self, isolated_id):
        sql = "SELECT * FROM psdb_json.metadata_general" \
              "ORDER BY isolate_id " \
              "WHERE isolate_id = '" + isolated_id + "';"

        print('SQL query: ', sql)
        self.cursor.execute(sql)
        Response = self.cursor.fetchall()

        return Response

    # Devuelve los nombres de loci de una de las tablas de validación en un listado
    def loci_list(self, table):
        sql = "SELECT locus FROM " + table + " " \
                                             "ORDER BY locus;" \

        print('SQL query: ', sql)
        self.cursor.execute(sql)
        response = self.cursor.fetchall()
        loci_list = []
        for locus in response:
            loci_list.append(locus['locus'])

        return loci_list

    def get_table_id(self, table):
        sql = "SELECT column_name FROM INFORMATION_SCHEMA.COLUMNS " \
              "WHERE TABLE_SCHEMA = 'psdb_json' " \
              "AND TABLE_NAME = '" + table + "' " \
                                             "AND COLUMN_KEY = 'PRI';"

        self.cursor.execute(sql)
        response = self.cursor.fetchone()
        column_name = response['column_name']

        return column_name

    def get_row_id(self, table, field, value):
        sql = "SELECT column_name FROM INFORMATION_SCHEMA.COLUMNS " \
              "WHERE TABLE_SCHEMA = 'psdb_json' " \
              "AND TABLE_NAME = '" + table + "' " \
                                             "AND COLUMN_KEY = 'PRI';"

        self.cursor.execute(sql)
        response = self.cursor.fetchone()
        column_name = response['column_name']

        sql = "SELECT " + column_name + " FROM " + table + " " \
                                                           "WHERE " + field + " = '" + str(value) + "';"

        self.cursor.execute(sql)
        response = self.cursor.fetchone()
        if response is None:
            row_id = None
        else:
            row_id = response[column_name]

        return row_id

    def get_value_byid(self, table, field):
        sql = "SELECT " + field + " FROM " + table + " WHERE " + field + " = '" + str(value) + "';"

        self.cursor.execute(sql)
        response = self.cursor.fetchone()

        return response

    def get_fk(self, table):
        sql = "SELECT REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME " \
              "FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE " \
              "WHERE REFERENCED_TABLE_SCHEMA = 'psdb_json' " \
              "AND REFERENCED_TABLE_NAME = '" + table + "';"

        self.cursor.execute(sql)
        response = self.cursor.fetchall()

        list_fk = {}
        for key in response:
            list_fk[key['TABLE_NAME']] = key['column_name']

        return response

    def count(self, table, field, value):
        sql = "SELECT COUNT(*) FROM " + table + " WHERE " + field + " = '" + str(value) + "';"

        self.cursor.execute(sql)
        response = self.cursor.fetchone()
        count = response['COUNT(*)']

        return count

    def insert_row(self, table, field, value):
        sql = "INSERT INTO " + table + " (" + field + ") VALUES ('" + str(value) + "');"

        self.cursor.execute(sql)
        response = self.cursor.fetchone()

        sql = "SELECT COUNT(*) FROM " + table + " WHERE " + field + " = '" + str(value) + "';"

        self.cursor.execute(sql)
        response = self.cursor.fetchone()
        if response['COUNT(*)'] == 1:
            return True
        else:
            return False
