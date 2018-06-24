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

function instalarPHP(){
dialog --backtitle "Proyecto" --title "Aplicación Web" \
--msgbox "Esta opción hará lo siguiente:\n\n\
#configura los módulos PHP principales, comprueba si ya están instalados los principales" 10 50 
#comprobar si esta instalado el módulo principal PHP
instaladoPHP 
if test $? -eq 0
then 

	dialog --msgbox "la instalación comenzará en breve\n" 0 0	
	#instalar módulos PHP
	sudo apt install php libapache2-mod-php
	dialog --msgbox "los módulos PHP  han sido instalados.\n" 0 0
	
else
	#Si el paquete no está instalado entonces se envía el mensaje
	dialog --msgbox "los módulos principales PHP están instalados\n" 0 0	
	
fi
}
