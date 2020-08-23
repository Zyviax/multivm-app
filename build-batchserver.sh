apt-get update
# apt-get install -y libspreadsheet-writeexcel-perl python3-uno unoconv # libreoffice-calc
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo systemctl restart sshd