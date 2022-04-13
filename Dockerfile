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
  wget \
  unzip \
  less \
  groff && \
  yum clean all && \
  rm -rf /var/cache/yum

# Install AWS CLI v2
RUN wget https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip -O awscliv2.zip && \
  unzip awscliv2.zip && \
  ./aws/install

# Install AWS ECS-CLI
RUN curl -Lo /usr/local/bin/ecs-cli https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-linux-arm64-latest && \
  chmod +x /usr/local/bin/ecs-cli

# Install Terraform 1.1.8 Arm64
RUN wget https://releases.hashicorp.com/terraform/1.1.8/terraform_1.1.8_linux_arm64.zip && \
  unzip terraform_1.1.8_linux_arm64.zip && \
  mv terraform /usr/local/bin/

WORKDIR /root