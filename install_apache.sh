#! /bin/bash
hostname=$(hostname)
echo $hostname
sudo echo "entered user_data block" >> /home/ubuntu/userdata.proof
sudo apt-get update
sudo apt-get install -y apache2
sudo snap install aws-cli --classic
sudo systemctl start apache2
sudo systemctl enable apache2
echo "<h1>Deployed via Terraform - Host $hostname</h1>" | sudo tee /var/www/html/index.html
mv /var/www/html/BAK.index.html.BAK
sudo aws s3 cp s3://bjo-wichtiger-bucket/index.php /var/www/html/index.html