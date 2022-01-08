# Amazon Linux 2 with AWS CLI / ECS CLI tools and Terraform
This image is based on [Amazon Linux 2](https://hub.docker.com/_/amazonlinux) and also has the [AWS CLI](https://aws.amazon.com/cli/) tools, [ECS CLI](https://docs.aws.amazon.com/cli/latest/reference/ecs/index.html) tools, [python3](https://www.python.org/download/releases/3.0/) / pip3 and [Terraform](https://www.terraform.io) installed.

## Usage
This image is designed to be run in interactive mode with a bash shell. This will allow you to configure the AWS CLI to connect to your AWS account and use Terraform as an environment orchastration tool.

### Building the Docker image
```bash
docker image build -t jmshum/aws-terraform-tools .
```

### Running the Docker image
```bash
docker container run --rm -it jmshum/aws-terraform-tools bash
```
Verify the AWS CLI tool.
```bash
aws --version
```
Verify the ECS CLI tool.
```bash
ecs-cli --version
```
Run the following after the container is running to configure the AWS CLI tool.
```bash
aws configure
```
Once AWS CLI is configured, you can use Terraform to orchastrate your AWS cloud environment.
```bash
terraform -version
```

---

## Example Usage
### AWS EC2 instance list
```shell
$ aws ec2 describe-instances
```
### Terraform
```shell
$ terraform fmt
$ terraform validate
$ terraform init
$ terraform plan
$ terraform apply
```
(main.tf example)
```json
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.71"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0a1eddae0b7f0a79f" #Amazonlinux 2 Kernel 5.10 64-bit ARM
  instance_type = "t4g.nano"

  tags = {
    Name = "Terraform-Example-Instance"
  }
}
```