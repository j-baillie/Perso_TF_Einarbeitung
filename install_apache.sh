#! /bin/bash
hostname=$(hostname)
TS=$(date +"%Y-%m-%d %H:%M:%S")
echo $hostname
sudo echo " $TS - entered user_data block" >> /home/ubuntu/userdata.proof
sudo apt-get update
sudo apt-get install -y apache2
sudo snap install aws-cli --classic
sudo systemctl start apache2
sudo systemctl enable apache2
echo "<h1>Deployed via Terraform - Host $hostname</h1>" | sudo tee /var/www/html/index.html
sudo mv /var/www/html/BAK.index.html /var/www/html/BAK.index.html.BAK
sudo aws s3 cp s3://bjo-source-bucket/index.php /var/www/html/index.html