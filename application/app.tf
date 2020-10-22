provider "aws" {
  version = "~> 2.0"
  profile = "${var.profile}"
  shared_credentials_file = "~/.aws/credentials"
  region = "${var.region}"
}


# create the VPC
resource "aws_vpc" "My_VPC" {
  cidr_block           = var.vpcCIDRblock
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"
tags = {
    Name = "${var.vpcName}"
}
}
# end resource

# create the Subnet

resource "aws_subnet" "My_VPC_Subnet1" {
  vpc_id                  = "${aws_vpc.My_VPC.id}"
  cidr_block              = var.subnetCIDRblock1
  availability_zone       = "us-east-1a"
tags = {
   Name = "${var.vpcName}-1"
}
}

resource "aws_subnet" "My_VPC_Subnet2" {
  vpc_id                  = "${aws_vpc.My_VPC.id}"
  cidr_block              = var.subnetCIDRblock2
  availability_zone       = "us-east-1b"
tags = {
   Name = "${var.vpcName}-2"
}
}

resource "aws_subnet" "My_VPC_Subnet3" {
  vpc_id                  = "${aws_vpc.My_VPC.id}"
  cidr_block              = var.subnetCIDRblock3
  availability_zone       = "us-east-1c"
tags = {
   Name = "${var.vpcName}-3"
}
}
# end resource


# Create the Internet Gateway
resource "aws_internet_gateway" "My_VPC_GW" {
 vpc_id = "${aws_vpc.My_VPC.id}"
 tags = {
        Name = "${var.vpcName}-Internet Gateway"
}
}
# end resource

# Create the Route Table
resource "aws_route_table" "My_VPC_route_table" {
 vpc_id = "${aws_vpc.My_VPC.id}"
 tags = {
        Name = "${var.vpcName}-Route Table"
}
}
# end resource

# Create the Internet Access
resource "aws_route" "My_VPC_internet_access" {
  route_table_id         = "${aws_route_table.My_VPC_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.My_VPC_GW.id}"
}
# end resource


# Associate the Route Table with the Subnet
resource "aws_route_table_association" "My_VPC_association1" {
  subnet_id      = "${aws_subnet.My_VPC_Subnet1.id}"
  route_table_id = "${aws_route_table.My_VPC_route_table.id}"
} # end resource

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "My_VPC_association2" {
  subnet_id      = "${aws_subnet.My_VPC_Subnet2.id}"
  route_table_id = "${aws_route_table.My_VPC_route_table.id}"
} # end resource

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "My_VPC_association3" {
  subnet_id      = "${aws_subnet.My_VPC_Subnet3.id}"
  route_table_id = "${aws_route_table.My_VPC_route_table.id}"
} # end resource


resource "aws_security_group" "application" {
  name              = "${var.SGApplication}"
  description       = "Security Group to host web application"
  vpc_id            = "${aws_vpc.My_VPC.id}"

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "${var.aws_security_group_protocol}"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "${var.aws_security_group_protocol}"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "${var.aws_security_group_protocol}"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "${var.aws_security_group_protocol}"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "database" {
  name              = "${var.SGDatabase}"
  description       = "Security Group for database"
  vpc_id            = "${aws_vpc.My_VPC.id}"
}

resource "aws_security_group_rule" "database_rule" {
   from_port                     = 5432
   to_port                       = 5432
   protocol                      = "${var.aws_security_group_protocol}"
   type                          = "ingress"
   source_security_group_id      = "${aws_security_group.application.id}"
   security_group_id             = "${aws_security_group.database.id}"
}


resource "aws_dynamodb_table" "dynamoDB_Table" {
  name                        = "${var.dynamoDB_name}"
  hash_key                    = "${var.dynamoDB_hashKey}"
  write_capacity              = "${var.dynamoDB_writeCapacity}"
  read_capacity               = "${var.dynamoDB_readCapacity}"

  attribute {
    name = "${var.dynamoDB_hashKey}"
    type = "S"
  }
}


data "aws_availability_zones" "available" {
    state = "available"
}

data "aws_ami" "ami" {
    most_recent = "${var.most_recent}"
    owners = ["${var.dev_id}"]
}

resource "aws_instance" "ec2_instance" {
  ami                       = "${data.aws_ami.ami.id}"
  instance_type             = "${var.instance_type}"
  disable_api_termination   = "${var.disable_api_termination}"
  availability_zone         = "${data.aws_availability_zones.available.names[0]}"
  key_name                  = "${var.key_name}"
  iam_instance_profile      = "${aws_iam_instance_profile.my_iam_instance_profile.name}"

  ebs_block_device {
    device_name               = "${var.device_name}"
    volume_size               = "${var.volume_size}"
    volume_type               = "${var.volume_type}"
    delete_on_termination     = "${var.delete_on_termination}"
  }

  tags = {
    Name = "EC2_for_web"
  }

  vpc_security_group_ids      = ["${aws_security_group.application.id}"]
  associate_public_ip_address = true
  source_dest_check           = false
  subnet_id                    = "${aws_subnet.My_VPC_Subnet1.id}"
  depends_on                  = [aws_db_instance.my_rds,aws_s3_bucket.my_s3_bucket,aws_vpc.My_VPC,aws_subnet.My_VPC_Subnet1,aws_subnet.My_VPC_Subnet2,aws_subnet.My_VPC_Subnet3]
  user_data                   = "${templatefile("user_data.sh",
                                      {
                                        s3_bucket_name  = "${var.s3_bucket}",
                                        aws_db_endpoint = "${aws_db_instance.my_rds.endpoint}",
                                        aws_db_name     = "${aws_db_instance.my_rds.name}",
                                        aws_db_username = "${aws_db_instance.my_rds.username}",
                                        aws_db_password = "${aws_db_instance.my_rds.password}",
                                        aws_region      = "${var.region}",
                                        aws_profile     = "${var.profile}"
                                      })}"
}


resource "aws_s3_bucket" "my_s3_bucket" {
  bucket                = "${var.s3_bucket}"
  acl                   = "${var.s3_acl}"
  force_destroy         = "${var.s3_force_destroy}"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
      }
    }
  }

  tags = {
    Name        = "${var.s3_bucket_name}"
  }

  lifecycle_rule {
    id                    = "${var.s3_lifecycle_id}"
    enabled               = "${var.s3_lifecycle_enabled}"

    transition {
      days                = "${var.s3_lifecycle_transition_days}"
      storage_class       = "${var.s3_lifecycle_transition_storage_class}"
    }
  }
}

resource "aws_iam_policy" "WebAppS3" {
  name        = "WebAppS3"
  description = "A Upload policy"
  depends_on = ["aws_s3_bucket.my_s3_bucket"]
  policy = <<EOF
{
          "Version" : "2012-10-17",
          "Statement": [
            {
              "Sid": "AllowGetPutDeleteActionsOnS3Bucket",
              "Effect": "Allow",
              "Action": ["s3:PutObject",
                "s3:GetObject",
                "s3:DeleteObject",
                "s3:GetBucketAcl",
                "s3:GetObjectAcl",
                "s3:GetObjectVersionAcl",
                "s3:ListAllMyBuckets",
                "s3:ListBucket"],
              "Resource": ["${aws_s3_bucket.my_s3_bucket.arn}","${aws_s3_bucket.my_s3_bucket.arn}/*"]
            }
          ]
        }
EOF
}

resource "aws_iam_role" "EC2-CSYE6225" {
  name = "EC2-CSYE6225"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_instance_profile" "my_iam_instance_profile" {
  name = "my_iam_instance_profile"
  role = "${aws_iam_role.EC2-CSYE6225.name}"
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.EC2-CSYE6225.name
  policy_arn = aws_iam_policy.WebAppS3.arn
}

resource "aws_db_instance" "my_rds" {
  name                  = "${var.db_name}"
  allocated_storage     = "${var.db_allocated_storage}"
  engine                = "${var.db_engine}"
  instance_class        = "${var.db_instance}"
  multi_az              = "${var.db_multi_az}"
  identifier            = "${var.db_identifier}"
  username              = "${var.db_username}"
  password              = "${var.db_password}"
  db_subnet_group_name  = "${aws_db_subnet_group.rds-subnet.name}"
  publicly_accessible   = "${var.db_publicly_accessible}"
  vpc_security_group_ids= ["${aws_security_group.database.id}"]
  skip_final_snapshot   = "${var.db_skip_final_snapshot}"
}

resource "aws_db_subnet_group" "rds-subnet" {
  name              = "rds-subnet"
  subnet_ids        = ["${aws_subnet.My_VPC_Subnet1.id}","${aws_subnet.My_VPC_Subnet2.id}","${aws_subnet.My_VPC_Subnet3.id}"]
}

resource "aws_s3_bucket_public_access_block" "aws_s3_block" {
  bucket = aws_s3_bucket.my_s3_bucket.id

  block_public_acls   = true
  block_public_policy = true
  restrict_public_buckets = true
  ignore_public_acls = true
}




