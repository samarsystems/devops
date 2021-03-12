
Terraform is one of the most popular Infrastructure as Code tools.

Terraform Templates for Samar System

Terraform Command :

The Terraform init command is used to initialize a working directory containing Terraform configuration files. 


The terraform plan command is used to create an execution plan.

The terraform show command is used to provide human-readable output from a state or plan file. 

The terraform apply command is used to apply the changes required to reach the desired state of the configuration.

The terraform validate command validates the configuration files in a directory.

Validate runs checks that verify whether a configuration is syntactically valid and internally consistent, regardless of any provided variables or existing state.

The terraform destroy command is used to destroy the Terraform-managed infrastructure. 

A provider in Terraform is responsible for the lifecycle of a resource: create, read, update, delete. An example of a provider is AWS, Azure, Google Cloud.


Backend Config
To store my terraform state I will be using S3.

VPC
Amazon VPC is a service that lets you launch AWS resources in a logically isolated virtual network that hold all our infrastructure.

Internet Gateway
We need an internet gateway to give internet access to the load balancer and to the Fargate subnets, so they can download the docker image.

Route table
We need a route table to describe the route for certain CIDR blocks.For security reasons, we have two route tables a public route table that routes traffic to the internet gateway, and a second route table that routes traffic to a NAT Gateway. 

Nat Gateway 
We have Nat Gateway which is highly available AWS managed service that makes it easy to connect to the Internet within a private subnet in VPC. 

Subnets
We have created four subnets. There will be two subnets for the load balancer and two subnets for the ECS tasks to be placed in.

Security groups
For our application, we will create four security groups, two for the load balancer for Java and angular and two for the ECS tasks.

We have assigned rules to these security groups. The load balancer will need access from anywhere on ports 80 and 443. The ECS task security group needs to allow traffic from the load balancer to the port that the docker container will run on.


NACLs
This section isn't necessary but is an added layer of security. 
Network access control lists (NACLs) control access in and out of the subnets. The thing to remember with NACLs is they're stateless. This means that return traffic must be explicitly allowed by rules.

Let's create an NACL for our load balancer subnets and a different NACL for the ECS task subnets.

Application Load Balancer, target group and listeners
We need to an application load balancer to route traffic to the ECS tasks and manage the load across all the ECS tasks. We have http and https listeners.

A target group tells a load balancer direct traffic ECS containers.A listener is a process that checks for connection requests, using the protocol and port that you configure and the listener rules that you define for a listener determine how the load balancer routes requests to the targets groups.

I will also be pointing a Route 53 hosted zone record to the load balancer to use https and give a better-looking URL. 

Certificate
We have created a certificate using ACM so that we can enable https on our load balancer.

IAM
We need to create an IAM role for the ECS service and task to assume.


ECS (Elastic Container Service) is AWS's container orchestration service.  

There are two deployment options that can be used, EC2 and Fargate.

With EC2 deployments, you need to manage the number of EC2 instances that are required for your container.

Fargate is a serverless compute engine provided by AWS. This means the servers that your containers are launched on are managed by AWS. All you need to do is specify the CPU and memory your container will use and AWS will provision an appropriate amount of compute resource.

ECS cluster
An Amazon ECS cluster is a logical grouping of tasks or services.

Task definition
A task definition is required to run Docker containers in Amazon ECS. The Docker image to use with each container in your task. How much CPU and memory to use with each task or each container within a task. 

ECS service
An Amazon ECS service enables you to run and maintain a specified number of instances of a task definition simultaneously in an Amazon ECS cluster.

Elastic Container Registry
ECR for managing our Docker container images, ECR scans images for a broad range of operating system vulnerabilities.

Auto-scaling
ECS Cluster Auto Scaling (CAS) is a new capability for ECS to manage the scaling of EC2 Auto Scaling Groups.

ECS provides the two metrics, ECSServiceAverageCPUUtilization and ECSServiceAverageMemoryUtilization, which you can use for the auto-scaling policies.



