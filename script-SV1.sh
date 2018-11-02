#!/bin/bash
echo script para el servidor 1 el cual tiene  los servicios de HTTP y DHCP
sleep 5
service iptables stop
mkdir /root/Escritorio/Arch_Originales
#HTTP
yum -y install httpd
#DHCP
yum -y install dhcp
echo paquetes instalados...
sleep 2
echo recuerda cambiar las IP
sleep 2
yum -y install git
mkdir /root/Escritorio/Mibackup
git clone https://github.com/LystSky/SV1-de-redes.git /root/Escritorio/Mibackup
cp /etc/httpd/conf/httpd.conf /root/Escritorio/Arch_Originales/
cp /etc/hosts /root/Escritorio/Arch_Originales/
cp /etc/dhcp/dhcpd.conf /root/Escritorio/Arch_Originales/
cp /etc/rsyslog.conf /root/Escritorio/Arch_Originales/
cat /root/Escritorio/Mibackup/httpd.bk > /etc/httpd/conf/httpd.conf
service httpd restart
cd /var/www
mkdir sitio
mkdir sitio2
touch sitio/index.html
touch sitio2/index.html
cat /root/Escritorio/Mibackup/index.bk > /var/www/sitio/index.html
cat /root/Escritorio/Mibackup/index.bk > /var/www/sitio2/index.html
cat /root/Escritorio/Mibackup/hosts.bk > /etc/hosts
service httpd restart
#DHCP*
cat /root/Escritorio/Mibackup/dhcpd.bk > /etc/dhcp/dhcpd.conf
service dhcpd restart
#NFS
yum -y install nfs-utils
yum -y install nfs-utils-lib
yum -y install portmap
#NFS
cd /home/
mkdir Almacen
mkdir Traspaso
service rpcbind restart
service nfs restart
#showmount -e 172.16.1.10
mount 172.16.1.10:/var/Programadores /home/Traspaso/
mount 172.16.1.10:/var/Analista /home/Almacen/
service rpcbind restart
service nfs restart
#RSYSLOG CLIENTE
cat /root/Escritorio/Mibackup/rsyslog.bk > /etc/rsyslog.conf
service rsyslog restart
