#!/bin/bash
##Instalación y Mantenimiento de una Aplicación Web
#Importar funciones de otros ficheros

RUTA=`pwd`
export RUTA

#includes
. $RUTA/funciones/apacheInstalar.sh  #poner source y poner . es lo mismo
. $RUTA/funciones/configurarApache.sh
. $RUTA/funciones/testearApache.sh
. $RUTA/funciones/PHPinstalar.sh
. $RUTA/funciones/configurarPHP.sh
. $RUTA/funciones/testearPHP.sh
. $RUTA/funciones/instalarmysql.sh
. $RUTA/funciones/configurarmysql.sh
. $RUTA/funciones/testearMySQL.sh
. $RUTA/funciones/instalarAPP.sh
. $RUTA/funciones/backupAPP.sh
. $RUTA/funciones/restaurarAPP.sh

function instaladoDialog() {
#Comprueba a ver si está instalado el paquete dialog
#estado=$(aptitude show dialog | grep "Estado: instalado")
aptitude show dialog | grep "Estado: instalado"
#test -n $estado 
if test $? -ne 0  #si no es vacio (!=0)==false  si es vacio 0==true
then
	#si vacio....
	#no esta instalado
	return 0
	
else
	#si no es vacio....
	#esta instalado
	return 1
	
fi
}
function salirppal()
{
	echo -e "¿Quieres salir del programa?(S/N)\n"
        read respuesta
	if [ $respuesta == "N" ] 
		then
			opcionMenuPpal=0
		
	else	
			echo "Programa terminado" #Fin del programa
			exit 0 #Fin del programa
	fi
}
### Comienzo del programa ###
 
instaladoDialog #no instalado==0 , instalado==1

if test $? -eq 0 
	then

		#Si el paquete no está instalado entonces se envía el mensaje
		echo "se instalará dialog"	
		sudo apt-get install dialog
		dialog --msgbox "dialog se instaló correctamente\n" 5 50

fi

DIALOG_CANCEL=1
DIALOG_ESC=255
HEIGHT=0
WIDTH=0

while true; do
  exec 3>&1

  selection=$(dialog \
    --backtitle "System Information" \
    --title "Menu" \
    --clear \
    --cancel-label "Exit" \
    --menu "Please select:" $HEIGHT $WIDTH 13 \
    "1" "Instalación de Apache" \
    "2" "Configuración de Apache" \
    "3" "Test de instalación Apache" \
    "4" "Instalación de PHP" \
    "5" "Configuración de PHP" \
    "6" "Test de instalación PHP" \
    "7" "Instalación de MySQL" \
    "8" "Configuración de MySQL" \
    "9" "Test de instalación MySQL"\
    "10" "Instalación de APP" \
    "11" "backup APP" \
    "12" "restaurar APP" \
    2>&1 1>&3)
  exit_status=$?
  exec 3>&-
  case $exit_status in
    $DIALOG_CANCEL)
      clear
      salirppal 
      ;;
    $DIALOG_ESC)
      clear
      salirppal 
      ;;
  esac
  case $selection in
        1) apacheInstalar ;;
	2) configurarApache ;;
	3) testearApache ;;
	4) instalarPHP ;;
	5) configurarPHP ;;
	6) testearPHP ;; #falta
	7) instalarmysql ;;
	8) configurarmysql ;;
	9) testearMySQL ;;
	10) instalarAPP ;;
	11) backupAPP ;;
	12) restaurarAPP ;;
    
 esac #Fin selección de acción especifica del usuario
done #Fin del bucle ppal

