function instaladoPHP() {
#Comprueba a ver si están instalados los módulos PHP
aptitude show php | grep "Estado: instalado"
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



function instaladoPHPM() {
#Comprueba a ver si están instalados los módulos PHP de MySQL
aptitude show php-mysql | grep "Estado: instalado"
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



function instaladoApache() {
#Comprueba a ver si está instalado el paquete dialog
aptitude show apache2 | grep "Estado: instalado"
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



function instaladoMySQL() {
#Comprueba a ver si está instalado el paquete dialog
aptitude show mysql-server | grep "Estado: instalado"
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

function instalarAPP() {
dialog --backtitle "Proyecto" --title "Aplicación Web" \
--msgbox "Esta opción hará lo siguiente:\n\n\
#comprobaremos que los módulos esten instalados(mysql,apache y php)después importará la base de datos para la aplicación web y se generará una consulta web" 0 0 
	
#comprobar instalacion apache2
instaladoApache
# Comprobamos el resultado... si el resultado es 1 quiere decir que ya está instalado, si es 0 entonces no está instalado
if test $? -eq 0
then
	#Si el paquete no está instalado entonces se envía el mensaje
	dialog --title "Aplicación Web" --msgbox "debes instalar apache para continuar\n" 0 0	

else

	#comprobar instalacion mysql
	instaladoMySQL
	# Comprobamos el resultado... si el resultado es 1 quiere decir que ya está instalado, si 		es 0 entonces 	no está instalado
	if test $? -eq 0
	then 

			#Si el paquete no está instalado entonces se envía el mensaje
			dialog  --title "Aplicación Web" --msgbox "debes instalar MySQL para continuar\n" 0 0	
	
	else	
			#comprobar instalacion php
			instaladoPHP 
			if test $? -eq 0
			then 

				#Si el paquete no está instalado entonces se envía el mensaje
				dialog --title "Aplicación Web"  --msgbox "debes instalar PHP para continuar\n" 0 0	
	
			else
				#Si el paquete no está instalado entonces se envía el mensaje
				dialog --title "Aplicación Web"  --msgbox "todos los módulos principales  están instalados\n" 0 0 													
	
			fi
	fi
fi

dialog --title "Aplicación Web"  --msgbox "ahora comprobaremos las configuraciones\n" 0 0

#comprobar configuración apache2
grep 8080 /etc/apache2/ports.conf

if test $? != 0
then
	dialog --title "Aplicación Web"  --msgbox "configure apache\n" 0 0
else
	#comprobar configuración php
	instaladoPHPM
	if test $? -eq 0
        then 
		dialog --title "Aplicación Web"  --msgbox "configure php\n" 0 0
		
	fi

fi

dialog --title "Aplicación Web"  --msgbox "todo fue perfecto , procedemos con la gestion de la base de datos\n" 0 0
#Cargar base de datos
mysql -uroot -peuiti < $RUTA/archivos/web.sql
dialog --title "Aplicación Web"  --msgbox "por último generamos la consulta web\n" 0 0
#cargar consulta profesores
sudo cp `pwd`/archivos/consultaprofesores.php /var/www
dialog --title "Aplicación Web"  --msgbox "base de datos importada correctamente y servicio web listo para consulta\n" 0 0
}


