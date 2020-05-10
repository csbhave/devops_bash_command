#!/bin/bash
sudo apt install apache2 -y
echo "==================================================="
echo "Enter Website name:"
read site
echo "==================================================="
echo "Enter Port Number"
read port
echo "==================================================="
echo "Enter Deployment folder Name"
read deploy
echo "==================================================="
echo "Enter Server Name Or IP Address"
read servername
echo "==================================================="
sudo touch $PWD/$site
{
        echo "  <VirtualHost *:$port>"
        echo "  ServerAdmin webmaster@localhost"
        echo "  DocumentRoot /var/www/$deploy"
        echo "  ServerName $servername"
        echo "  ErrorLog ${APACHE_LOG_DIR}/error.log"
        echo "  CustomLog ${APACHE_LOG_DIR}/access.log combined"
        echo "  </VirtualHost>"
} | sudo  tee -a $site
sudo mv $PWD/$site $PWD/${site}.conf
sudo mv $PWD/${site}.conf  /etc/apache2/sites-available/
sudo ln -s /etc/apache2/sites-available/${site}.conf /etc/apache2/sites-enabled/${site}.conf
sudo service apache2 restart
echo "==================================================="
echo "Website has been Deployed Successfully on server : $servername:$port"
echo "==================================================="

