function restaurarAPP() {
	dialog --title "restaurar BD" --msgbox "A continuación se resturará la BD" 0 0
	tar xzvf /home/$USER/web.tar.gz
	cp /tmp/archivosAppWeb /var/www
	mysql -uroot -peuiti < /var/www/web.sql
	dialog --title "restaurar BD" --msgbox "La BD se restauró correctamente" 0 0
}
