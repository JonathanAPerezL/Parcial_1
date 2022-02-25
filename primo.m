pkg load database;
clc; 
clear all; 
close all;

retry= true;
while retry
  try
    fprintf("Elija una opcion: 1. Saber si un numero es primo o compuesto,   2. Historial)");
    i=(input ("\n Opcion a elegir: "));
    if i>3||i<0
      fprintf("\n Numero erroneo, vuelva a ingresar: ");
    endif
      if i==1
        num=input("Ingrese el numero a verificar: ")
        n=0;
        Es='';
        for x=1:num
        r=rem(num,x);
        if r==0;
          n=n+1;
        endif
        endfor
        if n==2
          fprintf("Este numero es primo \n");
          Es='Es un numero primo';
        else
            fprintf("Este numero es compuesto \n");
            Es='Es compuesto';
        endif
        %Conectar con PGADMIN
        conn = pq_connect(setdbopts('dbname','tarea1','host','localhost',
        'port','5432','user','postgres','password','jblue5queso'));
        params=cell(1,2);
        params{1,1}=num;
        params{1,2}=Es;
        N=pq_exec_params(conn, "insert into primo(num, Es) values($1,$2);",params); %insertar datos en la tabla
        %Texto
        save('primo.txt','num', 'Es','-ascii');

    endif
    if i==2
       conn = pq_connect(setdbopts('dbname','tarea1','host','localhost',
       'port','5432','user','postgres','password','jblue5queso'));
       N=pq_exec_params(conn, "Select * from primo;");%historial de la tabla
       disp(N);
       retry=false;
    endif
   catch
      fprintf("Solo se permiten valores numericos, vuelva a selecionar \n");
      msg = lasterror.message;
      fprintf(msg);
    end_try_catch
 endwhile