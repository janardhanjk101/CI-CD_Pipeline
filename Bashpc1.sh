#!/bin/bash

#janardhanchettabelji

# Update the system package lists and upgrade installed packages
sudo apt update && sudo apt upgrade -y

# Install necessary utilities
sudo apt install -y curl unzip software-properties-common

# Update package lists again to ensure latest metadata
sudo apt update

# Install OpenJDK 17 (required for Jenkins to run)
sudo apt install openjdk-17-jre -y

# Verify Java installation
java -version

# Update package lists again (optional but recommended)
sudo apt update -y

# Install required dependencies for adding external repositories
sudo apt install -y curl gnupg

# Add Jenkins GPG key to verify package authenticity
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

# Add Jenkins repository to the system package sources
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/" | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package lists to recognize newly added Jenkins repository
sudo apt update -y

# Install Jenkins
sudo apt install -y jenkins

# Update package lists again to ensure latest updates
sudo apt update

# Install Docker
sudo apt install docker.io -y

# Switch to root user to modify user groups (required for Jenkins and Docker)
sudo su -

# Add Jenkins user to Docker group (allows Jenkins to run Docker commands)
usermod -aG docker jenkins

# Add Ubuntu user to Docker group (optional, for general Docker access)
usermod -aG docker ubuntu

# Restart Docker service to apply group changes
systemctl restart docker

# Add Ansible repository and install Ansible (used for automation and deployments)
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible

# Ensure Jenkins and Ubuntu users have Docker permissions
sudo su -
usermod -aG docker jenkins
usermod -aG docker ubuntu

# Restart Docker service again to finalize changes
systemctl restart docker

# Print final status messages
echo "Jenkins, Docker, and Ansible have been installed and configured successfully!"
