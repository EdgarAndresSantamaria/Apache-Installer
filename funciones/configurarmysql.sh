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

function configurarmysql(){

	dialog --backtitle "Proyecto" --title "Aplicación Web"   --msgbox "Se configurará MySQL ,primero comprobaremos si esta instalado" 0 0
	instaladoMySQL
	# Comprobamos el resultado... si el resultado es 1 quiere decir que ya está instalado, si es 0 entonces 	no está instalado
	if test $? -eq 0
	then 

			dialog --msgbox "primero debe instalar MySQL" 0 0
			
	else	
		dialog --msgbox "la configuración comenzará en un momento" 0 0
		###Ahora llamamos al script en mysql que nos cambia la contraseña
		echo $RUTA
		scriptSql="$RUTA/archivos/conf_mysql.sql"
	
		dialog --inputbox  "Introduzca su contraseña actual de MySQL" 0 0 2>/tmp/cVieja.txt
		dialog --inputbox  "Introduzca su nueva contraseña de MySQL" 0 0 2>/tmp/cNueva.txt
		contrasena=$(sudo cat /tmp/cVieja.txt)
		contrasenaNueva=$(sudo cat /tmp/cNueva.txt)
		rm /tmp/cVieja.txt
		rm /tmp/cNueva.txt

		sudo sed s/$contrasena/$contrasenaNueva/ $scriptSql > /tmp/conf_mysql.sql
		cp /tmp/conf_mysql.sql $scriptSql
		mysql -u root --password=$contrasena < $scriptSql
		if test $? -eq 0; 
		then
			dialog --backtitle "Configurar MySQL"   --msgbox "El password se a cambiado correctamente" 0 0
		else
			dialog --backtitle "Configurar MySQL"   --msgbox "A surgido un error al tratar de cambiar la contraseña" 0 0
		fi	
	fi
}
