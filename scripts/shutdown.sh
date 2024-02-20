#!/bin/bash
# Shutdown.sh
# Autor: Evaristo B. Rocha <evaristo.rocha@gmail.com>
# Fone:(62)99425-6837
# Script para desligamento automatica dos Container e Maquinas Virtuais
#---------------------------------------------------------------------
#Definindo Variável LOG
#-------------------------------
data=`date +%F-%T`
dir_log="/etc/scripts/log"
if [ ! -d "$dir_log" ];then
	mkdir -p $dir_log;
fi

log="$dir_log/shutdown_errors_($data).log"
#Definindo Variavel de VMs
#---------------------------
VMLIST=$(sudo qm list |grep running | tr -s " " "#" |cut -d\# -f2)
WAIT=$(sudo qm list |grep running | tr -s " " "#" |cut -d\# -f2|wc -l)

# Definindo Variavel de Container
#---------------------------------
CTLIST=$(sudo pct list |grep running |tr -s " " "#" |cut -d\# -f1 )
CWAIT=$(sudo pct list |grep running |tr -s " " "#" |cut -d\# -f1|wc -l)

# Desligando as Maquinas Virtuais
#--------------------------------
for i in $VMLIST; do
	echo "###################################"|tee -a $log
	echo "# Desligando VM $i...		#"|tee -a $log
	echo "###################################"|tee -a $log
	sudo qm shutdown $i; &>>$log
done

# Desligando Container
#---------------------------------
for c in $CTLIST; do
	echo "################################################" |tee -a $log
	echo "# Desligando CT $c...			     #" |tee -a $log
	echo "################################################" |tee -a $log
	sudo pct shutdown $c; &>>$log
done

# Removendo Container do Contador
#--------------------------------
while [ $CWAIT -gt 0 ]; do
	CTLIST=$(sudo pct list |grep running |tr -s " " "#" |cut -d\# -f1);
	[ c"$CTLIST" = "c" ] && [ $CWAIT -eq 0 ] && break
		CWAIT=$(($CWAIT-1))
		sleep 60
	done
# Removendo Maquinas Virtuais do Contador
#----------------------------------------
while [ $WAIT -gt 0 ]; do
	VMLIST=$(sudo qm list | grep running | tr -s " " "#" |cut -d\# -f2);
	[ x"$VMLIST" = "x" ] && [ $WAIT -eq 0 ] && break
		WAIT=$(($WAIT-1))
		sleep 60
	done

echo "################################################" |tee -a $log
echo "# Em execução => Container:$CWAIT VMs:$WAIT  ###" |tee -a $log
echo "################################################" |tee -a $log


if [ $WAIT -eq 0 ] && [ $CWAIT -eq 0 ]; then
       	#sudo qm stop all 30 & sudo pct stop all 30
	echo "################################################" |tee -a $log
	echo "#  Desligando Servidor Proxmox...		     #" |tee -a $log
	echo "################################################" |tee -a $log
	sudo /usr/sbin/shutdown -h now &>>$log
fi
