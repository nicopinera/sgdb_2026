import mysql.connector,os,random
from dotenv import load_dotenv
from tabulate import tabulate

FILE_ENV =os.path.join(os.path.dirname(os.path.dirname(__file__)),'.env')
FILE_CREACION_SQL =os.path.join(os.path.dirname(os.path.dirname(__file__)),'data','creacion_tablas.sql')
LIST_TABLAS = []
nombres = ["juan","pedro","nico","juli","coni","agus","dr cascote"]
apellido = ["ousmendi","messi","romero","yamal","cubarsi","martinez"]

def generar_conexion():
    """
    Genera la conexion con la base de datos
    """
    try:
        conexion = mysql.connector.connect(
            host=os.getenv('HOST'),
            user=os.getenv('USER'),
            password=os.getenv('PASSWORD'),
            database=os.getenv('DATABASE')
        )
        if conexion.is_connected():
            print("Conexion exitosa")
            return conexion
    except mysql.connector.Error as e:
        print("Error al conectar")
        return None

def limpiar_tablas(conexion):
    """Ejecuta una query para ver las tablas existentes"""
    cursor = conexion.cursor()
    cursor.execute("SET FOREIGN_KEY_CHECKS = 0;")
    cursor.execute("SHOW TABLES")
    tablas = cursor.fetchall()
    
    for (tabla_nombre,) in tablas:
        cursor.execute(f"DROP TABLE IF EXISTS {tabla_nombre}")
        print(f"Tabla {tabla_nombre} eliminada.")
    cursor.execute("SET FOREIGN_KEY_CHECKS = 1;")
    conexion.commit()
    cursor.close()

def generar_tablas(conexion):
    with open(FILE_CREACION_SQL,'r') as f:
        sql_script = f.read()
    
    cursor = conexion.cursor()
    
    sentencias = sql_script.split(';')
    
    for sentencia in sentencias:
        if sentencia.strip(): # Evita ejecutar strings vacíos
            try:
                cursor.execute(sentencia)
            except mysql.connector.Error as e:
                print(f"Error al ejecutar: {sentencia[:30]}... -> {e}")
    
    cursor.execute("SHOW TABLES")
    tablas = cursor.fetchall()
    
    for (tabla_nombre,) in tablas:
        LIST_TABLAS.append(tabla_nombre)
    
    conexion.commit()
    cursor.close()

def obt_datos_tabla(conexion,tabla):
    if tabla in LIST_TABLAS:
        cursor = conexion.cursor()
        cursor.execute(f"SELECT * FROM {tabla}")
        
        columnas = cursor.column_names
        datos = cursor.fetchall()
        
        print(f"-- Datos en {tabla} --")
        print(tabulate(datos,headers=columnas,tablefmt="grid"))
        cursor.close()
    else:
        print(f"Error: {tabla} No existe") 

def generar_personas(conexion,nroPersonas):
    cursor = conexion.cursor()
    for _ in range(nroPersonas):
        dni = random.randint(1,100)
        nom = random.choice(nombres)
        ap = random.choice(apellido)
        tel = random.randint(3510000000,3519999999)
        datos = (dni,nom,ap,tel,'notEmail@gmail.com','notDireccion')
        cursor.execute("""INSERT INTO persona (dni,nombre,apellido,telefono,email,domicilioActual)
                       VALUES (%s,%s,%s,%s,%s,%s)
                       """,datos)
    conexion.commit()
    cursor.close()

def main():
    
    load_dotenv(FILE_ENV)
    conexion = generar_conexion()
    
    if conexion:
        print("---"*10)
        print("Limpiando tablas existentes")
        limpiar_tablas(conexion)
        
        print("---"*10)
        print("Creando tablas")
        generar_tablas(conexion)
        
        print("---"*10)
        print("Generar Personas")
        generar_personas(conexion,20)
        
        print("---"*10)
        print("Persona")
        obt_datos_tabla(conexion,"persona")
    
    if 'conexion' in locals() and conexion.is_connected():
        conexion.close()
        print("Cierre conexion")
    

if __name__ == "__main__":
    main()