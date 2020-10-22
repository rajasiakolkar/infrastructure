#! /bin/sh
sudo echo url=${aws_db_endpoint} >> /etc/profile.d/envvariable.sh
sudo echo "export url=${aws_db_endpoint}" >> /etc/profile.d/envvariable.sh
sudo echo s3_bucket_name=${s3_bucket_name} >> /etc/profile.d/envvariable.sh
sudo echo "export s3_bucket_name=${s3_bucket_name}" >> /etc/profile.d/envvariable.sh
sudo echo db_name=${aws_db_name} >> /etc/profile.d/envvariable.sh
sudo echo "export db_name=${aws_db_name}" >> /etc/profile.d/envvariable.sh
sudo echo username=${aws_db_username} >> /etc/profile.d/envvariable.sh
sudo echo "export username=${aws_db_username}" >> /etc/profile.d/envvariable.sh
sudo echo password=${aws_db_password} >> /etc/profile.d/envvariable.sh
sudo echo "export password=${aws_db_password}" >> /etc/profile.d/envvariable.sh
chmod +x /etc/profile.d/envvariable.sh
