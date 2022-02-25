pkg load database;
clc; 
clear all; 
close all;

retry= true;
while retry
  try
    fprintf("Elija una opcion: 1. Calcular iva y total del producto,   2. Historial)");
    i=(input ("\n Opcion a elegir: "));
    if i>3||i<0
      fprintf("\n Numero erroneo, vuelva a ingresar: ");
    endif
      if i==1
        precio=input("Ingrese el precio del producto: ")
        iva= precio*0.12;
        fprintf("El IVA en el producto es de: %d \n", iva)
        total=precio+iva;
        fprintf("El precio total es de: %d \n", total)
        %Conectar con PGADMIN
        conn = pq_connect(setdbopts('dbname','tarea1','host','localhost',
        'port','5432','user','postgres','password','jblue5queso'));
        params=cell(1,3);
        params{1,1}=precio;
        params{1,2}=iva;
        params{1,3}=total;
        N=pq_exec_params(conn, "insert into ivas(precio, iva, total) values($1,$2,$3);",params); %insertar datos en la tabla
        %Texto
        save('ivas.txt','precio', 'iva', 'total','-ascii');

    endif
    if i==2
       conn = pq_connect(setdbopts('dbname','tarea1','host','localhost',
       'port','5432','user','postgres','password','jblue5queso'));
       N=pq_exec_params(conn, "Select * from ivas;");%historial de la tabla
       disp(N);
       retry=false;
    endif
   catch
      fprintf("Solo se permiten valores numericos, vuelva a selecionar \n");
      msg = lasterror.message;
      fprintf(msg);
    end_try_catch
 endwhile
 
 