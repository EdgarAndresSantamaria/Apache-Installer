
function backupAPP (){

	dialog --title "backupAPP" --msgbox "A continuación se realizará un Backup de la BD" 0 0
	mkdir /tmp/archivosAppWeb
	mysqldump -uroot -peuiti web > /tmp/archivosAppWeb/web.sql
	cp /var/www /tmp/archivosAppWeb
	tar cvzf /home/$USER/web.tar.gz /tmp/archivosAppWeb
	dialog --title "backupAPP" --msgbox "Backup realizado con exito" 0 0
}
