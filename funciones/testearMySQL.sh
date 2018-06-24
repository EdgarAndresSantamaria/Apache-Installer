function testearMySQL(){


	dialog --backtitle "Proyecto" --title "Aplicación Web"   --msgbox "Se comprobara que el servicio MySQL funciona correctamente" 0 0
	estado=$(sudo netstat -l | grep "localhost:mysql")
	#estado contiene la información de MySQL
	test -n $estado 
	if test $? -eq 0  #si no es vacio (!=0)==false  si es vacio 0==true
	then
		#si vacio....
		#no esta funcionando
		dialog --msgbox "mysql no funciona en condiciones prueba a configurarlo o instalarlo" 0 0
	
	else
		#si no  vacio....
		# esta funcionando
		dialog --msgbox "mysql  funciona correctamente" 0 0
	
	fi
}
