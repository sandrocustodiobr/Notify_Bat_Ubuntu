# Notify_Bat_Ubuntu
Notificações sobre percenntual da bateria no Ubuntu com Gnome.

Use o arquivo contrab.txt para colocar na crontab do seu usuário. A única linha importante é que que não está comentada (com #).

E escolha a pasta do arquivo bateria.sh, pois o meu usei em /dados/bin. Isto deve ser ajustado na contrab.

No script bateria.sh podem ser configurados o caminho do "device" e os limites (limiteMin e limiteMax). Abaixo de limiteMin, é considerado "AVISO IMPORTANTE" e abaixo de limiteMax as notificações começam a aparecer na tela.
