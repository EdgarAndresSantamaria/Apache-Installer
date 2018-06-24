
function testearApache ()
{
	dialog --backtitle "Proyecto" --title "Aplicación Web" \
	--msgbox "Esta opción hará lo siguiente:\n\n\
	#se testeará el servicio y se lanzará una ventana de internet" 10 50 
	dialog --msgbox "reiniciar servicio web" 0 0
	#recargar servicio
	service apache2 reload
	dialog --msgbox "reiniciado el servicio con exito" 0 0
	#visualizar informacion de red

	dialog --msgbox "comprobaremos la configuración" 0 0
	#buscar algun elemento que transmita en la direccion localhost:8080
	lineas=$(grep 8080 /etc/apache2/ports.conf)

	test -n $lineas 
	if test $? -eq 0  #si no es vacio (!=0)==false  si es vacio 0==true
	then
		#si vacio....
		#no esta bien configurado
		dialog --msgbox "existe un problema de configuracion , configurelo" 0 0
		return 0
	
	fi
	

	dialog --msgbox "todo fue correcto ahora lanzaremos su servicio web" 0 0
	#lanzar test en firefox(por ejemplo)
	firefox localhost:8080
	dialog --msgbox "ha finalizado el test del servicio web apache" 0 0
	
}

