# Set up ssh connection with pdfserver
cp /vagrant/.vagrant/machines/pdfserver/virtualbox/private_key ~/.ssh/pdf_private_key && chmod 0600 ~/.ssh/pdf_private_key
ssh-keyscan 192.168.2.13 >> ~/.ssh/known_hosts
