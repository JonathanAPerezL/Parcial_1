clc; 
clear all; 
close all;

retry= true;
media=45;
mediana=67;
moda=49;
desviacion=35;
varianza=76;


while retry
  try
    fprintf("Elija una opcion: (1.Registro de calificaciones,   2.Historial)");
    i=(input ("\n Opcion a elegir: "));
    if i>3||i<0
      fprintf("\n Numero erroneo, vuelva a ingresar: ");
    endif
    if i==1
      n1=(input('Ingrese la primer nota: '));
      n2=(input('Ingrese la segunda nota: '));
      n3=(input('Ingrese la tercera nota: '));
      n4=(input('Ingrese la cuarta nota: '));
      n5=(input('Ingrese la quinta nota: '));
      notas=['n1','n2','n3','n4','n5'];
      mean(notas)=media;
      median(notas)=mediana;
      mode(notas)=moda;
      std(notas,1)=desviacion;
      var(notas,1)=varianza;
      fprintf('La media es: %d \n', media);
      fprintf('La mediana es: %d \n', mediana);
      fprintf('La moda es: %d \n', moda);
      fprintf('La desviacion es: %d \n', desviacion);
      fprintf('La varianza es: %d \n', varianza);
      %Conectar con PGADMIN
      conn = pq_connect(setdbopts('dbname','tarea1','host','localhost',
      'port','5432','user','postgres','password','jblue5queso'));
      params=cell(1,10);
      params{1,1}=n1;
      params{1,2}=n2;
      params{1,3}=n3;
      params{1,4}=n4;
      params{1,5}=n5;
      params{1,6}=media;
      params{1,7}=mediana;
      params{1,8}=moda;
      params{1,9}=desviacion;
      params{1,10}=varianza;
      N=pq_exec_params(conn, "insert into calificaciones(n1, n2, n3,n4,n5, media, moda, mediana, desviacion, varianza) values($1,$2,$3,$4,$5,$6,$7,$8,$9,$10);",params); %insertar datos en la tabla
      %Texto
      save('calificiones.txt','n1', 'n2', 'n3','n4','n5', 'media', 'moda', 'mediana', 'desviacion', 'varianza','-ascii');

    endif
    if i==2
       conn = pq_connect(setdbopts('dbname','tarea1','host','localhost',
       'port','5432','user','postgres','password','jblue5queso'));
       N=pq_exec_params(conn, "Select * from calificaciones;");%historial de la tabla
       disp(N);
       retry=false;
    endif
 
  catch
      fprintf("Solo se permiten valores numericos, vuelava a selecionar %d \n");
      msg = lasterror.message;
      fprintf(msg);
    end_try_catch
 endwhile