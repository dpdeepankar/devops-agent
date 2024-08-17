# Use the latest Ubuntu LTS as the base image
FROM ubuntu:22.04

# Install essential dependencies for Terraform and other tools
RUN apt update \
    # Install wget to download files from the web
    && apt install -y wget \
    # Install unzip to extract zip files
    && apt install -y unzip \
    # Install vim for text editing
    && apt install -y vim \
    # Install openssh-client for SSH operations
    && apt install -y openssh-client \
    # Install OpenJDK 11 runtime environment required by Jenkins
    && apt install -y openjdk-11-jre \
    # Install curl for transferring data with URLs
    && apt install -y curl \
    # Install gnupg for handling GPG keys
    && apt install -y gnupg \
    # Install lsb-release for getting Linux distribution info
    && apt install -y lsb-release \
    # Install sudo to allow executing commands as another user
    && apt install -y sudo

# Download the latest version of Terraform from the official HashiCorp website
RUN wget https://releases.hashicorp.com/terraform/1.9.4/terraform_1.9.4_linux_amd64.zip

# Unzip the downloaded Terraform binary
RUN unzip terraform_1.9.4_linux_amd64.zip

# Move the Terraform binary to a directory in your system's PATH
RUN mv terraform /usr/local/bin/

# Install Ansible from the official Ansible PPA (Personal Package Archive)
RUN apt install -y software-properties-common \
    # Add the Ansible PPA to get the latest version of Ansible
    && add-apt-repository --yes --update ppa:ansible/ansible \
    # Install Ansible
    && apt install -y ansible

# Add the Jenkins repository and key for installation
RUN wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
RUN echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
RUN apt-get update
# Install Jenkins
RUN apt-get install -y jenkins

# Set the default command to run Jenkins
CMD ["jenkins"] 
