pkg load database;
clc; 
clear all; 
close all;
uno=true;
dos= true;

while uno
  try
    fprintf("1.Jugar 2.Historial 3.Salir\n");
    x=(input('Elija:   '));
    if x>3||x==0|x<0
      fprintf("Elija una opcion correcta \n");
    endif
    if x==1
      while dos
        
        try
          ran=round(6*rand());
          fprintf("Dado 1: %d \n",ran);
          ran2=round(6*rand());
          fprintf("Dado 2: %d \n",ran2);
          sum=ran+ran2;
          
          if sum==8
            estado="Has ganaste";
            fprintf("%s \n", estado);
            fprintf("\n");
            params= cell(1,3);
            params{1,1}=ran;
            params{1,2}=ran2;
            params{1,3}=estado;
            conn = pq_connect(setdbopts('dbname','tarea1','host','localhost',
            'port','5432','user','postgres','password','jblue5queso'));
            N=pq_exec_params(conn, "insert into dados(d1, d2, estado) values($1,$2,$3);",params); %insertar datos en la tabla
            dos=false;
          endif
          if sum==7
            estado="Has perdido";
            fprintf("%s \n", estado);
            params= cell(1,3);
            params{1,1}=ran;
            params{1,2}=ran2;
            params{1,3}=estado;
            conn = pq_connect(setdbopts('dbname','tarea1','host','localhost',
            'port','5432','user','postgres','password','jblue5queso'));
            N=pq_exec_params(conn, "insert into dados(d1, d2, estado) values($1,$2,$3);",params); %insertar datos en la tabla
            dos=false;
          elseif sum==7&&sum==8
            estado="Sigue tirando";
            fprintf("%s \n", estado);
            fprintf("\n");
            params= cell(1,3);
            params{1,1}=ran;
            params{1,2}=ran2;
            params{1,3}=estado;
            conn = pq_connect(setdbopts('dbname','tarea1','host','localhost',
            'port','5432','user','postgres','password','jblue5queso'));
            N=pq_exec_params(conn, "insert into dados(d1, d2, estado) values($1,$2,$3);",params); %insertar datos en la tabla

            endif
          uno=false;
        catch
          fprintf("A ingresado un valor erroneo vuelva a intentarlo %d \n");
          msg = lasterror.message;
          fprintf(msg);
        end_try_catch
      endwhile

    endif
    if x==2
      conn = pq_connect(setdbopts('dbname','tarea1','host','localhost',
      'port','5432','user','postgres','password','jblue5queso'));
      N=pq_exec_params(conn, "Select * from dados;"); %insertar datos en la tabla
      disp(N)
      retry=false;
    endif
    
    if x==3
      retry=false;
    endif
  catch
    fprintf("A ingresado un valor erroneo vuelva a intentarlo %d \n");
    msg = lasterror.message;
    fprintf(msg);
  end_try_catch
endwhile