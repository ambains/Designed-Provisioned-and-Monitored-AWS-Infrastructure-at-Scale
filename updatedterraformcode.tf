

# TODO: Designate a cloud provider, region, and credientials

provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA3Q76G473RASM377D"
  secret_key = "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"
}

# Define the VPC ID and subnet ID

variable "vpc_id" {
default = "vpc-0c338b063c1daa3fa"
}
variable "subnet_id" {
default = "subnet-0bc0f94da27a5fef2"
}


# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2

# Define the EC2 instances
resource "aws_instance" "udacity_t2" {
  count = 4
  ami = "ami-0c94855ba95c71c99"
  instance_type = "t2.micro"
  subnet_id = var.subnet_id
  vpc_security_group_ids = [aws_security_group.udacity.id]
  tags = {
    Name = "Udacity T2"
  }
}

# TODO: provision 2 m4.large EC2 instances named Udacity 


resource "aws_instance" "udacity_m4" {
  count = 2
  ami = "ami-0c94855ba95c71c99"
  instance_type = "m4.large"
  subnet_id = var.subnet_id
  vpc_security_group_ids = [aws_security_group.udacity.id]
  tags = {
    Name = "Udacity M4"
  }
}
# defining the iam role to control access for the lambda function 

resource "aws_iam_role" "lambda_role" {
name   = "lambda_role"
assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "lambda.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

# define the iam policy to manage the lambda function

resource "aws_iam_policy" "iam_policy_for_lambda" {
 
 name         = "aws_iam_policy_for_terraform_aws_lambda_role"
 path         = "/"
 description  = "AWS IAM Policy for managing aws lambda role"
 policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": [
       "logs:CreateLogGroup",
       "logs:CreateLogStream",
       "logs:PutLogEvents"
     ],
     "Resource": "arn:aws:logs:*:*:*",
     "Effect": "Allow"
   }
 ]
}
EOF
}

# attaching iam role and iam policy for the lambda role

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
 role        = aws_iam_role.lambda_role.name
 policy_arn  = aws_iam_policy.iam_policy_for_lambda.arn
}

# create a zip of Python Application

data "archive_file" "zip_the_python_code" {
  type        = "zip"
  source_dir  = "/Users/amrita/Desktop/lambdafunction"
  output_path = "${path.module}/greet_lambda.py.zip"
}

# add aws_lambda_function 

resource "aws_lambda_function" "terraform_lambda_func" {
filename = "/Users/amrita/Desktop/lambdafunction/greet_lambda.py.zip"
function_name                  = "lambda_role"
role                       = aws_iam_role.lambda_role.arn
handler                    = "greet_lambda.lambda_handler"
runtime                        = "python3.8"
depends_on                     = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}


# Define the security group

resource "aws_security_group" "udacity" {
  name_prefix = "udacity"
  vpc_id = var.vpc_id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "instance_name" {
  type = string
}


 




