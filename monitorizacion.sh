#!/bin/bash

#Creacion de etiqueta Article
echo "<article>" > pc.txt

#Creacion de encabezado para los datos de la maquina
echo "<h2>Estado de la maquina</h2>" >> pc.txt

#Encabezado y comando para ver el uso de la cpu
echo "<h3>Estado de CPU</h3>" >> pc.txt
top -n 1 | head -n 3 | tail -n 1 >> pc.txt

#Encabezado y comando para ver los procesos
echo "<h3>Estado de CPU</h3>" >> pc.txt
top -n 1 | head -n 3 | tail -n 1 >> pc.txt

#Encabezado para ver
echo "<h3>Estado de CPU</h3>" >> pc.txt
top -n 1 | head -n 3 | tail -n 1 >> pc.txt
echo "<h3>Estado de CPU</h3>" >> pc.txt
top -n 1 | head -n 3 | tail -n 1 >> pc.txt
echo "<h3>Estado de CPU</h3>" >> pc.txt
top -n 1 | head -n 3 | tail -n 1 >> pc.txt
echo "<h3>Estado de CPU</h3>" >> pc.txt
top -n 1 | head -n 3 | tail -n 1 >> pc.txt
echo "<h3>Estado de CPU</h3>" >> pc.txt
top -n 1 | head -n 3 | tail -n 1 >> pc.txt
echo "</article>" > pc.txt