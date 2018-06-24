function instaladoMySQL() {
#Comprueba a ver si está instalado el paquete apache2
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


function instaladoApache() {
#Comprueba a ver si está instalado el paquete apache2
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

function instaladoPHP() {
#Comprueba a ver si están instalados los módulos PHP
estado=$(aptitude show php | grep "Estado: instalado")
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



function testearPHP(){
dialog --backtitle "Proyecto" --title "Aplicación Web" \
--msgbox "Esta opción hará lo siguiente:\n\n\
#testear los módulos PHP, comprueba si apache y mysql ya está instalado y los módulos PHP" 10 50 

instaladoPHP #no instalado==0 , instalado==1

if test $? -eq 0 
	then

		#Si el paquete no está instalado entonces se envía el mensaje
		dialog --msgbox "para probar PHP debe instalar los módulos PHP" 0 0	
		return 0
	else
		instaladoMySQL
		if test $? -eq 0 
			then

				#Si el paquete no está instalado entonces se envía el mensaje
				dialog --msgbox "para probar PHP debe instalar los módulos mysql" 0 0	
				return 0
			else

				instaladoApache #no instalado==0 , instalado==1

				if test $? -eq 0 
				then

					#Si el paquete no está instalado entonces se envía el mensaje
					dialog --msgbox "para probar PHP debe instalar Apache" 0 0	
				return 0

				fi
		fi
fi

#buscar algun elemento que transmita en la direccion localhost:8080
lineas=$(grep 8080 /etc/apache2/ports.conf)

test -n $lineas 
if test $? -eq 0  #si no es vacio (!=0)==false  si es vacio 0==true
then
	#si vacio....
	#no esta bien configurado
	dialog --msgbox "existe un problema de configuracion de Apache, configurelo" 0 0
	return 0
	
fi

dialog --msgbox "todo correcto, en brebe comenzará el test, estamos configurandolo" 0 0
!/bin/bash
sudo cp $RUTA/archivos/test.php /var/www
sudo chmod 777 /var/www/test.php
#lanzar test en mozzila
firefox localhost:8080/test.php
dialog --msgbox "fin del test" 0 0
}
