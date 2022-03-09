#!/bin/bash

echo "<!DOCTYPE html>" > informe.html
echo "<html lang=es>" >> informe.html
echo "<head>" >> informe.html
echo "<meta charset=\"utf-8\">" >> informe.html
echo "<title>Monitorizacion</title>" >> informe.html
echo "</head>" >> informe.html
echo "<body>" >> informe.html
echo "<section>" >> informe.html
echo "<h1>Informe de estado de las maquinas</h1>" >> informe.html
echo "<h4>Generado el `date`</h4><br>" >> informe.html
#Bucle for para repetir estas operaciones en cada una de las maquinas
for i in 1 2
do
echo "<article>" >> informe.html
#Incluimos etiqueta y extraemos el valor de i de la iteración usando el simbolo $
echo "<h2>Estado de la Maquina #$i</h3>" >> informe.html
echo "<h3>Estado de CPU</h3><br>" >> informe.html
echo "<pre>" >> informe.html
#SSH para ejecutar en la máquina remota,
#opción -t para forzar que la salida del comando top sea en mi terminal local (sino dará error)
#usuario@maquina para indicar en qué máquina se ejecutará el comando
#comando TOP para ver los procesos y uso de CPU, argumento "-n 1" para indicar que se ejecute una sola vez, ya que por defecto lo hará hasta que lo detengamos manualmente
# "|" para hacer uso de tuberias en linux, así le paso el resultado del comando de la izquierda como entrada del comando de la derecha
# "head" es un comando que sirve para guardar n primeras líneas de un texto (3 en este caso)
# "tail" es un comando que sirve para guardar n últimas líneas de un texto (1 en este caso), para así guardar únicamente la línea que indica el estado del CPU
ssh -t cliente$i@cliente$i.practica1.edu top -n 1 | head -n 3 | tail -n 1 >> informe.html
echo "</pre>" >> informe.html
echo "<br>" >> informe.html
echo "<h3>Estado de RAM</h3><br>" >> informe.html
echo "<pre>" >> informe.html
# "free" es un comando para ver el estado de la RAM y el SWAP en linux. El parámetro -m es para que lo muestre en megas, y -h es para que lo haga en bytes. Así lo mostrará en MegaBytes.
ssh cliente2@cliente2.practica1.edu free -mh >> informe.html
echo "</pre><br>" >> informe.html
echo "<h3>Lista de Procesos</h3><br>" >> informe.html
#guardo la salida de top temporalmente en el archivo "proc.list"
ssh -t cliente$i@cliente$i.practica1.edu top -n 1 > proc.list
#Elimino las primeras 6 líneas de ese texto proc.list para que me quede sólo la lista de procesos.
sed '1,6d' proc.list
echo "<pre>"
#Añado la lista de procesos a mi html
cat proc.list >> informe.html
echo "</pre><br>" >> informe.html
echo "<h3>Estado de los Discos Duros</h3><br>" >> informe.html
echo "<pre>" >> informe.html
# "df" sirve para ver el espacio libre y utilizado de los discos duros, el argumento -h es para que lo muestre en GB
ssh cliente$i@cliente$i.practica1.edu df -h >> informe.html
echo "</pre><br>" >> informe.html
echo "<h3>Estado de la Red</h3><br>" >> informe.html
echo "<pre>" >> informe.html
#El comando netstat es para ver el estado de la red
#El parámetro -p es para que muestre el programa que usa la conexión
#El parámetro -u es para que muestre las conexiones de tipo UDP
#El parámetro -t es para que muestre las conexiones de tipo TCP
#El parámetro -o es para que muestre los temporizadores
#El parámetro -n es para que muestre el número de puerto correspondiente
#El parámetro -a es para que muestre todas las conexiones abiertas (sino sólo muestra las activas en el momento)
ssh cliente$i@cliente$i.practica1.edu netstat -putona >> informe.html
echo "</pre><br>" >> informe.html
echo "</article>" >> informe.html
#Finalizamos el bucle FOR
done
echo "</section>" >> informe.html
echo "<footer><small>Copyright 2022</small></footer>" >> informe.html
echo "</body>" >> informe.html
#Terminamos de escribir el HTML
echo "</html>" >> informe.html
#Copiamos el HTML que generamos al directorio del servidor web Apache, reemplazando el existente si lo hay
cp informe.html /var/www/html/index.html
#Eliminamos el HTML local y la lista de procesos generada anteriormente
rm informe.html proc.list