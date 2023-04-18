#!/bin/bash

# script pra rodar novamente o server automático em caso de crash
echo "Iniciando Servidor"

cd /home/server1305
mkdir -p logs

#configs necessárias para o Anti-rollback
ulimit -c unlimited
set -o pipefail

while true 		#repetir pra sempre
do
 	#roda o server e guarda o output ou qualquer erro no logs
	#PS: o arquivo antirollback_config deve estar na pasta do tfs	
	gdb --batch -return-child-result --command=antirollback_config --args ./otbr 2>&1 | awk '{ print strftime("%F %T - "), $0; fflush(); }' | tee "logs/$(date +"%F %H-%M-%S.log")"
	if [ $? -eq 0 ]; then							 
		echo "Exit code 0, guardando en 3 minutos..."	 #pra ser usado no backup do banco de dados
		sleep 180	#3 minutos						
	else											
		echo "Crash!! Reiniciando el servidor se reiniciara en 5 min (los archivos estan aguardado en los logs)"
		echo "si quieres cerrar el servidor precione CTRL + C..."		
		sleep 5										
	fi												
done;          