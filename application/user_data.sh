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

#sudo touch /usr/share/tomcat/bin/setenv.sh
#sudo chmod 777 /usr/share/tomcat/bin/setenv.sh
#sudo echo "JAVA OPTS=\"\$JAVA_OPTS"\" >> /usr/share/tomcat/bin/setenv.sh
#sudo echo "JAVA_OPTS=\"\$JAVA_OPTS -Durl=${aws_db_endpoint}"\" >> /usr/share/tomcat/bin/setenv.sh
#sudo echo "JAVA_OPTS=\"\$JAVA_OPTS -Dbucket=${s3_bucket_name}"\" >> /usr/share/tomcat/bin/setenv.sh
#sudo echo "JAVA_OPTS=\"\$JAVA_OPTS -DdbName=${aws_db_name}"\" >> /usr/share/tomcat/bin/setenv.sh
#sudo echo "JAVA_OPTS=\"\$JAVA_OPTS -Dusername=${aws_db_username}"\" >> /usr/share/tomcat/bin/setenv.sh
#sudo echo "JAVA_OPTS=\"\$JAVA_OPTS -Dpassword=${aws_db_password}"\" >> /usr/share/tomcat/bin/setenv.sh
