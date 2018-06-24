function configurarApache(){
#cambiamos puerto listen a 8080
grep 8080 /etc/apache2/ports.conf
if test $? != 0
then
	sudo sed 's/80/8080/' /etc/apache2/ports.conf > /tmp/ports.conf #con este comando cambia donde pone 80 por 8080
	sudo mv /tmp/ports.conf /etc/apache2/ports.conf
fi
echo "http://localhost:8080/ debería funcionar y localhost no!"
#Ahora cambiamos etc/apache2/sites-available/000-default.conf
grep 8080 /etc/apache2/sites-available/000-default.conf
if test $? != 0
then
	sudo sed s/80/8080/ /etc/apache2/sites-available/000-default.conf > /tmp/000-default.conf #primero cambiamos el puerto a 8080
	sudo sed s/webmaster@localhost/euiti@ehu.eus/ /tmp/000-default.conf > /tmp/000-default.conf1 #Segundo cambiamos el email
	#sed 's/\/some\/UNIX\/path/\/a\/new\/path/g' files
	sudo sed 's/\/var\/www\/html/\/var\/www/' /tmp/000-default.conf1 > /tmp/000-default.conf2 #Tercero cambiamos el path
	sudo mv /tmp/000-default.conf2 /etc/apache2/sites-available/000-default.conf
	sudo mv /var/www/html/index.html /var/www/index.html

	#Por último borramos los archivos innecesarios
	sudo rmdir /var/www/html
	sudo rm /tmp/000-default.conf
	sudo rm /tmp/000-default.conf1

	dialog --title "Configurar Apache" --msgbox "Apache a sido configurado correctamente" 0 0
else
	dialog --msgbox "Apache ya esta configurado" 0 0	
fi
}




