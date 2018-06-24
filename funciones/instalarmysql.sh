function instaladoMySQL() {
#Comprueba a ver si está instalado el paquete dialog
estado=$(aptitude show mysql-server | grep "Estado: instalado")
test -n $estado 
if test $? -eq 0  #si no es vacio (!=0)==false  si es vacio 0==true
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

function instalarmysql(){

	dialog --backtitle "Proyecto" --title "Aplicación Web"   --msgbox "Se instalara MySQL ,primero  	      	comprobaremos si esta instalado" 0 0
	instaladoMySQL
	# Comprobamos el resultado... si el resultado es 1 quiere decir que ya está instalado, si es 0 entonces 	no está instalado
	if test $? -eq 0
	then 

			dialog --msgbox "la instalación comenzará en un momento" 0 0
			sudo apt install mysql-server
			dialog --msgbox "MySQL ha sido instalado correctamente" 0 0
	
	else	
			dialog --msgbox "Ya estaba instalado...." 0 0
			return 0
	fi
	return 0
}

