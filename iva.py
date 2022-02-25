import math

import psycopg2
from tabulate import tabulate
def  post(x,y,z):
    try:
        conexion = psycopg2.connect(
            host = "localhost",
            port = "5432",
            user = "postgres",
            password = "jblue5queso",
            dbname = "tarea1"
            )
    except:
        print("Sin Conexion Exitosa\n")
            
    cursor = conexion.cursor()
    cursor.execute("INSERT INTO ivas(precio, iva, total) VALUES (%s, %s, %s);", (x, y, z))
    conexion.commit()
    cursor.close()
    conexion.close()

def ret():
    try:
        conexion = psycopg2.connect(
            host = "localhost",
            port = "5432",
            user = "postgres",
            password = "jblue5queso",
            dbname = "tarea1"
            )
    except:
        print("Sin Conexion Exitosa\n")
    
    cursor = conexion.cursor()
    cursor.execute("SELECT * from ivas;")
    print(tabulate(cursor, headers=["ide", "precio", "iva", "total"], tablefmt="orgtbl", numalign ="center"))


while True:
    try:
        print("Elija una opcion: 1. Calcular iva y total del producto,   2. Historial,  3.Salir: ")
        x=int(input("Opcion a elegir: \n"))
        if x>3 or x<=0:
            print("Numero erroneo, vuelva a ingresar: \n")
        elif x==1:
            precio=float(input("Ingrese el precio del producto: "))
            iva= precio*0.12
            print("El IVA en el producto es de: ", iva)
            total=precio+iva
            print("El precio total es de: ", total)
            post(precio, iva, total)
        elif x==2:
            ret()
            break
        elif x==3:
            break

    except Exception as es:
        print("\n Ingreso un caracter y no un numero, vuelva a intentar:\n")
        print(repr(es))

exit(0)
