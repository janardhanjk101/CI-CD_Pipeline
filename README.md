# CI/CD Pipeline Setup with Jenkins, Docker, and Ansible

## Architecture Overview

### 1. Development (PC 1 - Windows)
- Write Node.js code in **VS Code**.
- Push code to **GitHub**.

### 2. CI/CD Server (PC 2 - Vagrant Ubuntu)
- **Jenkins**: Automates the CI/CD pipeline.
- **Docker**: Runs build/test containers.
- **Ansible**: Deploys the app to the deployment server.

### 3. Deployment Server (PC 3 - Vagrant Ubuntu)
- Hosts the **Node.js web application**.
- Runs the containerized app (if using Docker) or serves the app directly.

## CI/CD Workflow

1. **Developer Pushes Code** → GitHub.
2. **Jenkins (PC 2) Triggers Build**:
   - Pulls code from GitHub.
   - Runs tests inside a **Docker container**.
   - Builds and packages the app.
3. **Ansible Deploys to PC 3**:
   - Copies build artifacts or Docker images.
   - Starts the application on PC 3.

## Setup Instructions

### Step 1: Run the Bash Script
Execute the `Bashpc1.sh` to set up Jenkins, Docker, and Ansible.

### Step 2: Access Jenkins
Visit: `http://YOUR_PC2_IP:8080` and complete the setup.

### Step 3: Install Required Jenkins Plugins
- **Git**
- **Docker Pipeline**
- **SSH Pipeline Steps**
- **Pipeline**
- **Ansible**

### Step 4: Copy Ansible Playbook and Inventory
Copy `deploy.yml` and `hosts.ini` to Jenkins workspace:

```bash
sudo cp deploy.yml /var/lib/jenkins/workspace/jenkinscickvagrant/
sudo cp hosts.ini /var/lib/jenkins/workspace/jenkinscickvagrant/
```

### Step 5: Configure SSH Authentication
Generate SSH keys on **PC 2 root and Jenkins user**:

```bash
ssh-keygen
```

Copy the **public key (`id_rsa.pub`)** of both **root** and **jenkins** users from **PC 2**.
Paste them into **PC 3** under `/home/user/.ssh/authorized_keys`.

```bash
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
```

### Step 6: Configure Jenkins Pipeline

#### Pipeline Configuration:

- **Definition**: Pipeline script from SCM
- **SCM**: Git
- **Repository URL**: `https://github.com/janardhanjk101/CICKprojectusingvagrant.git`
- **Credentials**: None
- **Branches to build**: `*/main`
- **Script Path**: `Jenkinsfile`
- **Lightweight checkout**: Enabled

