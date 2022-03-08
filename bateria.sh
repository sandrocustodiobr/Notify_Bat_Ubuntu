#!/usr/bin/bash

# parametros configuraveis
device=/org/freedesktop/UPower/devices/battery_BAT1	# upower -e lista os dispositivos do seu notebook
limiteMin=30						# abaixo do minimo se torna IMPORTANTE
limiteMax=50						# abaixo do maximo exibe as mensagens
limiteCritico=18					# abaixo do qual o aviso passa a ser critico

# para uso do script
percent=`upower -i ${device} | grep percentage | cut -d: -f2 | tr '%' ' '` 
discharging=`upower -i ${device} | grep state | grep discharging | wc -l`
tempo=`upower -i ${device} | grep 'time to empty' | cut -d: -f2`
hora=`date +%H:%M`
exibir=0
alerta=''
timeout=3000

# processamento do script
if [ "$discharging" -eq 1 ]
then
	texto="${hora}  Descarregando, restam${tempo}"
	if [ "$percent" -lt "$limiteMax" ]; then exibir=1; fi
	if [ "$percent" -lt "$limiteMin" ]; then alerta='AVISO IMPORTANTE - '; timeout=30000; fi
	if [ "$percent" -lt "$limiteCritico" ]; then timeout=180000; fi
else

	texto="${hora}  Carregando..."
	if [ "$percent" -lt "$limiteCritico" ]; then exibir=1; fi	
fi

# notificando (mostrando o aviso)
if [ "$exibir" -eq 1 ]; then `notify-send -t ${timeout} "${alerta}Bateria:${percent}%" "$texto"`; fi
