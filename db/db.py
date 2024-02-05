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
            host='127.0.0.1',  # 'fgromano.com', #
            port=3306,
            user='fernando',  # 'root',
            passwd='password',  # 'Orgullovalor', #
            db='psdb',
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

    # Devuelve los nombres de las columnas de una tabla
    def get_variable_names_table(self, table):
        sql = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS " \
              "WHERE " \
              "TABLE_SCHEMA = 'psdb' " \
              "AND " \
              "TABLE_NAME = '" + table + "';"

        self.cursor.execute(sql)
        Response = self.cursor.fetchall()

        return Response

    # Devuelve los nombres de las columnas de una tabla
    def get_variable_names_db(self):
        sql = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS " \
              "WHERE " \
              "TABLE_SCHEMA = 'psdb' "

        self.cursor.execute(sql)
        Response = self.cursor.fetchall()

        return Response

    # Devuelve los datos de tabla summary en psdb
    def summary_get(self, pag):
        already_displayed = 5 * pag
        sql = "SELECT * FROM psdb.summary" \
              "ORDER BY summmary_id " \
              "LIMIT " + str(already_displayed) + ", 5;"

        self.cursor.execute(sql)
        Response = self.cursor.fetchall()

        # for isolate in Response:
        #     isolate["isolate_info"] = isolate['isolate_id'] + "/"
        #     isolate['strain_id']            

        return Response

    # Devuelve los datos de un aislado concreto mediante isolated_id
    def isolated_id(self, isolated_id):
        sql = "SELECT * FROM psdb.summary" \
              "ORDER BY summmary_id " \
              "WHERE isolated_id = '" + isolated_id + "';"

        print('SQL query: ', sql)
        self.cursor.execute(sql)
        Response = self.cursor.fetchall()

        return Response

        # Devuelve los datos de películas
    # def movies_post(self, pag, campos):
    #     already_displayed = 5*pag

    #     logger.info("NOTA: ", campos)

    #     sql = "SELECT title_akas.id AS id,"\
    #             "title_akas.title AS titulo,"\
    #             "title_basics.genres AS genero,"\
    #             "title_basics.endYear AS anho,"\
    #             "title_ratings.averageRating AS nota,"\
    #             "title_basics.runtimeMinutes AS duracion, "\
    #             "title_akas.titleId AS titleId "\
    #             "FROM title_akas "\
    #             "JOIN title_basics "\
    #             "ON title_akas.titleId = title_basics.tconst "\
    #             "JOIN title_ratings "\
    #             "ON title_ratings.tconst = title_basics.tconst"

    #     # if campos para WHERE
    #     if len(campos[0]) > 0: 
    #         sql=sql+" HAVING"
    #         filter = campos[0]

    #         words = 0
    #         for a in filter:
    #             # if position > 0:
    #             #     sql=sql+" AND "
    #             if (a == 'genero' and len(filter[a])>0):
    #                 # words = 0
    #                 for word in filter[a].split(','):
    #                     if words > 0:
    #                         sql=sql+" AND "
    #                     sql=sql+" "+ a + " LIKE '%"+ word +"%'"
    #                     words =+ 1
    #             if (a == 'nota'):
    #                 if (words > 0):
    #                     sql=sql+" AND "

    #                     logger.info("NOTA 2: ", word)

    #                 sql=sql+" "+ a + " " + filter[a][0]+ filter[a][-3:-1]

    #             position =+ 1

    #      # if campos para ORDER BY
    #         if len(campos[1]) > 0: 
    #             sql=sql+" ORDER BY"
    #             order = campos[1]

    #             for a in order:
    #                 if a in ['anho', 'nota', 'titulo']:
    #                     sql=sql+" "+ a +" "+ order[a]
    #             sql=sql+", id"                

    #         else:
    #             sql=sql+" ORDER BY id"

    #     sql=sql+" LIMIT " + str(already_displayed) + ", 5;"

    #     logger.debug('SQL: ', sql)

    #     self.cursor.execute(sql)
    #     Response = self.cursor.fetchall()

    #     for movie in Response:
    #         movie["url"] = "https://www.imdb.com/title/" + movie['titleId'] + "/"
    #         movie.pop('id')

    #     return Response
