#!/usr/bin/bash


# parametros configuraveis
device=/org/freedesktop/UPower/devices/battery_BAT1	#upower -e lista os dispositivos do seu notebook
limiteMin=30
limiteMax=50

# para uso do script
percent=`upower -i ${device} | grep percentage | cut -d: -f2 | tr '%' ' ' ` 
discharging=`upower -i ${device} | grep state | grep discharging | wc -l`
texto='Carregando...'
alerta=''
tempo=`upower -i ${device} | grep 'time to empty' | cut -d: -f2`
exibir=0

# enviando para o arquivo .out que foi definido na crontab
echo "Bateria:${percent}%"
echo "discharging:$discharging"

# processamento do script
if [ "$discharging" -eq 1 ]
then
	texto="Descarregando...${tempo}"
	if [ "$percent" -lt "$limiteMax" ]; then exibir=1; fi
	if [ "$percent" -lt "$limiteMin" ]; then alerta='AVISO IMPORTANTE - '; fi
else
	if [ "$percent" -lt "$limiteMin" ]; then exibir=1; fi	
fi
if [ "$exibir" -eq 1 ]; then notify-send "${alerta}Bateria:${percent}%" "$texto"; fi
