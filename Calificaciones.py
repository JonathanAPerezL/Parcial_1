from matplotlib import pyplot as plt
import psycopg2
import numpy as np
from scipy import stats
from tabulate import tabulate

def  post(x,y,z, a,b,c,d,e,f,g):
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
    cursor.execute("INSERT INTO calificaciones(n1, n2, n3,n4,n5, media, moda, mediana, desviacion, varianza) VALUES (%s, %s, %s, %s, %s,%s, %s, %s, %s, %s);", (x, y, z, a,b,c,d,e,f,g))
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
    cursor.execute("SELECT * from calificaciones;")
    print(tabulate(cursor, headers=["ide", "n1", "n2", "n3","n4","n5", "media", "moda", "mediana", "desviacion", "varianza"], tablefmt="orgtbl", numalign ="center"))

while True:
    try:
        print("Elija una opcion: (1. Registro de calificaciones,   2.Historial,   3.Salir)")
        x=int(input("Elija la opcion:\n"))
        if x>3 or x<=0:
            print("Valor ingresado fuera del rango del menu.\n")
        elif x==1:
            estado=""
            n1=int(input("Ingrese la primer nota: "))
            n2=int(input("Ingrese la segunda nota: "))
            n3=int(input("Ingrese la tercera nota: "))
            n4=int(input("Ingrese la cuarta nota: "))
            n5=int(input("Ingrese la quinta nota: "))
            notas=[n1,n2,n3,n4,n5]
            media=np.mean(notas)
            mediana=np.median(notas)
            moda=np.percentile(notas,75)
            desviacion=np.std(notas)
            varianza=np.var(notas)
            print("La media es: ", media)
            print("La mediana es: ", mediana)
            print("La moda es: ", moda)
            print("La desviacion es: ", desviacion)
            print("La varianza es: ", varianza)
            post(n1, n2, n3,n4,n5, media, moda, mediana, desviacion, varianza)
        elif x==2:
            ret()
        elif x==3:
            break
    except Exception as e:
        print("\n A ingresado un valor o Caracter no valido por favor, ingrese una opcion correcta:\n")
        print(repr(e))

exit(0)