import math

import psycopg2
from tabulate import tabulate
def  post(x,y):
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
    cursor.execute("INSERT INTO primo(num, Es) VALUES (%s, %s);", (x, y))
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
    cursor.execute("SELECT * from primo;")
    print(tabulate(cursor, headers=["ide", "num", "Es"], tablefmt="orgtbl", numalign ="center"))


while True:
    try:
        print("Elija una opcion: 1. Saber si un numero es primo o compuesto,   2. Historial,  3.Salir: ")
        x=int(input("Opcion a elegir: \n"))
        if x>3 or x<=0:
            print("Numero erroneo, vuelva a ingresar: \n")
        if x==1:
            num=int(input("Ingrese numero a comprobar: "))
            primo=True
            Es=""
            for i in range(2,num):
                if num%i==0:
                    print("Es un numero compuesto")
                    Es="Es compuesto"
                    primo=False
                    break
            if primo:
                print("Es un numero primo")
                Es="Es un numero primo"
            post(num, Es)
        elif x==2:
            ret()
            break
        elif x==3:
            break

    except Exception as es:
        print("\n Ingreso un caracter y no un numero, vuelva a intentar:\n")
        print(repr(es))

exit(0)
