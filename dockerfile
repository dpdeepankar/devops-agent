# Use the latest Ubuntu LTS as the base image
FROM ubuntu:22.04

# Install ddependencies for Terraform.
RUN apt update \
    && apt install -y wget \
    && apt install -y unzip \
    && apt install -y vim \
    && apt install -y openssh-client \
    && apt install -y openjdk-11-jre \
    && apt install -y curl \
    && apt install -y gnupg \
    && apt install -y lsb-release \
    && apt install -y sudo

# Download the latest version of Terraform from the official website
RUN wget https://releases.hashicorp.com/terraform/1.9.4/terraform_1.9.4_linux_amd64.zip

# Unzip the downloaded file:
RUN unzip terraform_1.9.4_linux_amd64.zip

# Move the terraform binary to a directory in your system's PATH.
RUN mv terraform /usr/local/bin/

RUN apt install -y software-properties-common \
&& add-apt-repository --yes --update ppa:ansible/ansible \
&& apt install -y ansible

# Add Jenkins repository and key
RUN wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
RUN echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
RUN apt-get update
RUN apt-get install -y jenkins
CMD ["jenkins"]
#CMD ["java", "-jar", "/usr/share/jenkins/jenkins.war"]