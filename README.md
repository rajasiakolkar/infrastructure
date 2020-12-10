## steps for importing certificate

Certificate can be uploaded using cli or console

###For console 
- Go to Certificate Manager
- Import a certificate
- Enter the certificate body, private key and certificate chain
- Certificate chain is the one which can be found in bundle
- Click next and submit, you must see that the status of the certificate is issued

###For cli follow the synopsis

 import-certificate
[--certificate-arn <value>]
--certificate <value>
--private-key <value>
[--certificate-chain <value>]
[--tags <value>]
[--cli-input-json | --cli-input-yaml]
[--generate-cli-skeleton <value>]

##Steps to run the Terraform configuration files
- Run "terraform init" command to initialize a working directory containing Terraform configuration files

- Run "terraform apply -var-file="vpc_var.tfvars" command to apply the changes required to reach the desired state of the configuration.
 
- We will see a message that Apply complete! 

- Run "terraform destroy" command to destroy the Terraform-managed infrastructure.