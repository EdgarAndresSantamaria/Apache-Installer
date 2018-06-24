
function instaladoPHPP() {
#Comprueba a ver si están instalados los módulos PHP principales
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

function instaladoPHPM() {
#Comprueba a ver si están instalados los módulos PHP de MySQL
estado=$(aptitude show php-mysql | grep "Estado: instalado")
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

function configurarPHP(){
dialog --backtitle "Proyecto" --title "Aplicación Web" \
--msgbox "Esta opción hará lo siguiente:\n\n\
#Instala los módulos PHP para MySQL, comprueba si ya están instalados, y sino los instala" 10 50 
#comprobar si esta instalado el módulo
instaladoPHPP 
if test $? -eq 0
        then 
	dialog --msgbox "la instalación de los módulos PHP para MySQL comenzará en breve\n" 0 0	
	#instalar módulos PHP
	sudo apt install php libapache2-mod-php
	sudo apt install php-mysql
	dialog --msgbox "los módulos PHP han sido instalados.\n" 0 0	

else

	instaladoPHPM
	if test $? -eq 0
        then 
		dialog --msgbox "la instalación comenzará en breve\n" 0 0
		#instalar módulos PHP
		sudo apt install php-mysql
		dialog --msgbox "los módulos PHP para MySQL han sido instalados.\n" 0 0	

	else
	#Si el paquete está instalado entonces se envía el mensaje
	dialog --msgbox "Ya tienes instalado los paquetes PHP para MySQL\n" 0 0	
	fi
fi
}

