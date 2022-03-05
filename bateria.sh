#!/usr/bin/bash
#PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin

device=/org/freedesktop/UPower/devices/battery_BAT1	#upower -e lista os dispositivos
percent=`upower -i ${device} | grep percentage | cut -d: -f2 | tr '%' ' ' ` 
discharging=`upower -i ${device} | grep state | grep discharging | wc -l`
texto='Carregando...'
alerta=''
tempo=`upower -i ${device} | grep 'time to empty' | cut -d: -f2`
exibir=0

#/usr/bin/notify-send "Bateria:${percent}%"
echo "Bateria:${percent}%"
echo "discharging:$discharging"

if [ "$discharging" -eq 1 ]
then
	texto="Descarregando...${tempo}"
	exibir=1
	if [ "$percent" -lt 30 ]; then alerta='AVISO IMPORTANTE - '; fi
else
	if [ "$percent" -lt 30 ]; then exibir=1; fi	
fi

if [ "$exibir" -eq 1 ]; then notify-send "${alerta}Bateria:${percent}%" "$texto"; fi
