
function instaladoApache() {
#Comprueba a ver si está instalado el paquete dialog
estado=$(aptitude show apache2 | grep "Estado: instalado")
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


function apacheInstalar(){
dialog --backtitle "Proyecto" --title "Aplicación Web" \
--msgbox "Esta opción hará lo siguiente:\n\n\
#Instala el servidor web Apache, comprueba si ya está instalado, y sino lo instala" 10 50 
#Dialog para mostrar nuestros nombres

# Llamamos a la función
instaladoApache
# Comprobamos el resultado... si el resultado es 1 quiere decir que ya está instalado, si es 0 entonces no está instalado
if test $? -eq 0
then
	#Si el paquete no está instalado entonces se envía el mensaje
	dialog --msgbox "la instalación comenzará en breve\n" 5 60	
	sudo apt-get install apache2
	dialog --msgbox "Apache ha sido instalado.\n" 5 40	
	return 0

else

	#Si el paquete está instalado entonces se envía el mensaje
	dialog --msgbox "Ya tienes instalado el paquete apache2\n" 5 50	
	return 0
fi
}

