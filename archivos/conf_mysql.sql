use mysql;
update user set authentication_string=PASSWORD('euiti') where user='root';
flush privileges;
\q
