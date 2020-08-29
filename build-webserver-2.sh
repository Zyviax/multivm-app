# This script is solely for making a ssh connection between the webserver and the pdfserver,
# as it is run from apache, that 'user' needs the permissions to access pdfserver so its
# user is changed from www-data to vagrant. This was done earlier in provisioning with 
# cp /vagrant/apache2.conf /etc/apache2/apache2.conf

# We also copy pdfservers private key to where the user 'vagrant' can use it, and set appropriate permissions
cp /vagrant/.vagrant/machines/pdfserver/virtualbox/private_key ~/.ssh/pdf_private_key && chmod 0600 ~/.ssh/pdf_private_key

# Add pdfservers ip to known_hosts
ssh-keyscan 192.168.2.13 >> ~/.ssh/known_hosts

# This is done so that apache-php can connect to pdfserver without being asked about a password and/or unknown fingerprint