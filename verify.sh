#!/bin/bash

# Caminho para os logs

LOGS_PATH="/var/logs_nginx"

# Relatorios dos logs

ONLINE_NGINX="$LOGS_PATH/status_online.log"
OFFLINE_NGINX="$LOGS_PATH/status_offline.log"

# DATA e HORA

DATA=$(date "+%Y-%m-%d")
TIME=$(date "+%H:%M:%S")

# Verificar se arquivos de log existem

if test -e $ONLINE_NGINX; 
then
	echo "O arquivo status_online.log encontrado"
else
        touch /var/logs_nginx/status_online.log
fi

if test -e $OFFLINE_NGINX; 
then
	echo "O arquivo status_offline.log encontrado"
else
	touch /var/logs_nginx/status_offline.log
fi

# Verificar se o serviço se encontra ativo

if systemctl is-active -q nginx; 
then
       echo "$DATA - $TIME - Nginx - Status: ONLINE" >> "$ONLINE_NGINX"
       echo "Nginx encontra-se em execução"
else
       echo "$DATA - $TIME - Nginx - Status: OFFLINE" >> "$OFFLINE_NGINX"
       echo "Nginx encontra-se fora de serviço"
fi       

