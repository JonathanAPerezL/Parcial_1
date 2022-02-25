import math

import psycopg2
from tabulate import tabulate
from random import randint
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
    cursor.execute("INSERT INTO dados(d1, d2, estado) VALUES (%s, %s, %s);", (x, y, z))
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
    cursor.execute("SELECT * from dados;")
    print(tabulate(cursor, headers=["ide", "d1", "d2", "estado"], tablefmt="orgtbl", numalign ="center"))


while True:
    try:
        print("Elija una opcion: 1. Jugar o tirar,   2. Historial,  3.Salir: ")
        x=int(input("Opcion a elegir: \n"))
        if x>3 or x<=0:
            print("Numero erroneo, vuelva a ingresar: \n")
        elif x==1:
            ran=randint(1,6)
            ran2=randint(1,6)
            print("Dado 1: \n", ran)
            print("Dado 2: \n", ran2)
            sum=ran+ran2
            while True:
                if sum==8:
                    print("Has ganado \n")
                    estado="Gano"
                    post(ran,ran2,estado)
                    exit(0)
                if sum==7:
                    print("Has perdido \n")
                    estado="Perdio"
                    post(ran,ran2,estado)
                    exit(0)
                else:
                    print("Sigue tirando")
                    estado="Sigue jugando"
                    post(ran,ran2,estado)
                    break
        elif x==2:
            ret()
            break
        elif x==3:
            break

    except Exception as es:
            print("\n Ingreso un caracter y no un numero, vuelva a intentar:\n")
            print(repr(es))

exit(0)
