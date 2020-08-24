apt-get update
apt-get install -y apache2 php libapache2-mod-php php-mysql
    
# Change VM's webserver's configuration to use shared folder.
# (Look inside test-website.conf for specifics.)
cp /vagrant/website.conf /etc/apache2/sites-available/

# Change apache config to change user from www-data to vagrant
cp /vagrant/apache2.conf /etc/apache2/apache2.conf

# activate our website configuration ...
a2ensite website

# ... and disable the default website provided with Apache
a2dissite 000-default

# Reload the webserver configuration, to pick up our changes
service apache2 reload
