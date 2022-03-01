#!/bin/bash

echo "<article>" > pc.txt
echo "<h2>Estado de la maquina</h2>" >> pc.txt
echo "<h3>Estado de CPU</h3>" >> pc.txt
top -n 1 | head -n 3 | tail -n 1 >> pc.txt
