# Designed-Provisioned-and-Monitored-AWS-Infrastructure-at-Scale
In this project, I planned, designed, provisioned and monitored infrastructure in AWS using industry-standard and open source tools. Terraform was used provision and configure AWS services.

The scenario was to create a schema of AWS infrastructure for a social media application for 50,000 single region users. Udacity_diagram_1 is a AWS schema with servers and Udacity_diagram_2 is a SERVERLESS architecture schematic including lambda functions, which are event triggered applications. 

After planning the architecture, the scenario was the client's estimated budgets fluctates from $8,000-$10,000, which is used for the intial cost estimate and this is calculated using the AWS calculator. 

The cost estimate is adjusted per client's estimated budget decreases to $6,500, which is included in the reduced cost estimate file. The one thing that can be adjusted is the capactity of storage in the database server. 

The cost estimate is adjusted again per client's estimated budget increases to 20K, which is included in the increased cost estimate file. The one thing that can be adjusted is the capacity of storage in the database server.

After the design and costs are determined for the social media application, terraform was used to provision AWS resources in one VPC. Refer to the file updatedterraform.tf file for the source code for the following AWS resources in AWS console:

AWS as the cloud provider
Use an existing VPC ID
Use an existing public subnet
4 AWS t2.micro EC2 instances named Udacity T2
2 m4.large EC2 instances named Udacity M4

