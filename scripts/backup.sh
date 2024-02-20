#!/bin/bash
# Criado: Evaristo Rocha- evaristo.rocha@gmail.com
# Data: 30-09-2022
# Função: Script que executa o backup das VMs localmente
# Informações: 

vzdump 100 102 103 104  --compress=zstd --mode snapshot --dumpdir /var/lib/vz/dump/ --prune-backups keep-last=3,keep-daily=7,keep-weekly=4,keep-monthly=11,keep-yearly=2  --mailto evaristo.rocha@gmail.com

#editar crontab /etc/pve/vzdump.cron
#0 22 * * * /etc/scripts/backup.sh
