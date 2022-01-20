## Amazon Linux 2 with AWS CLI tools including ECS-CLI, python3/pip3 and Terraform

## Build Example:
#   docker image build -t jmshum/aws-terraform-tools .

## Run Example:
#   docker container run --rm -it jmshum/aws-terraform-tools bash

## Configure AWS CLI:
#   aws configure

FROM amazonlinux:2

# Install tools (python3, vim)
RUN yum update -y && \
  yum install -y \
  python3 \
  vim \
  groff && \
  yum clean all && \
  rm -rf /var/cache/yum

# Install AWS CLI
RUN pip3 install awscli

# Install AWS ECS-CLI
RUN curl -o /usr/local/bin/ecs-cli https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-linux-amd64-latest && \
  chmod +x /usr/local/bin/ecs-cli

# Install Terraform 1.1.4 Arm64
RUN yum install -y wget unzip && \
  wget https://releases.hashicorp.com/terraform/1.1.4/terraform_1.1.4_linux_arm64.zip && \
  unzip terraform_1.1.4_linux_arm64.zip && \
  mv terraform /usr/local/bin/

WORKDIR /root